//
//  CoreDataController.swift
//  ProductCatalog
//
//  Created by Indra Permana on 06/07/23.
//

import CoreData

final class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "ProductCatalog")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                debugPrint("Core Data Error: \(error.localizedDescription)")
            }
        }
    }
}
