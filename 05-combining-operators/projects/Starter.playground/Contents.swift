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

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "prepend(Publisher) #2") {
//
//    let publisher1 = [3, 4].publisher
//    let publisher2 = PassthroughSubject<Int, Never>()
//
//    publisher1
//        .prepend(publisher2)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    publisher2.send(1)
//    publisher2.send(2)
//    publisher2.send(completion: .finished)  // completion 처리를 해주지 않으면 combine이 이벤트 방출한줄 모름.
//}

/*
 ——— Example of: prepend(Publisher) #2 ———
 1
 2
 3
 4
 */

// TODO: [x] append(Output)

//var subscriptions = Set<AnyCancellable>()

//example(of: "append(Output)") {
//
//    let publisher = [1].publisher
//
//    publisher
//        .append(2, 3)
//        .append(4)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
/*
 ——— Example of: append(Output) ———
 1
 2
 3
 4
 */

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "append(Output)") {
//
//    let publisher = PassthroughSubject<Int, Never>()
//
//    publisher
//        .append(3, 4)
//        .append(5)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    publisher.send(1)
//    publisher.send(2)
//    publisher.send(completion: .finished)
//}

/*
 ——— Example of: append(Output) ———
 1
 2
 3
 4
 5
 */

// TODO: [x] append(Sequence)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "append(Sequence)") {
//
//    let publisher = [1, 2, 3].publisher
//
//    publisher
//        .append([4, 5])
//        .append(Set([6, 7]))
//        .append(stride(from: 8, to: 11, by: 2))
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//}

/*
 ——— Example of: append(Sequence) ———
 1
 2
 3
 4
 5
 6
 7
 8
 10
 */

// TODO: [x] append(Publisher)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "append(Publisher)") {
//
//    let publisher1 = [1, 2].publisher
//    let publisher2 = [3, 4].publisher
//
//    publisher1
//        .append(publisher2)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: append(Publisher) ———
 1
 2
 3
 4
 */

// TODO: [x] switchToLatest

//example(of: "switchToLatest") {
//    var subscriptions = Set<AnyCancellable>()
//
//    let publisher1 = PassthroughSubject<Int, Never>()
//    let publisher2 = PassthroughSubject<Int, Never>()
//    let publisher3 = PassthroughSubject<Int, Never>()
//
//    let publishers = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()
//
//    publishers
//        .switchToLatest() // 최신 publisher로 switch
//        .sink(receiveCompletion: { _ in print("Completed!")},
//              receiveValue: { print($0) }
//        )
//        .store(in: &subscriptions)
//
//    publishers.send(publisher1)
//    publisher1.send(1)
//    publisher1.send(2)
//
//    publishers.send(publisher2) // publisher2를 구독하므로
//    publisher1.send(3) // publisher1의 해당 이벤트는 무시됨
//    publisher2.send(4)
//    publisher2.send(5)
//
//    publishers.send(publisher3) // publisher3를 구독하므로
//    publisher2.send(6) // publisher2의 해당 이벤트는 무시됨
//    publisher3.send(7)
//    publisher3.send(8)
//    publisher3.send(9)
//
//    publisher3.send(completion: .finished)
//    publishers.send(completion: .finished)
//}

/*
 ——— Example of: switchToLatest ———
 1
 2
 4
 5
 7
 8
 9
 Completed!
 */

// TODO: [x] Advanced Combining
//var subscriptions = Set<AnyCancellable>()
//
//example(of: "switchToLatest - Network Request") {
//
//
//    let url = URL(string: "https://source.unsplash.com/random")!
//
//    func getImage() -> AnyPublisher<UIImage?, Never> {
//        URLSession.shared
//            .dataTaskPublisher(for: url)
//            .map { data, _ in UIImage(data: data) }
//            .print("image")
//            .replaceError(with: nil)
//            .eraseToAnyPublisher()
//    }
//
//    let taps = PassthroughSubject<Void, Never>()
//
//    taps
//        .map { _ in getImage() }
//        .switchToLatest()
//        .sink(receiveValue: { _ in })
//        .store(in: &subscriptions)
//
//    taps.send()
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        taps.send()
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
//        taps.send()
//    }
//}

/*
 ——— Example of: switchToLatest - Network Request ———
 image: receive subscription: (DataTaskPublisher)
 image: request unlimited
 image: receive value: (Optional(<UIImage:0x6000009dc630 anonymous {1080, 720} renderingMode=automatic(original)>))
 image: receive finished
 image: receive subscription: (DataTaskPublisher)
 image: request unlimited
 image: receive cancel
 image: receive subscription: (DataTaskPublisher)
 image: request unlimited
 image: receive value: (Optional(<UIImage:0x6000009d2fd0 anonymous {1080, 1350} renderingMode=automatic(original)>))
 image: receive finished
 */

// TODO: [x] merge(with:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "merge(with:)") {
//    let publisher1 = PassthroughSubject<Int, Never>()
//    let publisher2 = PassthroughSubject<Int, Never>()
//
//    publisher1
//        .merge(with: publisher2)
//        .sink(receiveCompletion: { _ in print("Completed")},
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    publisher1.send(1)
//    publisher1.send(2)
//
//    publisher2.send(3)
//
//    publisher1.send(4)
//    publisher2.send(5)
//
//    publisher1.send(completion: .finished)
//    publisher2.send(completion: .finished)
//}

/*
 ——— Example of: merge(with:) ———
 1
 2
 3
 4
 5
 Completed
 */

// TODO: [x] combineLatest

//var subscriptions = Set<AnyCancellable>()

//example(of: "combineLatest") {
//
//    let publisher1 = PassthroughSubject<Int, Never>()
//    let publisher2 = PassthroughSubject<String, Never>()
//
//    publisher1
//        .combineLatest(publisher2)
//        .sink(receiveCompletion: { _ in print("Completed")},
//              receiveValue: { print("P1: \($0), P2: \($1)") })
//        .store(in: &subscri87ptions)
//
//    publisher1.send(1)
//    publisher1.send(2)
//
//    publisher2.send("a")
//    publisher2.send("b")
//
//    publisher1.send(3)
//
//    publisher2.send("c")
//
//    publisher1.send(completion: .finished)
//    publisher2.send(completion: .finished)
//}

/*
 ——— Example of: combineLatest ———
 P1: 2, P2: a
 P1: 2, P2: b
 P1: 3, P2: b
 P1: 3, P2: c
 Completed
 */

// TODO: [x] zip

var subscriptions = Set<AnyCancellable>()

example(of: "zip") {
    
    let publisher1 = PassthroughSubject<Int, Never>()
    let publisher2 = PassthroughSubject<String, Never>()
    
    publisher1
        .zip(publisher2)
        .sink(
            receiveCompletion: { _ in print("Completed") },
            receiveValue: { print("P1: \($0), P2: \($1)") }
        )
        .store(in: &subscriptions)
    
    publisher1.send(1)
    publisher1.send(2)
    publisher2.send("a")
    publisher2.send("b")
    publisher1.send(3)
    publisher2.send("c")
    publisher2.send("d")
    
    publisher1.send(completion: .finished)
    publisher2.send(completion: .finished)
    
}

/*
 ——— Example of: zip ———
 P1: 1, P2: a
 P1: 2, P2: b
 P1: 3, P2: c
 Completed
 */
