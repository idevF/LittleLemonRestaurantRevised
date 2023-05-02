//
//  ContentView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 2.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginVM = LoginViewModel()
    
    var body: some View {
        VStack {
            Button("Login") {
                loginVM.checkCredentialsAndLogIn()
            }
            Text(loginVM.isLoggedIn.description)
            Text(loginVM.user.firstName)
            Text(loginVM.user.lastName)
            Text(loginVM.user.emailAddress)
            Text(loginVM.user.password)
            Text(loginVM.error?.localizedDescription ?? "empty" )
            
            Button("Logout") {
                loginVM.logOut()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
