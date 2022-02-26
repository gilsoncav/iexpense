//
//  ContentView.swift
//  iExpense
//
//  Created by Gilson Cavalcanti on 25/02/22.
//

import SwiftUI

struct ExpenseItem {
    var amount: Double
    var name: String
    var type: String
}

class ExpenseStore: ObservableObject {
    @Published var expenseItems = [ExpenseItem]()
}

struct ContentView: View {
    @StateObject var expenseStore: ExpenseStore = ExpenseStore()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseStore.expenseItems, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: deleteExpenseItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    let newItem = ExpenseItem(amount: 34.4, name: "Farmacia", type: "health")
                    expenseStore.expenseItems.append(newItem)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func deleteExpenseItem(at indexSet: IndexSet) {
        expenseStore.expenseItems.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
