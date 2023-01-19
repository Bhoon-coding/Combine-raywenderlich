import Combine
import Foundation

// 1
let subject = PassthroughSubject<Data, URLError>()

// 2
let multicasted = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://www.raywenderlich.com")!)
    .map(\.data)
    .print("multicast")
    .multicast(subject: subject)

// 3
let subscription1 = multicasted
    .sink(receiveCompletion: { _ in },
          receiveValue: { print("subscription1 received: '\($0)'") }
    )

let subscription2 = multicasted
    .sink(receiveCompletion: { _ in },
          receiveValue: { print("subscription2 received: '\($0)'") }
    )

// 4
let cancellable = multicasted.connect()

//multicast: receive subscription: (DataTaskPublisher)
//multicast: request unlimited
//multicast: receive value: (266296 bytes)
//subscription2 received: '266296 bytes'
//subscription1 received: '266296 bytes'
//multicast: receive finished
