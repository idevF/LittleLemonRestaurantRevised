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
            HeroView()
            
            VStack(alignment: .leading) {
                FormFieldView(title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: true, isGivenName: false)
                    .focused($focusedField, equals: .emailField)
                    
                FormFieldView(title: "Password", text: $loginVM.user.password, subtitleColor: Color("secondaryTwo"), isSecure: true, isEmail: false, isGivenName: false)
                    .focused($focusedField, equals: .passwordField)
            }
            .cardViewStyle()
            
            VStack {
                
                HStack {
                    Button {
                        print("Sign Up button \(Thread.current)")
                        
                    } label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(Color("primaryOne"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("highlightOne"), in: RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2))
                    }
                    
                    Button {
                        print("login button \(Thread.current)")
                        print("login button \(loginVM.isLoggedIn)")
//                        loginVM.checkCredentialsAndLogIn()
                        
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
                            .font(.headline)
                            .foregroundColor(Color("highlightOne"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("primaryOne"), in: RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2))
                    }
                }
                
                Text("Forgot Password ?")
                    .font(.system(.subheadline, design: .default, weight: .semibold))
                    .foregroundColor(Color.secondary)
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
