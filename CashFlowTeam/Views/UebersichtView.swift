//
//  UebersichtView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import SwiftUI
import SwiftData

struct UebersichtView: View {
    @Environment(\.modelContext) private var context
    @Query private var budgets: [Budget]
    @Query var einnahmen: [Einnahmen]
    @State private var showSheet = false
    
    var totalEinnahmen: Double {
        einnahmen.map(\.einnahme).reduce(0, +)
    }
    
    var totalLimit: Double {
        budgets.reduce(0) { $0 + $1.limit }
    }
    
    var totalExpenses: Double {
        budgets.reduce(0) { $0 + $1.totalExpenses }
    }
    
    var availableBudget: Double {
        totalLimit - totalExpenses
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                Image("dagobertDuck")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 390)
                    .opacity(0.5)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Guthaben")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                        Spacer()
                        Text("\(totalEinnahmen, specifier: "%.2f") €")
                            .foregroundStyle(.green)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                    }
                    HStack {
                        Text("Gesamtbudget:")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                        Spacer()
                        Text("\(totalLimit, specifier: "%.2f") €")
                            .foregroundStyle(.green)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                    }
                    HStack {
                        Text("Verfügbar:")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                        Spacer()
                        Text("\(availableBudget, specifier: "%.2f") €")
                            .foregroundStyle(.green)
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                        
                    }
                    List(budgets) { budget in
                        NavigationLink(destination: DetailView(budget: budget)) {
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(budget.name)
                                    .font(.headline)
                                
                                HStack {
                                    Text("\(budget.limit, specifier: "%.2f") €")
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text("- \(budget.totalExpenses, specifier: "%.2f") €")
                                        .foregroundColor(.red)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteBudget(budget)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                        .listRowBackground(Color("backgroundColor").opacity(0.7))
                        .scrollContentBackground(.hidden)
                    }
                    .navigationTitle("Budgets")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showSheet = true }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .overlay(content: {
                        if budgets.isEmpty {
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
                            }, actions: {
                                Button {
                                    showSheet = true
                                } label: {
                                    Text("Füge Budgets hinzu")
                                }
                            })
                        }
                    })
                    .sheet(isPresented: $showSheet) {
                        AddBudgetView()
                    }
                }
            }
        }
        
    }
    
    private func deleteBudget(_ budget: Budget) {
        // Erst alle Ausgaben löschen
        for ausgabe in budget.ausgaben {
            context.delete(ausgabe)
        }
        
        // Dann das Budget selbst löschen
        context.delete(budget)
        
        // Optional: Änderungen sofort speichern
        try? context.save()
    }
}

//#Preview {
//    UebersichtView(einnahmen: $einnahmen)
//        .modelContainer(for: Budget.self, inMemory: true)
//}

