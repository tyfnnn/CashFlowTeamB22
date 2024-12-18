//
//  EinkommenView.swift
//  CashFlowTeam
//
//  Created by Jefferson Prensa on 18.12.24.
//

import SwiftUI
import SwiftData

struct EinkommenView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingAlert = false
    @State var gehalt: Double = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Einnahmen") {
                    TextField("Einkommen (€)", value: $gehalt, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                }
            }
            Button("Speichern") {
                
                if gehalt >= 0 {
                    let einkommen = KontoStand(balance: gehalt)
                    modelContext.insert(einkommen)
                } else {
                    showingAlert = true
                }
                
            }
            
            .buttonStyle(.borderedProminent)
            .navigationTitle("Einnahmen")
            .toolbar{
                //     .overlay {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        
                    }label: {
                        Image(systemName:"plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                //  }
            }
            .alert("Ungültige Eingabe",
                   isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text("Bitte geben Sie einen gültigen Namen und/oder Betrag ein.")
            }
            
        }
    }
    private func saveEinkommen() {
   //     let neueEinkommen = KontoStand(balance:  )
        
    }
}

#Preview {
    EinkommenView(gehalt: 0.0)
}
