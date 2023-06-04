//
//  ExpenseItem.swift
//  TrackExpense
//
//  Created by Theós on 04/06/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name = ""
    var type: ExpenseType = .Personal
    var amount = 0.0
    
    enum ExpenseType: String, CaseIterable, Codable {
        case Business, Personal
    }
}
