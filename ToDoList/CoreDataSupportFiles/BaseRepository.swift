//
//  BaseRepository.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//

import Foundation

protocol BaseRepository {
    
    associatedtype T
    
    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: UUID) -> Bool
    
}
