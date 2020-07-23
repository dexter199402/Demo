//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by  邱偉豪 on 2020/7/23.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var date: Date?

}
