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
    
    @State private var showSheet = false
    
    
    var totalLimit: Double {
        budgets.reduce(0) { $0 + $1.limit }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Gesamtbudget:")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    Text("\(totalLimit, specifier: "%.2f") €")
                        .foregroundStyle(.green)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                }
                List(budgets) { budget in
                    NavigationLink(destination: DetailView(budget: budget)) {
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(budget.name)
                                .font(.headline)
                            
                            HStack {
                                Text("\(budget.limit, specifier: "%.2f") €")
                                Spacer()
                                Text("- \(budget.totalExpenses, specifier: "%.2f") €")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            context.delete(budget)
                        }
                    }
                }
                
                .navigationTitle("Budgets")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showSheet) {
                    AddBudgetView()
                }
                .onAppear{
                    context.insert(Budget.budgetSample)
                }
            }
        }
    }
}

#Preview {
    UebersichtView()
        .modelContainer(for: Budget.self, inMemory: true)
}

