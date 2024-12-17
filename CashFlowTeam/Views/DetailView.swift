//
//  DetailView.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let budget: Budget
    @Environment(\.modelContext) private var context
    @State private var showAddAusgabeSheet = false

    @State var showEditSheet = false
    
    
    var body: some View {
        NavigationStack {
            List {
                if budget.ausgaben.isEmpty {
                    Text("Keine Einträge vorhanden")
                } else {
                    ForEach(budget.ausgaben) { ausgabe in
                        NavigationLink(destination: EditAusgabeView(ausgabe: ausgabe)) {
                            HStack {
                                Text(ausgabe.name)
                                Spacer()
                                Text("\(ausgabe.amount, specifier: "%.2f") €")
                            }
                        }
                    }
                    .onDelete(perform: deleteAusgabe)
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
            }
            Spacer()
            .overlay{
                Button {
                    showAddAusgabeSheet = true
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
            .onAppear{
                context.insert(Ausgabe.sample)
            }
        }
        .navigationTitle(budget.name)
        .sheet(isPresented: $showAddAusgabeSheet) {
            AddAusgabeView(budget: budget)
        }
    }
    
    private func deleteAusgabe(at offsets: IndexSet) {
        for index in offsets {
            let ausgabe = budget.ausgaben[index]
            budget.deleteAusgabe(ausgabe)
            context.delete(ausgabe)
        }
    }
}

#Preview {
    DetailView(budget: Budget(name: "Lebensmittel", limit: 200))
        .modelContainer(for: Budget.self, inMemory: true)
}
