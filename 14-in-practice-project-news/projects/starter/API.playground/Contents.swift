import Foundation
import PlaygroundSupport
import Combine

struct API {
    /// API Errors.
    enum Error: LocalizedError {
        case addressUnreachable(URL)
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "The server responded with garbage."
            case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
            }
        }
    }
    
    /// API endpoints.
    enum EndPoint {
        static let baseURL = URL(string: "https://hacker-news.firebaseio.com/v0/")!
        
        case stories
        case story(Int)
        
        var url: URL {
            switch self {
            case .stories:
                return EndPoint.baseURL.appendingPathComponent("newstories.json")
            case .story(let id):
                return EndPoint.baseURL.appendingPathComponent("item/\(id).json")
            }
        }
    }
    
    /// Maximum number of stories to fetch (reduce for lower API strain during development).
    var maxStories = 10
    
    /// A shared JSON decoder to use in calls.
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "API",
                                         qos: .default,
                                         attributes: .concurrent)
    
    func story(id: Int) -> AnyPublisher<Story, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.story(id).url)
            .receive(on: apiQueue) // background에서 response를 받기 위해 Scheduler를 apiQueue로 설정.
            .map(\.data)
            .decode(type: Story.self, decoder: decoder) // decode(..) - JSON을 제외한 값을 받으면, error를 던짐.
            .catch { _ in Empty<Story, Error>() }
            .eraseToAnyPublisher()
    }
    
}

let api = API()
var subscriptions = [AnyCancellable]()
api.story(id: 5)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &subscriptions)



// Run indefinitely.
PlaygroundPage.current.needsIndefiniteExecution = true
