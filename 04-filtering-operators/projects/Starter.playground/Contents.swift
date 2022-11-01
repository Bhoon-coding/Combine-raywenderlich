import Foundation
import Combine


// TODO: [x] Filter

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "filter") {
//    // 1. 1~10까지 이벤트 방출
//    let numbers = (1...10).publisher
//
//    // 2. filter 연산자로, 3의 배수만 걸러냄
//    numbers
//        .filter { $0.isMultiple(of: 3) }  // isMultiple of의 지정된 숫자의 배수이면 true 반환
//        .sink(receiveValue: { num in
//            print("\(num) 은 3의 배수")
//        })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: filter ———
 3 은 3의 배수
 6 은 3의 배수
 9 은 3의 배수
*/

// TODO: [x] removeDuplicates

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "removeDuplicate") {
//    let words = "hey hey there! want to listen to mister mister ?"
//        .components(separatedBy: " ") // " " 띄워쓰기 부분별로 나눠 배열에 담음
//        // ["hey", "hey", "there!", "want", "to", "listen", "to", "mister", "mister", "?"]
//        .publisher
//
//    words
//        .removeDuplicates() // 중복된 요소가 있을 경우 하나만 방출합니다.
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: removeDuplicate ———
 hey
 there!
 want
 to
 listen
 to
 mister
 ?
*/

// TODO: [x] compactMap

var subscriptions = Set<AnyCancellable>()

example(of: "compactMap") {
    
    let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher

    strings
        .compactMap { Float($0) }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

/*
 ——— Example of: compactMap ———
 1.24
 3.0
 45.0
 0.23
*/

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
