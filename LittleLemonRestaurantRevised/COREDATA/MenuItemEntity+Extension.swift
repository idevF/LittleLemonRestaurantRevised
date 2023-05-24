//
//  MenuItemEntity+Extension.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 23.05.2023.
//

import Foundation
import CoreData

extension MenuItemEntity {
    
    var entityTitle: String {
        title ?? ""
    }
    
    var entityExplanation: String {
        explanation ?? ""
    }
    
    var entityMenuCategory: String {
        menuCategory ?? ""
    }
    
    var entityPrice: String {
        price ?? ""
    }
    
    var entityImage: String {
        image ?? ""
    }
    
    static func populateMenuItemsFrom(JSONMenu: [JSONMenu.MenuItem], _ context:NSManagedObjectContext) {
        
        for JSONMenuItem in JSONMenu {
            guard let _ = exists(title: JSONMenuItem.title, context) else { continue }
            
            let newMenuItem = MenuItemEntity(context: context)
            newMenuItem.id = Int64(JSONMenuItem.id)
            newMenuItem.title = JSONMenuItem.title
            newMenuItem.explanation = JSONMenuItem.description
            newMenuItem.price = JSONMenuItem.price
            newMenuItem.menuCategory = JSONMenuItem.menuCategory
            newMenuItem.image = JSONMenuItem.image
        }
    }
    
    static func exists(title: String, _ context:NSManagedObjectContext) -> Bool? {
        let request = MenuItemEntity.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [MenuItemEntity] else { return nil }
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
    static func deleteAll(_ context:NSManagedObjectContext) {
        let request = MenuItemEntity.request()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
            context.reset()
            save(context)

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func save(_ context:NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error {
            print("Unresolved error \(error.localizedDescription)")
        }
    }
    
    static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    static func example(_ context:NSManagedObjectContext) -> MenuItemEntity {
        let exampleItem = MenuItemEntity(context: context)
        exampleItem.id = Int64(4)
        exampleItem.title = "Pasta"
        exampleItem.explanation = "Penne with fried aubergines, cherry tomatoes, tomato sauce, fresh chilli, garlic, basil & salted ricotta cheese."
        exampleItem.price = "10"
        exampleItem.menuCategory = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/pasta.jpg?raw=true"
        exampleItem.image = "mains"
        return exampleItem
    }
}
