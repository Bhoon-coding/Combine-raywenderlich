import Combine
import Foundation

//let queue = OperationQueue()
//
//let subscription = queue.publisher(for: \.operationCount)
//    .sink {
//        print("Outstanding operations in queue: \($0)")
//    }

class TestObject: NSObject {
    
    @objc dynamic var integerProperty: Int = 0
    @objc dynamic var stringProperty: String = ""
    @objc dynamic var arrayProperty: [Float] = []
    
}

let obj = TestObject()

//let subscription = obj.publisher(for: \.integerProperty)
//    .sink {
//        print("integerProperty changes to \($0)")
//    }

obj.integerProperty = 100
obj.integerProperty = 200

let subscription2 = obj.publisher(for: \.stringProperty, options: [.prior])
    .sink {
        print("stringProperty changes to \($0)")
    }

//let subscription3 = obj.publisher(for: \.arrayProperty)
//    .sink {
//        print("arrayProperty changes to \($0)")
//    }

obj.stringProperty = "Hello"
obj.arrayProperty = [1.0]
obj.stringProperty = "World"
obj.arrayProperty = [1.0, 2.0]

//integerProperty changes to 0
//integerProperty changes to 100
//integerProperty changes to 100
//integerProperty changes to 200
//arrayProperty changes to []
//stringProperty changes to Hello
//arrayProperty changes to [1.0]
//stringProperty changes to World
//arrayProperty changes to [1.0, 2.0]


