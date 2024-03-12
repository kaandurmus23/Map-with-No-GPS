//
//  Map_with_No_GPSApp.swift
//  Map with No GPS
//
//  Created by Kaan on 13.03.2024.
//

import SwiftUI

@main
struct Map_with_No_GPSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
