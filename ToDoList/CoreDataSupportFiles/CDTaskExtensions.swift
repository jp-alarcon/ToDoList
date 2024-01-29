//
//  CDTaskExtensions.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//

import Foundation

extension CDTask {
    func convertToTask() -> MyTask {
        return MyTask(title: self.title!, completed: self.completed, id: self.id!)
    }
}
