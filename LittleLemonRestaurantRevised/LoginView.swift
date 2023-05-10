//
//  LoginView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM: LoginViewModel
    
    enum Field: Hashable {
        case emailField
        case passwordField
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            HeaderView(isLoggedIn: loginVM.isLoggedIn)
            Spacer()
            HeroView(isLoggedIn: loginVM.isLoggedIn)
            Spacer()
            VStack(alignment: .leading) {
                
                FormFieldView(loginVM: loginVM, title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: true, isGivenName: false)
                    .focused($focusedField, equals: .emailField)
                    
                FormFieldView(loginVM: loginVM, title: "Password", text: $loginVM.user.password, subtitleColor: Color("secondaryTwo"), isSecure: true, isEmail: false, isGivenName: false)
                    .focused($focusedField, equals: .passwordField)
            }
            .cardViewStyle()
            Spacer()
            VStack {
                
                HStack {
                    // Sign Up button
                    Button {
                        print("Sign Up button \(Thread.current)")
                        loginVM.isSignUp.toggle()
                    } label: {
                        Text("Sign Up")
                            .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
                    }
                    .sheet(isPresented: $loginVM.isSignUp) {
                        SignUpView(loginVM: loginVM)
                    }
                    
                    Button {
                        print("login button \(Thread.current)")
                        print("login button \(loginVM.isLoggedIn)")
                        loginVM.checkCredentialsAndLogIn()
                        
                        // FocusState logic
                        if loginVM.user.emailAddress.isEmpty {
                            focusedField = .emailField
                        } else if loginVM.user.password.isEmpty {
                            focusedField = .passwordField
                        } else {
                            loginVM.checkCredentialsAndLogIn()
                            focusedField = nil
                            print("Log In")
                        }
                    } label: {
                        Text("Log In")
                            .brandButtonStyle(foreground: Color("highlightOne"), background: Color("primaryOne"))
                    }
                }
                
                if loginVM.isConnecting {
                    ProgressView("Connecting....")
                        .progressViewStyle(.circular)
                        .tint(Color("secondaryOne"))
                        .foregroundColor(Color("secondaryOne"))                        
                }
                
                Text("Forgot Password ?")
                    .font(.system(.subheadline, design: .default, weight: .semibold))
                    .foregroundColor(Color.secondary)
                    .padding()
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel())
            .padding()
    }
}
