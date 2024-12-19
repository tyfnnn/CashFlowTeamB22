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
    
    @State private var neueEinnahme: Double = 0
    @State private var titel: String = ""
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                        .ignoresSafeArea()
            NavigationStack {
                Form {
                    Section(header: Text("Neue Einnahme hinzufügen")) {
                        TextField("Titel", text: $titel)
                        TextField("Kosten (€)", value: $neueEinnahme, format: .currency(code: "EUR"))
                            .keyboardType(.decimalPad)
                        
                        Button("Speichern") {
                            if neueEinnahme > 0 {
                                save()
                            }
                        }
                        .disabled(neueEinnahme <= 0 || titel.isEmpty)
                    }
                    Section(header: Text("Gespeicherte Einnahmen")) {
                        ForEach(savedEinnahmen) { einnahme in
                            HStack {
                                Text(einnahme.titel)
                                Spacer()
                                Text("\(einnahme.einnahme, specifier: "%.2f") €")
                            }
                        }
                        .onDelete(perform: deleteEinnahmen)
                    }
                    .listRowBackground(Color("backgroundColor").opacity(0.7))
                    .scrollContentBackground(.hidden)
                }
                .scrollContentBackground(.hidden)
                .background(
                    ZStack {
                        Color("backgroundColor")
                            .ignoresSafeArea()
                        Image("moneyTree")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350)
                            .opacity(0.2)
                    }
                )
            }
        }
    }
    
    private func save() {
        let neueEinnahmeObjekt = Einnahmen(titel: titel, einnahme: neueEinnahme)
        modelContext.insert(neueEinnahmeObjekt)
        try? modelContext.save()
        
        titel = ""
        
    }
    
    private func deleteEinnahmen(at offsets: IndexSet) {
        for index in offsets {
            let einnahme = savedEinnahmen[index]
            modelContext.delete(einnahme)
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
