//
//  AddView.swift
//  iExpense
//
//  Created by Gilson Cavalcanti on 26/02/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenseStore: ExpenseStore
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("description", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button() {
                    let newItem = ExpenseItem(amount: amount, name: name, type: type)
                    
                    expenseStore.expenseItems.append(newItem)
                    dismiss()
                } label: {
                    Text("Add")
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenseStore: ExpenseStore())
    }
}
