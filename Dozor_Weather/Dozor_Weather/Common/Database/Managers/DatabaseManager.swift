//
//  DatabaseManager.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 29.09.2024.
//

import Foundation
import RealmSwift
class DatabaseManager {
    
    static let shared: DatabaseManager = DatabaseManager()
    public let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func add<T: Object>(model: T) {
        try? realm.write {
            self.realm.add(model)
        }
    }
    
    func update<T: Object>(model: T) {
        try? realm.write{
            realm.add(model, update: .all)
        }
    }
    
    func remove<T: Object>(model: T) {
        try? realm.write {
            self.realm.delete(model)
        }
    }
    
    func removeAll() {
        try? realm.write {
            self.realm.deleteAll()
        }
    }
    
    func getAll<T: Object>() -> [T] {
        let objects = realm.objects(T.self)
        return objects.map({$0})
    }
}

