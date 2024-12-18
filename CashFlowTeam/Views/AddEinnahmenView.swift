//
//  AddEinnahmenView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 18.12.24.
//

import SwiftUI
import SwiftData

struct AddEinnahmenView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var einnahmen: [Double]
    @State private var neueEinnahme: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Neue Einnahme hinzufügen")) {
                    TextField("Betrag", text: $neueEinnahme)
                        .keyboardType(.decimalPad)
                    
                    Button("Speichern") {
                        if let betrag = Double(neueEinnahme), betrag > 0 {
                            einnahmen.append(betrag)
                            neueEinnahme = ""
                        }
                    }
                    .disabled(neueEinnahme.isEmpty)
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
    
}

#Preview {
    @State var testEinnahmen: [Double] = [100.0, 200.0]
    AddEinnahmenView(einnahmen: $testEinnahmen)
        .modelContainer(for: Einnahmen.self, inMemory: true)
}
