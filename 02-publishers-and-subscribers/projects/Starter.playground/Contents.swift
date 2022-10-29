import Foundation
import Combine
import _Concurrency

//var subscriptions = Set<AnyCancellable>()

//example(of: "Publisher") {
//    // 1
//    let myNotification = Notification.Name("MyNotification")
//
//    // 2
//    let publisher = NotificationCenter.default.publisher(for: myNotification,
//                                                         object: nil)
//
//    // 3
//    let center = NotificationCenter.default
//
//    // 4
//    let observer = center.addObserver(
//        forName: myNotification,
//        object: nil,
//        queue: nil) { notification in
//        print("Notification received!")
//    }
//
//    // 5
//    center.post(name: myNotification, object: nil)
//
//    // 6
//    center.removeObserver(observer)
//}
//
//example(of: "Subscriber") {
//    let myNotification = Notification.Name("MyNotification")
//    let center = NotificationCenter.default
//    let publisher = center.publisher(for: myNotification, object: nil)
//    let subscription = publisher.sink { _ in
//        print("Notification received from a publisher!")
//    }
//    center.post(name: myNotification, object: nil)
//    subscription.cancel()
//}

//example(of: "Just") {
//    // 1 - Publisher 생성 (just)
//    let just = Just("Hello world!")
//
//    // 2 -  pubhlisher를 구독하고 받아온 각 이벤트의 메시지를 print하기 위해 생성
//    _ = just
//        .sink(receiveCompletion: {
//            print("Received completion", $0)
//        }, receiveValue: {
//            print("Received value", $0)
//        })
//
//    _ = just
//        .sink(receiveCompletion: {
//            print("Received completion (another)", $0)
//        }, receiveValue: {
//            print("Received value (another)", $0)
//        })
//}

// TODO: assign(to:on:)
//example(of: "assign(to:on:)") {
//    // 1 new value를 print하는 didSet 속성 관찰자가 있는 속성으로 클래스를 정의합니다.
//    class SomeObject {
//        var value: String = "" {
//            didSet {
//                print(value)
//            }
//        }
//    }
//
//    // 2 - class 인스턴스 생성
//    let object = SomeObject()
//
//    // 3 - [String] 타입의 publisher 생성
//    let publisher = ["Hello", "world!"].publisher
//
//    // 4 - publisher를 구독(subscribe)하여, 받은 각 값을 객체의 값 속성에 할당합니다.
//    _ = publisher
//        .assign(to: \.value, on: object)
//}

// TODO: assign(to:)
//example(of: "assign(to:)") {
//    // 1 - @Published 키워드를 이용하면 value를 publisher로 만들뿐만 아니라, 일반 속성으로 액세스할 수 있습니다.
//    class SomeObject {
//        @Published var value = 0
//    }
//
//    let object = SomeObject()
//
//    // 2 - `$` 키워드로 @Published 속성에 액세스하 @Published 속성의 $ 접두사를 사용하여 기본 게시자에 액세스하고, 구독하고, 받은 각 값을 print합니다.
//    object.$value
//        .sink {
//            print($0)
//        }
//
//    // 3 - (0~9)까지의 숫자를 방출하는 publisher를 만듭니다. 속성에 대한 inout 참조를 나타내기 위해 & 키워드를 사용합니다.
//    (0..<10).publisher
//        .assign(to: &object.$value)
//}

// TODO: Future

//example(of: "Future") {
//  func futureIncrement(
//    integer: Int,
//    afterDelay delay: TimeInterval) -> Future<Int, Never> {
//    Future<Int, Never> { promise in
//      print("Original")
//      DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
//        promise(.success(integer + 1))
//      }
//    }
//  }
//
//  // 1
//  let future = futureIncrement(integer: 1, afterDelay: 3)
//
//  // 2
//  future
//    .sink(receiveCompletion: { print("FirstCompletion", $0) },
//          receiveValue: { print("FirstValue", $0) })
//    .store(in: &subscriptions)
//
//  future
//    .sink(receiveCompletion: { print("SecondCompletion", $0) },
//          receiveValue: { print("Second", $0) })
//    .store(in: &subscriptions)
//}

// TODO: PassthroughSubject
//example(of: "PassthroughSubject") {
//  // 1
//  enum MyError: Error {
//    case test
//  }
//
//  // 2
//  final class StringSubscriber: Subscriber {
//    typealias Input = String
//    typealias Failure = MyError
//
//    func receive(subscription: Subscription) {
//      subscription.request(.max(2))
//    }
//
//    func receive(_ input: String) -> Subscribers.Demand {
//      print("Received value", input)
//      // 3
//      return input == "World" ? .max(1) : .none
//    }
//
//    func receive(completion: Subscribers.Completion<MyError>) {
//      print("Received completion", completion)
//    }
//  }
//
//  // 4
//  let subscriber = StringSubscriber()
//
//  // 5
//  let subject = PassthroughSubject<String, MyError>()
//
//  // 6
//  subject.subscribe(subscriber)
//
//  // 7
//  let subscription = subject
//    .sink(
//      receiveCompletion: { completion in
//        print("Received completion (sink)", completion)
//      },
//      receiveValue: { value in
//        print("Received value (sink)", value)
//      }
//    )
//
////    let subscription2 = subject
////        .sink(receiveCompletion: { completion in
////            print("Received completion (sink)", completion)
////        }, receiveValue: { value in
////            print("Received value (sink)", value)
////        })
//
//    subject.send("Hello")
//    subject.send("World")
//
//    // 8
//    subscription.cancel()
//
//    // 9
//    subject.send("Still there?")
//
//    subject.send(completion: .failure(MyError.test))
//    subject.send(completion: .finished)
//    subject.send("How about another one?")
//}

// TODO: [x] custom subscriber

//example(of: "Custom Subscriber") {
//    let publisher = (1...6).publisher
//
//    final class IntSubscriber: Subscriber {
//
//        typealias Input = Int
//        typealias Failure = Never
//
//        func receive(subscription: Subscription) {
//            subscription.request(.max(3))
//        }
//
//        func receive(_ input: Int) -> Subscribers.Demand {
//            print("Received value", input)
//            return .unlimited
//        }
//
//        func receive(completion: Subscribers.Completion<Never>) {
//            print("Received completion", completion)
//        }
//    }
//
//    let subscriber = IntSubscriber()
//    publisher.subscribe(subscriber)
//}

/*
 == return .none ==
 ——— Example of: Custom Subscriber ———
 Received value 1
 Received value 2
 Received value 3
*/

/*
 == return .unlimited ==
 ——— Example of: Custom Subscriber ———
 Received value 1
 Received value 2
 Received value 3
 Received value 4
 Received value 5
 Received value 6
 Received completion finished
*/

// TODO: [x] Hello Future

var subscriptions = Set<AnyCancellable>()

example(of: "Future") {
    func futureIncrement(
        integer: Int,
        afterDelay delay: TimeInterval) -> Future<Int, Never> {
            Future<Int, Never> { promise in
                print("Original")
                DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                    promise(.success(integer + 1))
                }
            }
    }
    let future = futureIncrement(integer: 1, afterDelay: 3)
    
    future
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    future
        .sink(receiveCompletion: { print("Second", $0) },
              receiveValue: { print("Second", $0) })
        .store(in: &subscriptions)
}

/*
 ——— Example of: Future ———
 Original
 2
 finished
 Second 2
 Second finished
*/
