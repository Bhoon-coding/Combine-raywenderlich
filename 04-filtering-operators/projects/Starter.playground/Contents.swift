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

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "compactMap") {
//
//    let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher
//
//    strings
//        .compactMap { Float($0) }
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: compactMap ———
 1.24
 3.0
 45.0
 0.23
 */

// TODO: [x] ignoreOutput

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "ignoreOutput") {
//    let numbers = (1...10_000).publisher
//
//    numbers
//        .ignoreOutput()
//        .sink(receiveCompletion: { print("Completed with: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
//
///*
// ——— Example of: ignoreOutput ———
// Completed with: finished
//*/

// TODO: [x] first(where:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "first(where:)") {
//
//    let strings = ["bc", "ad", "abc"].publisher
//
//
//    strings
//        .print("strings")
//        .first(where: { $0.contains(where: { char in char == "a" })} )
//        .sink(receiveCompletion: { print("Completed with: \($0)")},
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: first(where:) ———
 strings: receive subscription: (["bc", "ad", "abc"])
 strings: request unlimited
 strings: receive value: (bc)
 strings: receive value: (ad)
 strings: receive cancel
 ad
 Completed with: finished
*/

// TODO: [x] last(where:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "last(where:)") {
//
//    let numbers = (1...9).publisher
//
//    numbers
//        .last(where: { $0 % 2 == 0 })
//        .sink(receiveCompletion: { print("Completed with: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
/*
 ——— Example of: last(where:) ———
 8
 Completed with: finished
*/

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "last(where:) 2") {
//    let numbers = PassthroughSubject<Int, Never>()
//
//    numbers
//        .last(where: { $0 % 2 == 0 })
//        .sink(receiveCompletion: { print("Completed with: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    numbers.send(1)
//    numbers.send(2)
//    numbers.send(3)
//    numbers.send(4)
//    numbers.send(5)
//    numbers.send(completion: .finished)
//}
/*
 ——— Example of: last(where:) 2 ———
 4
 Completed with: finished
*/

// TODO: [x] dropFirst()

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "dropFirst") {
//
//    let numbers = (1...10).publisher
//
//    numbers
//        .dropFirst(8)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
/*
 ——— Example of: dropFirst ———
 9
 10
*/

// TODO: [x] drop(while:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "drop(while:)") {
//
//    let numbers = (1...10).publisher
//
//    numbers
//        .drop(while: {
//            print("x")
//            return $0 % 5 != 0 }) // 조건에 만족하는 숫자가 나오기전 요소들은 다 생략
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
/*
 ——— Example of: drop(while:) ———
 x
 x
 x
 x
 x
 5
 6
 7
 8
 9
 10
*/

// TODO: [x] drop(untilOutputFrom: isReady)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "drop(untilOutputFrom:)") {
//
//    let isReady = PassthroughSubject<Void, Never>()
//    let taps = PassthroughSubject<Int, Never>()
//
//    taps
//        .drop(untilOutputFrom: isReady)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    (1...5).forEach { n in
//        taps.send(n) // 1, 2, 3 까지 생략
//
//        if n == 3 {
//            isReady.send() // isReady 활성화 >> 이후 이벤트 emit
//        }
//    }
//
//}

/*
 ——— Example of: drop(untilOutputFrom:) ———
 4
 5
*/

// TODO: [x] prefix(_:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "prefix") {
//
//    let numbers = (1...10).publisher
//
//    numbers
//        .prefix(2)
//        .sink(receiveCompletion: { print("Completed with: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
/*
 ——— Example of: prefix ———
 1
 2
 Completed with: finished
*/

// TODO: [x] prefix(while:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "prefix(while:)") {
//
//    let numbers = (1...10).publisher
//
//    numbers
//        .prefix(while: { $0 < 3 })
//        .sink(receiveCompletion: { print("Completed with: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//}

/*
 ——— Example of: prefix(while:) ———
 1
 2
 Completed with: finished
*/

// TODO: [x] prefix(untilOutputFrom: isReady)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "prefix(untilOutputFrom: isReady)") {
//
//    let isReady = PassthroughSubject<Void, Never>()
//    let taps = PassthroughSubject<Int, Never>()
//
//    taps
//        .prefix(untilOutputFrom: isReady)
//        .sink(receiveCompletion: { print("Completed with: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    (1...5).forEach { n in
//        taps.send(n)
//
//        if n == 2 {
//            isReady.send()
//        }
//    }
//}

/*
 ——— Example of: prefix(untilOutputFrom: isReady) ———
 1
 2
 Completed with: finished
*/

// TODO: [] Challenge

var subscriptions = Set<AnyCancellable>()

example(of: "Challenge") {
    
    let numbers = (1...100).publisher
    
    numbers
        .dropFirst(50)
        .prefix(while: { $0 <= 70 })
        .filter { $0 % 2 == 0 }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

/*
 ——— Example of: Challenge ———
 52
 54
 56
 58
 60
 62
 64
 66
 68
 70
*/
