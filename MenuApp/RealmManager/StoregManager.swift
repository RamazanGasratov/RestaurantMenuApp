//
//  NetworkService.swift
//  MenuApp
//
//  Created by macbook on 08.06.2023.
//

import RealmSwift

let realm = try! Realm()

class StorageManger {
    
    static func saveObject(_ place: ModelMain) {
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: ModelMain) {
        
        try! realm.write {
            realm.delete(place)
        }
    }
}
