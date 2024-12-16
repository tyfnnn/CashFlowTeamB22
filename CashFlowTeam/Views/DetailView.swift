//
//  DetailView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let budget: Budget

    @State private var showAddAusgabeSheet = false
    @Query(sort: \Ausgabe.name) var ausgabeListe: [Ausgabe]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    if budget.ausgaben.isEmpty {
                        Text("Keine Einträge vorhanden")
                    } else {
                        ForEach(budget.ausgaben) { ausgabe in
                            HStack {
                                Text(ausgabe.name)
                                Spacer()
                                Text("\(ausgabe.amount, specifier: "%.2f") €")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                Spacer()
                Button {
                    showAddAusgabeSheet = true
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
        }
        .navigationTitle(budget.name)
        .sheet(isPresented: $showAddAusgabeSheet) {
            AddAusgabeView(budget: budget)
        }
       
    }
}

#Preview {
    DetailView(budget: Budget(name: "Lebensmittel", limit: 200))
        .modelContainer(for: Budget.self, inMemory: true)
}
