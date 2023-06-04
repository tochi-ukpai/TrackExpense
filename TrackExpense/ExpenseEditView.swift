//
//  ExpenseEditView.swift
//  TrackExpense
//
//  Created by Theós on 04/06/2023.
//

import SwiftUI

struct ExpenseEditView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) private var dismiss
    @State var expense = ExpenseItem()
    var isNew = true
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $expense.name)
                Picker("Type", selection: $expense.type) {
                    ForEach(ExpenseItem.ExpenseType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                TextField("Amount", value: $expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("\(isNew ? "Add New" : "Edit") Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem {
                    Button("Save") {
                        if isNew {
                            expenses.addExpense(expense)
                        } else {
                            expenses.updateExpense(expense)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ExpenseEditView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseEditView(expenses: Expenses())
    }
}
