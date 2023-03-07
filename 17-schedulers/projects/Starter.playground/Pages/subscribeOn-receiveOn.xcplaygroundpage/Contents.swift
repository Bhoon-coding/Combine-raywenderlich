import Foundation
import Combine

// 1
let computationPublisher = Publishers.ExpensiveComputation(duration: 3)

// 2
let queue = DispatchQueue(label: "serial queue")

// 3
let currentThread = Thread.current.number
print("Start computation publisher on thread \(currentThread)")

let subscription = computationPublisher
    .subscribe(on: queue)
    .sink { value in
        let thread = Thread.current.number
        print("Received computation result on thread \(thread): '\(value)")
    }
//Start computation publisher on thread 1
//ExpensiveComputation subscriber received on thread 7
//Beginning expensive computation on thread 7
//Completed expensive computation on thread 7
//Received computation result on thread 7: 'Computation complete



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
