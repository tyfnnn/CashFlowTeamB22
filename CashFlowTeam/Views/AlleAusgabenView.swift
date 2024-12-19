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
                if !ausgaben.isEmpty {  // Prüfung hinzugefügt
                    ForEach(ausgaben) { ausgabe in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(ausgabe.budget.name)
                                .bold()
                            HStack {
                                Text(ausgabe.name)
                                Spacer()
                                Text("\(ausgabe.amount, specifier: "%.2f") €")
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
            .overlay(content: {
                if ausgaben.isEmpty {
                    ContentUnavailableView(label: {
                        Label {
                            Text("Keine Einträge vorhanden")
                        } icon: {
                            Button {
                            } label: {
                                Image(systemName: "document")
                            }
                            .buttonStyle(.plain)
                        }
                    }, description: {
                        Text("Fange an Einträge hinzuzufügen")
                    })
                }
            })
            .scrollContentBackground(.hidden)
            .background(Color("backgroundColor"))
            .navigationTitle("Alle Ausgaben")
            
        }
    }
}

#Preview {
    AlleAusgabenView()
        .modelContainer(for: Ausgabe.self, inMemory: true)
}

/*
 
 */
