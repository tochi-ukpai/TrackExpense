//
//  Expenses.swift
//  TrackExpense
//
//  Created by Theós on 04/06/2023.
//

import Foundation

class Expenses: ObservableObject {
    static let userDefaultsKey = "ExpenseItems"
    
    @Published var items: [ExpenseItem] {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encodedItems, forKey: Expenses.userDefaultsKey)
            }
        }
    }
    
    init() {
        if let savedItemsData = UserDefaults.standard.data(forKey: Expenses.userDefaultsKey) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItemsData) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    // MARK: User Actions
    
    func removeExpense(_ item: ExpenseItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    
    func addExpense(_ item: ExpenseItem) {
        items.append(item)
    }
    
    func updateExpense(_ item: ExpenseItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
    }
}
