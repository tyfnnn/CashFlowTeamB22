//
//  EditAusgabeView.swift
//  CashFlowTeam
//
//  Created by Tayfun Ilker on 17.12.24.
//

import SwiftUI
import SwiftData

struct EditAusgabeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @Binding var ausgabe: Ausgabe 
    
    var body: some View {
        Text("hallo")
        NavigationStack {
            Form {
                Section("Informationen") {
                    TextField("Name", text: $name)
                    TextField("Kosten (€)", text: $amount)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Ausgabe bearbeiten")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
//                        saveAusgabe()
//                        dismiss()
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
        ausgabe.name = name
        ausgabe.amount = amountValue
        ausgabe.date = Date()
    
        }
}

#Preview {
    EditAusgabeView(budget: Budget(name: "Lebensmittel", limit: 300), ausgabe: Ausgabe(amount: 50, budget: Budget.budgetSample, name: "Europapark", date: .now), ausgabe1: .constant(Ausgabe(amount: 0.0, budget: Budget.budgetSample, name: "test", date: .now)))
}

