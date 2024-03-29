//: [Previous](@previous)
import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "Joke API") {
    
    // MARK: - 에러가 발생할 수 있는 상황
    /// 1. dataTaskPublisher에서 URLError (연결문제, 유효하지않은 요청 등)
    /// 2. jokeID가 없을경우
    /// 3. JSON 디코딩이 실패 했을 경우
    /// 4. 알수없는 에러
    
    class DadJokes {
        
        // 1
        struct Joke: Codable {
            let id: String
            let joke: String
        }
        
        enum Error: Swift.Error, CustomStringConvertible {
            // 1
            case network
            case jokeDoesntExist(id: String)
            case parsing
            case unknown
            
            // 2
            var description: String {
                switch self {
                case .network:
                    return "Request to API Server failed"
                case .parsing:
                    return "Failed parsing response from server"
                case .jokeDoesntExist(let id):
                    return "Joke with ID \(id) doesn't exist"
                case .unknown:
                    return "An unknown error occrred"
                }
            }
        }
        
        // 2
        func getJoke(id: String) -> AnyPublisher<Joke, Error> {
            // id가 최소 한 글자라도 있어야함.
            guard id.rangeOfCharacter(from: .letters) != nil else {
                return Fail<Joke, Error>(
                    error: .jokeDoesntExist(id: id)
                )
                .eraseToAnyPublisher()
            }
            let url = URL(string: "https://icanhazdadjoke.com/j/\(id)")!
            var request = URLRequest(url: url)
            /// request.allHTTPHeaderFields 가 없으면 → failure(Failed parsing response from server)
            request.allHTTPHeaderFields = ["Accept": "application/json"]

            
        // 3
            return URLSession.shared
                .dataTaskPublisher(for: request)
//                .map(\.data)
                .tryMap { data, _ -> Data in
                    // 6
                    guard let obj = try? JSONSerialization.jsonObject(with: data),
                          let dict = obj as? [String: Any],
                          dict["status"] as? Int == 404 else {
                        return data
                    }
                    // 7
                    throw DadJokes.Error.jokeDoesntExist(id: id)
                }
                .decode(type: Joke.self, decoder: JSONDecoder())
                .mapError { error -> DadJokes.Error in
                    switch error {
                    case is URLError:
                        return .network
                    case is DecodingError:
                        return .parsing
                    default:
                        return error as? DadJokes.Error ?? .unknown
                    }
                }
                .eraseToAnyPublisher()
        }
    }
    
    // 4
    let api = DadJokes()
    let jokeID = "9prWnjyImyd"
    let badJokeID = "123456"
    
    // 5
    api
        .getJoke(id: jokeID)
//        .getJoke(id: badJokeID) // 에러발생
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print("God joke: \($0)") })
        .store(in: &subscriptions)
}
//: [Next](@next)

/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
