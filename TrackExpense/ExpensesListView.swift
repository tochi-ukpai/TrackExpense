//
//  ExpensesListView.swift
//  TrackExpense
//
//  Created by Theós on 02/06/2023.
//

import SwiftUI

struct ExpensesListView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var expenseEdit: ExpenseItem?
    
    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter { $0.type == .Personal }) { item in
                        listItem(item)
                    }
                }
                
                Section("Business") {
                    ForEach(expenses.items.filter { $0.type == .Business }) { item in
                        listItem(item)
                    }
                }
            }
            .navigationTitle("TrackExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                ExpenseEditView(expenses: expenses)
            }
            .sheet(item: $expenseEdit) {
                ExpenseEditView(expenses: expenses, expense: $0, isNew: false)
            }
       }
    }
    
    func listItem(_ item: ExpenseItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.rawValue)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .bold()
        }
        .swipeActions {
            Button(role: .destructive) {
                expenses.removeExpense(item)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            Button {
                expenseEdit = item
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListView()
    }
}
