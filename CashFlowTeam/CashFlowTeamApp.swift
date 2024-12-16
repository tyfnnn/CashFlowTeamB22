//
//  CashFlowTeamApp.swift
//  CashFlowTeam
//
//  Created by Tayfun Ilker on 16.12.24.
//

import SwiftUI
import SwiftData

@main
struct CashFlowTeamApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView()
                .modelContainer(for: Budget.self)
        }
    }
}
