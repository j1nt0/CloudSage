//
//  CloudSageApp.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI
import SwiftData

@main
struct CloudSageApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: CloudDB.self)
        }
    }
}
