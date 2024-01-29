//
//  TaskDataRepository.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//

import Foundation
import CoreData

struct TaskDataRepository: BaseRepository {
    
    typealias T = MyTask
    
    func create(record: MyTask) {
        let cdTask = CDTask(context: PersistentStorage.shared.context)
        cdTask.id = record.id
        cdTask.title = record.title
        cdTask.completed = record.completed
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [MyTask]? {
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDTask.self)
        guard records != nil && records?.count != 0 else {
            return nil
        }
        
        let results: [MyTask] = records!.map{ CDTask in
            return CDTask.convertToTask()
        }
        
        return results
    }
    
    func get(byIdentifier id: UUID) -> MyTask? {
        let result = self.getCDTask(byId: id)
        guard result != nil else {
            return nil
        }
        
        return result!.convertToTask()
    }
    
    func update(record: MyTask) -> Bool {
        let cdTask = self.getCDTask(byId: record.id)
        guard cdTask != nil else {
            return false
        }
        
        cdTask?.title = record.title
        cdTask?.completed = record.completed
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func delete(byIdentifier id: UUID) -> Bool {
        let cdTask = self.getCDTask(byId: id)
        guard cdTask != nil else {
            return false
        }
        
        PersistentStorage.shared.context.delete(cdTask!)
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    private func getCDTask(byId id: UUID) -> CDTask? {
        let fetchRequest = NSFetchRequest<CDTask>(entityName: "CDTask")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById
        
        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {
            return nil
        }
        
        return result.first
    }
    
}
