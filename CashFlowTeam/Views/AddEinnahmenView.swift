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
                            let neueEinnahmeObjekt = Einnahmen(titel: titel, einnahme: neueEinnahme)
                            context.insert(neueEinnahmeObjekt)
                            einnahmen.append(neueEinnahme)
                            saveEinnahmen()
                            neueEinnahme = 0
                        }
                    }
                    .disabled(neueEinnahme <= 0 || titel.isEmpty)
                }
                
                Section(header: Text("Gespeicherte Einnahmen")) {
                    ForEach(einnahmen.indices, id: \.self) { index in
                        Text("Einnahme \(index + 1): \(einnahmen[index], specifier: "%.2f") €")
                    }
                }
            }
            .navigationTitle("Einnahmen")
        }
    }
    
    private func saveEinnahmen() {
        
    }
}

#Preview {
    @State var testEinnahmen: [Double] = [100.0, 200.0]
    AddEinnahmenView(einnahmen: $testEinnahmen)
        .modelContainer(for: Einnahmen.self, inMemory: true)
}
