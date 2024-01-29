//
//  CDTask+CoreDataProperties.swift
//  ToDoList
//
//  Created by Pablo Alarcon on 1/25/24.
//
//

import Foundation
import CoreData


extension CDTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        return NSFetchRequest<CDTask>(entityName: "CDTask")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var title: String?
    @NSManaged public var id: UUID?

}

extension CDTask : Identifiable {

}
