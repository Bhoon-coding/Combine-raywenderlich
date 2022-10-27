import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "Create a phone number lookup") {
  let contacts = [
    "603-555-1234": "Florent",
    "408-555-4321": "Marin",
    "217-555-1212": "Scott",
    "212-555-3434": "Shai"
  ]

  func convert(phoneNumber: String) -> Int? {
    if let number = Int(phoneNumber),
      number < 10 {
      return number
    }

    let keyMap: [String: Int] = [
      "abc": 2, "def": 3, "ghi": 4,
      "jkl": 5, "mno": 6, "pqrs": 7,
      "tuv": 8, "wxyz": 9
    ]

    let converted = keyMap
      .filter { $0.key.contains(phoneNumber.lowercased()) }
      .map { $0.value }
      .first

    return converted
  }

  func format(digits: [Int]) -> String {
    var phone = digits.map(String.init)
                      .joined()

    phone.insert("-", at: phone.index(
      phone.startIndex,
      offsetBy: 3)
    )

    phone.insert("-", at: phone.index(
      phone.startIndex,
      offsetBy: 7)
    )

    return phone
  }
  
  func dial(phoneNumber: String) -> String {
    guard let contact = contacts[phoneNumber] else {
      return "Contact not found for \(phoneNumber)"
    }

    return "Dialing \(contact) (\(phoneNumber))..."
  }
  
  let input = PassthroughSubject<String, Never>()

    input
        .map(convert) // String -> Int 변환 >> (문자입력시) keyMap을 통해 문자에 포함되는 숫자로 변환
        .replaceNil(with: 0) // Optional 바인딩 처리 후, 변환할 수 없는것 (nil) -> 0으로 대체
        .collect(10) // 한 배열에 10개 요소 담기
        .map(format) // Int -> String >> String 통합 >> 인덱스 3번째, 7번째 자리에 "-" 추가
        .map(dial) // contacts[phoneNumber] 키 값으로 접근해 value(사람이름) 반환
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0) })
  
  "0!1234567".forEach {
    input.send(String($0))
  }
  
  "4085554321".forEach {
    input.send(String($0))
  }
  
  "A1BJKLDGEH".forEach {
    input.send("\($0)")
  }
}
