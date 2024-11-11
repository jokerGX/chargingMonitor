// ChargingMonitorApp.swift

import SwiftUI
import FirebaseCore

@main
struct ChargingMonitorApp: App {
    init() {
        FirebaseApp.configure()
        print("Firebase configured successfully.")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
