//
//  ContentView.swift
//  iExpense
//
//  Created by Gilson Cavalcanti on 25/02/22.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName: String = "Bilbo"
    @Published var lastName: String = "Baggins"
}

struct GilsonView: View {
    @State var name: String
    @Environment(\.dismiss) var coelhinho
    
    var body: some View {
        Text("Hello \(name)!")
        Button("Dismiss!") {
            coelhinho()
        }
    }
}

struct ContentView: View {
    @StateObject var user: User = User()
    @State private var isShowingGilsonView = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        VStack {
            List {
                ForEach($numbers, id: \.self) { $num in
                    Text("\(num)")
                }
                .onDelete(perform: deleteNumber)
            }
            Text("Hello \(user.firstName) \(user.lastName)! ")
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
            
            HStack {
                Button("Show new View") {
                    isShowingGilsonView.toggle()
                }
                Button("Add Item") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
        }
        .sheet(isPresented: $isShowingGilsonView) {
            GilsonView(name: user.firstName)
        }
    }
    
    func deleteNumber(at indexSet: IndexSet) {
        numbers.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
