//
//  LoginView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM: LoginViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Group { Text("Email Address") + Text(" *").foregroundColor(Color("secondaryTwo")) }.font(.headline)
                TextField("Email Address", text: $loginVM.user.emailAddress)
                    .font(.headline)
                    .foregroundColor(Color("secondaryTwo"))
                    .padding(10)
                    .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 5))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("secondaryTwo"), lineWidth: 1))

                Text("* Required")
                    .font(.system(.caption, design: .default, weight: .semibold))
                    .foregroundColor(Color("secondaryTwo"))
                
                Group { Text("Password") + Text(" *").foregroundColor(Color("secondaryTwo")) }.font(.headline)
                SecureField("Password", text: $loginVM.user.password)
                    .font(.headline)
                    .foregroundColor(Color("secondaryTwo"))
                    .padding(10)
                    .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 5))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("secondaryTwo"), lineWidth: 1))
                
                Text("* Required")
                    .font(.system(.caption, design: .default, weight: .semibold))
                    .foregroundColor(Color("secondaryTwo"))
                    
            }
            .padding()
            .foregroundColor(Color("highlightOne"))
            .background(Color("primaryOne"), in: RoundedRectangle(cornerRadius: 10))
            
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
                        loginVM.checkCredentialsAndLogIn()
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
                    .foregroundColor(Color("primaryOne"))
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
