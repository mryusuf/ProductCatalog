//
//  ProductCatalogApp.swift
//  ProductCatalog
//
//  Created by Indra Permana on 04/07/23.
//

import SwiftUI

@main
struct ProductCatalogApp: App {
    @StateObject private var controller = HomeControllerDefault()
    @StateObject private var coreDataController = CoreDataController()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen<HomeControllerDefault>()
                .environmentObject(controller)
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
