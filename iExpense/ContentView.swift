//
//  ContentView.swift
//  iExpense
//
//  Created by Gilson Cavalcanti on 25/02/22.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    var id = UUID()
    var amount: Double
    var name: String
    var type: String
}

class ExpenseStore: ObservableObject {
    @Published var expenseItems = [ExpenseItem]()
}

struct ContentView: View {
    @StateObject var expenseStore: ExpenseStore = ExpenseStore()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseStore.expenseItems) { item in
                    Text(item.name)
                }
                .onDelete(perform: deleteExpenseItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddView(expenseStore: expenseStore)
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
