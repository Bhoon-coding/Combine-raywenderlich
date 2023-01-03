import Combine
import Foundation

let request = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://www.raywenderlich.com/")!)

private var cancellables = Set<AnyCancellable>()  // 추가

request
    .handleEvents(
        receiveSubscription: { _ in
        print("Network request will start")},
        receiveOutput: { _ in
        print("Network request data received")},
        receiveCancel: {
        print("Network request cancelled")})
    .sink(receiveCompletion: { completion in
        print("Sink received compeltion: \(completion)")
    }) { (data, _) in
        print("Sink received data: \(data)")}
    .store(in: &cancellables) // 추가

// Network request will start
// Network request data received
// Sink received data: 264701 bytes
// Sink received compeltion: finished
