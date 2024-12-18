//
//  AddEinnahmenView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 18.12.24.
//

import SwiftUI
import SwiftData

struct AddEinnahmenView: View {
    @Environment(\.modelContext) var context
    @Binding var einnahmen: [Double]
    @Query var savedEinnahmen: [Einnahmen]  // Add this to query saved entries

    @State private var neueEinnahme: Double = 0
    @State private var titel: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Neue Einnahme hinzufügen")) {
                    TextField("Titel", text: $titel)
                    TextField("Betrag", value: $neueEinnahme, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                    
                    Button("Speichern") {
                        if neueEinnahme > 0 {
                            saveEinnahmen()
                        }
                    }
                    .disabled(neueEinnahme <= 0 || titel.isEmpty)
                }
                
                Section(header: Text("Gespeicherte Einnahmen")) {
                    ForEach(einnahmen.indices, id: \.self) { index in
                        Text("Einnahme \(index + 1): \(einnahmen[index], specifier: "%.2f") €")
                    }
                    .onDelete(perform: deleteEinnahmen)
                }
            }
            .navigationTitle("Einnahmen")
        }
    }
    
    private func saveEinnahmen() {
        guard neueEinnahme > 0 else { return }
        let neueEinnahmeObjekt = Einnahmen(titel: titel, einnahme: neueEinnahme)
        context.insert(neueEinnahmeObjekt)
        einnahmen.append(neueEinnahme)
        try? context.save()  // Explizites Speichern
        
        // Reset input fields
        titel = ""
        neueEinnahme = 0
    }
    
    private func deleteEinnahmen(at offsets: IndexSet) {
        for index in offsets {
            let einnahme = savedEinnahmen[index]
            context.delete(einnahme)
            if let arrayIndex = einnahmen.firstIndex(of: einnahme.einnahme) {
                einnahmen.remove(at: arrayIndex)
            }
        }
    }
}

#Preview {
    @State var testEinnahmen: [Double] = [100.0, 200.0]
    AddEinnahmenView(einnahmen: $testEinnahmen)
        .modelContainer(for: Einnahmen.self, inMemory: true)
}
