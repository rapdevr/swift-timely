//
//  TimelyApp.swift
//  Timely
//
//  Created by Rishi Thiahulan on 13/12/2023.
//

import SwiftUI
import SwiftData

@main
struct TimelyApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
        .modelContainer(for: JourneyItem.self)
    }
}
