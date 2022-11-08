import UIKit
import Combine

// TODO: [x] prepend(output)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "prepend(output)") {
//
//    let publisher = [3, 4].publisher
//
//    publisher
//        .prepend(1, 2)
//        .prepend(-1, -2)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: prepend(output) ———
 -1
 -2
 1
 2
 3
 4
*/


// TODO: [x] prepend(Sequence)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "prepend(Sequence)") {
//
//    let publisher = [5, 6, 7].publisher
//
//    publisher
//        .prepend([3, 4])
//        .prepend(stride(from: 6, to: 11, by: 2))
//        .prepend(Set(1...2))
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: prepend(Sequence) ———
 2
 1
 6
 8
 10
 3
 4
 5
 6
 7
 */

// TODO: [x] prepend(Publisher)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "prepend(Publisher)") {
//
//    let publisher1 = [3, 4].publisher
//    let publisher2 = [1, 2].publisher
//
//    publisher1
//        .prepend(publisher2)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
//
///*
// ——— Example of: prepend(Publisher) ———
// 1
// 2
// 3
// 4
//*/

// TODO: [x] prepend(Publisher) with PassthroughSubject

var subscriptions = Set<AnyCancellable>()

example(of: "prepend(Publisher) #2") {

    let publisher1 = [3, 4].publisher
    let publisher2 = PassthroughSubject<Int, Never>()

    publisher1
        .prepend(publisher2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    publisher2.send(1)
    publisher2.send(2)
    publisher2.send(completion: .finished)  // completion 처리를 해주지 않으면 combine이 이벤트 방출한줄 모름.
}

/*
 ——— Example of: prepend(Publisher) #2 ———
 1
 2
 3
 4
 */
