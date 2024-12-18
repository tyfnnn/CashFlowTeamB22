//
//  Einnahmen.swift
//  CashFlowTeam
//
//  Created by Dilara Öztas on 18.12.24.
//


import Foundation
import SwiftData

@Model
class Einnahmen {
    var einnahme: Double
    
    init(einnahme: Double) {
        self.einnahme = einnahme
    }
}
