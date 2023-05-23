//
//  LittleLemonRestaurantRevisedApp.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import SwiftUI

@main
struct LittleLemonRestaurantRevisedApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
