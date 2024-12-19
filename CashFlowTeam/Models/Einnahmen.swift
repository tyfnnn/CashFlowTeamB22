//
//  Einnahmen.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 18.12.24.
//


import Foundation
import SwiftData

@Model
class Einnahmen: Identifiable {
    var titel: String
    var einnahme: Double
    
    init(titel: String, einnahme: Double) {
        self.einnahme = einnahme
        self.titel = titel
    }
}
