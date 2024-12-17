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
    @State private var amount: Double = 0
    @Bindable var ausgabe: Ausgabe
    
    init(ausgabe: Ausgabe) {
        self.ausgabe = ausgabe
        _name = State(initialValue: ausgabe.name)
        _amount = State(initialValue: Double(ausgabe.amount))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Informationen") {
                    TextField("Name", text: $name)
                    // Währungsformatierung in Eur als Double
                    TextField("Kosten (€)", value: $amount, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Ausgabe bearbeiten")
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
        ausgabe.name = name
        ausgabe.amount = amount
        ausgabe.date = Date()
    
        }
}

#Preview {
    EditAusgabeView(ausgabe: Ausgabe.sample)
        .modelContainer(for: Budget.self, inMemory: true)
}
