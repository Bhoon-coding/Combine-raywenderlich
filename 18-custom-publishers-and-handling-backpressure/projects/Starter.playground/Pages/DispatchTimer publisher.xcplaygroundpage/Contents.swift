import Foundation
import Combine

struct DispatchTimerConfiguration {
    // 1
    let queue: DispatchQueue?
    // 2
    let interval: DispatchTimeInterval
    // 3
    let leeway: DispatchTimeInterval
    // 4
    let times: Subscribers.Demand
}

extension Publishers {
    struct DispatchTimer: Publisher {
        // 5 - 현재시간을 DispatchTime 값으로 방출
        typealias Output = DispatchTime
        typealias Failure = Never
        
        // 6 - subscriber를 받을때 필요
        let configuration: DispatchTimerConfiguration
        
        init(configuration: DispatchTimerConfiguration) {
            self.configuration = configuration
        }
        
        // 7
        func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
            // 8
            let subscription = DispatchTimerSubscription(subscriber: subscriber,
                                                         configuration: configuration)
            
            // 9 - subscription에 요청한만큼 receive
            subscriber.receive(subscription: subscription)
        }
    }
    
    private final class DispatchTimerSubscription<S: Subscriber>: Subscription where S.Input == DispatchTime {
        // 10
        let configuration: DispatchTimerConfiguration
        // 11 - 값을 보낼때 마다 감소 시킴
        var times: Subscribers.Demand
        // 12 - subscriber로 부터 요청 받은 값의 수
        var requested: Subscribers.Demand = .none
        // 13 -
        var source: DispatchSourceTimer? = nil
        // 14 - subscription은 subscriber가 완료되거나, 실패, 취소 되지 않는한 구독 유지 해야함
        var subscriber: S?
        
        init(subscriber: S,
             configuration: DispatchTimerConfiguration) {
            self.subscriber = subscriber
            self.configuration = configuration
            self.times = configuration.times
        }
        
        // 15
        func request(_ demand: Subscribers.Demand) {
            // 16
            guard times > .none else {
                // 17 
                subscriber?.receive(completion: .finished)
                return
            }
            
            // 18
            requested += demand
            
            // 19
            if source == nil, requested > .none {
                // 20
                let source = DispatchSource.makeTimerSource(queue: configuration.queue)
                // 21
                source.schedule(deadline: .now() + configuration.interval,
                                repeating: configuration.interval,
                                leeway: configuration.leeway)
                
                // 22
                source.setEventHandler { [weak self] in
                    // 23
                    guard let self = self,
                          self.requested > .none else { return }
                    
                    // 24
                    self.requested -= .max(1)
                    self.times -= .max(1)
                    // 25
                    _ = self.subscriber?.receive(.now())
                    // 26
                    if self.times == .none {
                        self.subscriber?.receive(completion: .finished)
                    }
                }
                
                self.source = source
                source.activate()
            }
        }
        
        func cancel() {
            source = nil
            subscriber = nil
        }
    }
    
    static func timer(queue: DispatchQueue? = nil,
                      interval: DispatchTimeInterval,
                      leeway: DispatchTimeInterval = .nanoseconds(0),
                      times: Subscribers.Demand = .unlimited) -> Publishers.DispatchTimer {
        return Publishers.DispatchTimer(configuration: .init(queue: queue,
                                                             interval: interval,
                                                             leeway: leeway,
                                                             times: times))
    }
}

// 27
var logger = TimeLogger(sinceOrigin: true)
// 28
let publisher = Publishers.timer(interval: .seconds(1),
                                 times: .max(6))
// 29
let subscription = publisher.sink { time in
    print("Timer emits: \(time)", to: &logger)
}

//: [Next](@next)
/*:
 Copyright (c) 2021 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
