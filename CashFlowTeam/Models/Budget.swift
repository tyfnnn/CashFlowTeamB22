//
//  Budget.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import Foundation
import SwiftData

@Model
class Budget {
    var name: String
    var limit: Double
    var totalExpenses: Double {
        ausgaben.reduce(0) { $0 + $1.amount }
    }
    
    @Relationship(inverse: \Ausgabe.budget) var ausgaben: [Ausgabe]

    init(name: String, limit: Double) {
        self.name = name
        self.limit = limit
        self.ausgaben = []
    }
}
