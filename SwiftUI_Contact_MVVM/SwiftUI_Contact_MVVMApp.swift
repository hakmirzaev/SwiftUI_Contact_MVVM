//
//  SwiftUI_Contact_MVVMApp.swift
//  SwiftUI_Contact_MVVM
//
//  Created by Bekhruz Hakmirzaev on 26/04/23.
//

import SwiftUI

@main
struct SwiftUI_Contact_MVVMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
