import Combine
import Foundation

let main = Timer.publish(every: 1.0, on: .main, in: .common)
let current = Timer.publish(every: 1.0, on: .current, in: .common)

let subscription = Timer
    .publish(every: 1.0, on: .main, in: .common)
    .autoconnect()
    .scan(0) { counter, _ in counter + 1 } // 이전 값에 +1을 함 (reduce는 최종값만 나타내지만, scan은 지속적으로 값을 보여줌)
    .sink { counter in
        print("Counter is \(counter)")
    }


