//
//  PersistentStorage.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//

import Foundation
import CoreData

final class PersistentStorage {
    
    static let shared = PersistentStorage()
    
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Error")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("error")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            return result
        } catch {
            
        }
        return nil
    }
}
