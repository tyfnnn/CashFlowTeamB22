//
//  Ausgaben.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 16.12.24.
//

import Foundation
import SwiftData

@Model
class Ausgabe {
    var amount: Double
    var budget: Budget
    var name: String
    var date: Date

    init(amount: Double, budget: Budget, name: String, date: Date) {
        self.amount = amount
        self.budget = budget
        self.name = name
        self.date = date
    }
}
