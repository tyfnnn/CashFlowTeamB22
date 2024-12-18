//
//  AddBudgetView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import SwiftUI
import SwiftData

struct AddBudgetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var limitText: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Budget Informationen") {
                    TextField("Name des Budgets", text: $name)
                    TextField("Geplantes Budget (€)", text: $limitText)
                }
            }
            .navigationTitle("Neues Budget")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        if let limit = Double(limitText),
                           !name.isEmpty {
                            let newBudget = Budget(name: name, limit: limit)
                            modelContext.insert(newBudget)
                            dismiss()
                        } else {
                            showingAlert = true
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
            }
            .alert("Ungültige Eingabe",
                   isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text("Bitte geben Sie einen gültigen Namen und/oder Betrag ein.")
            }
        }
    }
}

#Preview {
    AddBudgetView()
}




