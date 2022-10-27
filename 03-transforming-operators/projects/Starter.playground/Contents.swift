import Foundation
import Combine


// TODO: [x] collect()
//var subscriptions = Set<AnyCancellable>()
//
//example(of: "collect") {
//    ["A", "B", "C", "D", "E"].publisher
//        .collect(2)
//        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
//
///*
// ——— Example of: collect ———
// ["A", "B"]
// ["C", "D"]
// ["E"]
// finished
//*/

// TODO: [x] map(_:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "map") {
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .spellOut
//
//    [12, 456, 7].publisher
//        .map {
//            formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
//        }
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: map ———
 twelve
 four hundred fifty-six
 seven
*/

// TODO: [] mapping key paths

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "mapping key paths") {
//    let publisher = PassthroughSubject<Coordinate, Never>()
//
//    publisher
//        .map(\.x, \.y)
//        .sink(receiveValue: { x, y in
//            print("좌표 (\(x), \(y)) 는", quadrantOf(x: x, y: y), "사분면 입니다.")
//        })
//        .store(in: &subscriptions)
//
//    publisher.send(Coordinate(x: 10, y: -8))
//    publisher.send(Coordinate(x: 0, y: 5))
//}

/*
 ——— Example of: mapping key paths ———
 좌표 (10, -8) 는 4 사분면 입니다.
 좌표 (0, 5) 는 boundary(경계선) 사분면 입니다.
*/

// TODO: [x] tryMap(_:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "tryMap") {
//    Just("Directory name that does not exist")
//        .tryMap { try FileManager.default.contentsOfDirectory(atPath: $0) }
//        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: tryMap ———
 failure(Error Domain=NSCocoaErrorDomain Code=260 "The folder “Directory name that does not exist” doesn’t exist." UserInfo={NSUserStringVariant=(
     Folder
 ), NSFilePath=Directory name that does not exist, NSUnderlyingError=0x6000030ea130 {Error Domain=NSPOSIXErrorDomain Code=2 "No such file or directory"}})
*/

// TODO: [x] flatMap(maxPublishers:_:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "flatMap") {
//    func decode(_ codes: [Int]) -> AnyPublisher<String, Never> {
//        Just(codes
//            .compactMap { code in
//                guard (32...255).contains(code) else { return nil }
//                return String(UnicodeScalar(code) ?? " ")
//            }
//            .joined()
//        )
//        .eraseToAnyPublisher()
//    }
//
//    [72, 101, 108, 108, 111] // Hello
//        .publisher
//        .collect()
//        .flatMap(decode)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: flatMap ———
 Hello
 */


// TODO: [x] replaceNil(with:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "replaceNil") {
//    ["A", nil, "C"].publisher
//        .eraseToAnyPublisher()
//        .replaceNil(with: "BBB")
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: replaceNil ———
 A
 BBB
 C
*/

// TODO: [x] replaceEmpty(with:)

//var subscriptions = Set<AnyCancellable>()
//
//example(of: "replaceEmpty") {
//    let empty = Empty<Int, Never>()
//
//    empty
//        .replaceEmpty(with: 1)
//        .sink(receiveCompletion: { print($0) },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

/*
 ——— Example of: replaceEmpty ———
 1
 finished
*/

// TODO: [x] scan(_:_:)

var subscriptions = Set<AnyCancellable>()

example(of: "scan") {
    var dailyGainLoss: Int { .random(in: -10...10) }
    
    let august2019 = (0..<22)
        .map { _ in dailyGainLoss }
        .publisher
    
    august2019
        .scan(50) { latest, current in
            max(0, latest + current)
        }
        .sink(receiveValue: { _ in })
        .store(in: &subscriptions)
}
