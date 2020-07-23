//
//  LoveModel.swift
//  FlickrDemo
//
//  Created by  邱偉豪 on 2020/7/22.
//  Copyright © 2020 邱偉豪. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct LoveModel {
    
    private static let app = UIApplication.shared.delegate
        as! AppDelegate
    private static let myContext = app.persistentContainer.viewContext
    
    static func addEntity(title:String, imageUrl:String) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: myContext ) as! Entity
        entity.title = title
        entity.imageUrl = imageUrl
        entity.date = Date()
        app.saveContext()
    }
    
    static func getEntity(url:String) -> Entity? {
        let request = Entity.fetchRequest() as NSFetchRequest<Entity>
        request.predicate = NSPredicate(format: "imageUrl CONTAINS[cd] %@", url)
        do {
            let entitys = try myContext.fetch(request)
            for entity in entitys {
                return entity
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    static func getAllEntity() -> [Entity]? {
        let request = NSFetchRequest<Entity>(entityName: "Entity" )
        request.sortDescriptors =
        [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let entitys = try myContext.fetch(request)
            return entitys
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    static func deleteEntity(url:String) {
       let request = Entity.fetchRequest() as NSFetchRequest<Entity>
        request.predicate = NSPredicate(format: "imageUrl CONTAINS[cd] %@", url)
        do {
            let entitys = try myContext.fetch(request)
            for entity in entitys {
                myContext.delete(entity)
            }
            app.saveContext()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}
