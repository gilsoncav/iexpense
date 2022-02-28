//
//  ContentView.swift
//  iExpense
//
//  Created by Gilson Cavalcanti on 25/02/22.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let amount: Double
    let name: String
    let type: String
}

class ExpenseStore: ObservableObject {
    @Published var expenseItems = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let expenseItems = try? encoder.encode(expenseItems) {
                UserDefaults.standard.set(expenseItems, forKey: "ExpenseStore.expenseItems")
            }
        }
    }
    
    init() {
        if let expenseItemsJSON = UserDefaults.standard.data(forKey: "ExpenseStore.expenseItems") {
            if let expenseItemsLoaded = try? JSONDecoder().decode([ExpenseItem].self, from: expenseItemsJSON) {
                expenseItems = expenseItemsLoaded
            }
        } else {
            expenseItems = []
        }
    }
}

struct ContentView: View {
    @StateObject var expenseStore: ExpenseStore = ExpenseStore()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseStore.expenseItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.title3)
                            Text(item.type)
                                .font(.caption)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
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
