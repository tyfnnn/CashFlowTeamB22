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
    @State private var showingAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Ausgaben Informationen") {
                    TextField("Name", text: $name)
                    TextField("Kosten (€)", text: $amount)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Neue Ausgabe")
            .background(Color("backgroundColor"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        if
                            !name.isEmpty && !amount.isEmpty {
                            saveAusgabe()
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
    
    private func saveAusgabe() {
        guard let amountValue = Double(amount) else { return }
        let neueAusgabe = Ausgabe(amount: amountValue, budget: budget, name: name, date: Date())
        modelContext.insert(neueAusgabe)
        budget.ausgaben.append(neueAusgabe)
        try? modelContext.save()  // Explizites Speichern
    }
}


#Preview {
    AddAusgabeView(budget: Budget(name: "Lebensmittel", limit: 300))
}
