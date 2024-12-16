//
//  AddAusgabeView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import SwiftUI
import SwiftData

struct AddAusgabeView: View {
    let budget: Budget
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var amount: String = ""
   
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Ausgaben Informationen") {
                    TextField("Name", text: $name)
                    TextField("Kosten (€)", text: $amount)
                }
            }
            .navigationTitle("Neues Ausgabe")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        saveAusgabe()
                        dismiss()
                    }
                }
            
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveAusgabe() {
        guard let amountValue = Double(amount) else { return }
        let neueAusgabe = Ausgabe(amount: amountValue, budget: budget, name: name, date: Date())
            modelContext.insert(neueAusgabe)
            budget.ausgaben.append(neueAusgabe)
        }
}

#Preview {
    AddAusgabeView(budget: Budget(name: "Lebensmittel", limit: 300))
}
