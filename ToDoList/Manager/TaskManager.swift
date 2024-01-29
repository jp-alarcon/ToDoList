//
//  TaskManager.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//

import Foundation

struct TaskManager {
    
    private let taskDataRepository = TaskDataRepository()
    
    func createTask(record: MyTask) {
        taskDataRepository.create(record: record)
    }
    
    func getAllTasks() -> [MyTask]? {
        return taskDataRepository.getAll()
    }
    
    func updateTask(task: MyTask) -> Bool {
        return taskDataRepository.update(record: task)
    }
    
    func deleteTask(task: MyTask) -> Bool{
        return taskDataRepository.delete(byIdentifier: task.id)
    }
    
}
