//
//  NavigationView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        TabView {
            Tab {
                UebersichtView()
            } label: {
                Label ("Budget", systemImage: "eurosign")
            }
            Tab {
                AlleAusgabenView()
            } label: {
                Label ("Ausgaben", systemImage: "minus.circle")
            }
        }
    }
}

#Preview {
    NavigationView()
        .modelContainer(for: Budget.self, inMemory: false)
}
