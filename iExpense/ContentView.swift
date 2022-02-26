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

struct ContentView: View {
    @StateObject private var user: User = User()
    
    
    var body: some View {
        VStack {
            Text("Hello \(user.firstName) \(user.lastName)! ")
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
