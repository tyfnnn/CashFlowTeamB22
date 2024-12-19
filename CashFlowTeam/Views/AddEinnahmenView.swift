//
//  AddEinnahmenView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 18.12.24.
//

import SwiftUI
import SwiftData

struct AddEinnahmenView: View {
    // let einnahmen:Einnahmen
    @Environment(\.modelContext) var modelContext
    //@Binding var einnahmen: [Double]
    @Query var savedEinnahmen: [Einnahmen]  // Add this to query saved entries
    
    @State private var neueEinnahme: String = ""
    @State private var titel: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Neue Einnahme hinzufügen")) {
                    TextField("Titel", text: $titel)
                    TextField("Betrag (€)", text: $neueEinnahme)
                        .keyboardType(.decimalPad)
                    
                    Button("Speichern") {
                        if !neueEinnahme.isEmpty && !titel.isEmpty {
                            save()
                        }
                    }
                    .disabled(neueEinnahme.isEmpty && titel.isEmpty)
                }
                
                //                Section(header: Text("Gespeicherte Einnahmen")) {
                //                    ForEach(einnahmen.indices, id: \.self) { index in
                //                        Text(einnahme.titel)
                //                        Spacer()
                //                        Text("\(einnahme.einnahme, specifier: "%.2f") €")                    }
                //                    .onDelete(perform: deleteEinnahmen)
                //                }
            }
            .navigationTitle("Einnahmen")
        }
    }
    
    private func save() {
        guard let neueEinnahme = Double(neueEinnahme) else { return }
        let neueEinnahmeObjekt = Einnahmen(titel: titel, einnahme: neueEinnahme)
        modelContext.insert(neueEinnahmeObjekt)
        //       einnahmen.append(neueEinnahme)
        try? modelContext.save()
        
        titel = ""
        
    }
    
    private func deleteEinnahmen(at offsets: IndexSet) {
        for index in offsets {
            let einnahme = savedEinnahmen[index]
            modelContext.delete(einnahme)
            //           if let arrayIndex = einnahmen.firstIndex(of: einnahme.einnahme) {
            //              einnahmen.remove(at: arrayIndex)
            //           }
        }
        try? modelContext.save()
    }
}

#Preview {
    var container = try! ModelContainer(for: Einnahmen.self,configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    container.mainContext.insert(Einnahmen(titel: "Wohnungen", einnahme: 800))
    
    return AddEinnahmenView()
        .modelContainer(container)
}
