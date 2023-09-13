//
//  TinFoodApp.swift
//  TinFood
//
//  Created by An on 9/13/23.
//

import SwiftUI
import Firebase

@main
struct TinFoodApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
