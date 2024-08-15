//
//  CoreDataManager.swift
//  InstaSport
//
//  Created by Youssif Hany on 14/08/2024.
//

import CoreData

class CoreDataManager {
static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteLeagueModel") 
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
