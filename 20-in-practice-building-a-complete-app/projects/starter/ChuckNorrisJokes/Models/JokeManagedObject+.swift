//
//  JokeManagedObject+.swift
//  ChuckNorrisJokes
//
//  Created by BH on 2023/04/13.
//  Copyright © 2023 Scott Gardner. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import ChuckNorrisJokesModel

extension JokeManagedObject {
    // 1 - 전달된 뷰 컨텍스트를 사용하여 joke를 저장하기 위한 static 메서드
    static func save(joke: Joke, inViewContext viewContext: NSManagedObjectContext) {
        // 2 - joke.id가 error가 아닌것들만 통과시킴
        guard joke.id != "error" else { return }
        // 3 - entitiyName = JokeManagedObject로 설정하기 위해 fetchRequest 생성
        /// Q: 특정 entityName(JokeManagedObject)에 저장 장소를 지정해두는건지?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: JokeManagedObject.self))
        // 4 - 전달된 joke와 같은 id로 fetch하는걸 joke로 필터링하기 위해 fetchRequest의 조건 설정
        /// NSPredicate - 메모리 내에서 어떤 값을 가져올때 filter에 대한 조건
        /// %@ = 문자열 또는 참조형식 전달할때 사용
        fetchRequest.predicate = NSPredicate(format: "id = %@", joke.id)
        
        // 5 - viewContext의 fetchRequest를 실행시킴 (성공시) joke가 이미 존재한다는 뜻 → 전달된 joke 업데이트
        if let results = try? viewContext.fetch(fetchRequest),
           let existing = results.first as? JokeManagedObject {
            existing.value = joke.value
            existing.categories = joke.categories as NSArray
        } else {
            // 6 - (joke가 없는 경우) 전달된 joke를 새로 생성
            let newJoke = self.init(context: viewContext)
            newJoke.id = joke.id
            newJoke.value = joke.value
            newJoke.categories = joke.categories as NSArray
        }
        
        // 7 - 저장
        do {
            try viewContext.save()
        } catch {
            fatalError("\(#file), \(#function), \(error.localizedDescription)")
        }
    }
}

extension Collection where Element == JokeManagedObject, Index == Int {
    // 1 - 전달된 view context 사용해 전달된 indices에서 object를 삭제 하는 메서드
    func delete(at indices: IndexSet, inViewContext viewContext: NSManagedObjectContext) {
        // 2 - JokeManagedObjects 를 전달해 삭제
        indices.forEach { index in
            viewContext.delete(self[index])
        }
        
        // 3 - 삭제 후 저장
        do {
            try viewContext.save()
        } catch {
            fatalError("\(#file), \(#function), \(error.localizedDescription)")
        }
    }
}

