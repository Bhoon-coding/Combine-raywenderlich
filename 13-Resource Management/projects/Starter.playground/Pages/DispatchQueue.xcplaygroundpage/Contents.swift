import Foundation
import Combine

let queue = DispatchQueue.main

// 1
let source = PassthroughSubject<Int, Never>()

// 2
var counter = 0

// 3
let cancellable = queue.schedule(
    after: queue.now,
    interval: .seconds(1)
) {
    source.send(counter)
    counter += 1
}

// 4
let subscription = source.sink {
    print("Timer emitted \($0)")
}
