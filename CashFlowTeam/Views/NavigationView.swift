//
//  NavigationView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import SwiftUI

struct NavigationView: View {
    @State private var einnahmen: [Double] = []

    var body: some View {
        TabView {
            Tab {
                UebersichtView(einnahmen: $einnahmen)
            } label: {
                Label ("Home", systemImage: "house")
            }
            Tab {
                AddEinnahmenView(einnahmen: $einnahmen)
            } label: {
                Label ("Einnahmen", systemImage: "eurosign")
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
