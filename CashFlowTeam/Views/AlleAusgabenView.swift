//
//  AusgabenView.swift
//  CashFlowTeam
//
//  Created by Kim Reuter on 17.12.24.
//

import SwiftUI
import SwiftData

struct AlleAusgabenView: View {
    //    @Query private var budgets: [Budget]
    @Query(sort:\Ausgabe.date,order:.reverse) var ausgaben: [Ausgabe]
    //    @State private var alleAusgaben:
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
                VStack {
                    if ausgaben.isEmpty {
                        Text("Keine Einträge vorhanden!")
                    } else {
                        ForEach(ausgaben) { ausgabe in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(ausgabe.budget.name)
                                    .bold()
                                HStack {
                                    Text(ausgabe.name)
                                    Spacer()
                                    Text("\(ausgabe.amount, specifier: "%.2f") €")
                                    //            Text(ausgabe.date)
                                    
                                }
                                Text(ausgabe.date, style:.date)
                            }
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    context.delete(ausgabe)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Alle Ausgaben")
            
        }
    }
}

#Preview {
    AlleAusgabenView()
        .modelContainer(for: Ausgabe.self, inMemory: true)
}
