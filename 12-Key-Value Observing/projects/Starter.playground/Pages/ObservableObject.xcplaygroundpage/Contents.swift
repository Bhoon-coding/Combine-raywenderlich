import Combine
import Foundation

class MonitorObject: ObservableObject {
    @Published var someProperty = false
    @Published var someOtherProperty = ""
}

let object = MonitorObject()
let subscription = object.objectWillChange.sink { 
    print("object will change")
}

object.someProperty = true
object.someOtherProperty = "Hello World"

//object will change
//object will change
