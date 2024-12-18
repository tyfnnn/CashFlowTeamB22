//
//  KontoStand.swift
//  CashFlowTeam
//
//  Created by Jefferson Prensa on 18.12.24.
//

import Foundation
import SwiftData

@Model
class KontoStand{
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
}
