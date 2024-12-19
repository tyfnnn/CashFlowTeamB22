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

 
    
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            
            NavigationStack {
                List {
                    if budget.ausgaben.isEmpty {
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
                        .listRowBackground(Color("backgroundColor").opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
                .overlay(alignment: .bottom) {
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
                    .padding(.bottom, 25)
                }
                Spacer()

            }
        }
        .overlay(content: {
            if budget.ausgaben.isEmpty {
                ContentUnavailableView(label: {
                    Label {
                        Text("Keine Einträge vorhanden")
                    } icon: {
                        Button {
                        } label: {
                            Image(systemName: "document")
                        }
                        .buttonStyle(.plain)
                    }
                }, description: {
                    Text("Fange an Einträge hinzuzufügen")
                }, actions: {
                    Button {
                        showAddAusgabeSheet = true
                    } label: {
                        Text("Füge Jobs hinzu")
                    }
                })
            }
        })
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
