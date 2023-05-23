//
//  Persistence.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 23.05.2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MenuDataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            } else {
                print("Successfully loaded Core Data!")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
