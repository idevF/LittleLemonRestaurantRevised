//
//  LoginView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import SwiftUI

struct LoginView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var loginVM: LoginViewModel
    @FocusState private var focusedField: Field?
    @State private var showAlert: Bool = false
    
    enum Field: Hashable {
        case emailField
        case passwordField
    }
    
    // MARK: BODY
    var body: some View {
        VStack {
            HeaderView(isLoggedIn: loginVM.isLoggedIn)
            Spacer()
            HeroView(isLoggedIn: loginVM.isLoggedIn, searchText: .constant(""))
            Spacer()
            formFieldCardView
            showProgressView
            Spacer()
            buttonsSection
        }
        
    }
}

// MARK: PREVIEW
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
            .padding()
    }
}

// MARK: COMPONENTS
extension LoginView {
    private var formFieldCardView: some View {
        VStack(alignment: .leading) {
            
            FormFieldView(title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: true, isGivenName: false)
                .focused($focusedField, equals: .emailField)
            
            FormFieldView(title: "Password", text: $loginVM.user.password, subtitleColor: Color("secondaryTwo"), isSecure: true, isEmail: false, isGivenName: false)
                .focused($focusedField, equals: .passwordField)
        }
        .cardViewStyle()
    }
    
    private var showProgressView: some View {
        Group {
            if loginVM.isConnecting {
                ProgressView("Connecting....")
                    .progressViewStyle(.circular)
                    .tint(Color("secondaryOne"))
                    .foregroundColor(Color("secondaryOne"))
            }
        }
    }
    
    private var buttonsSection: some View {
        VStack {
            HStack {
                // Sign Up button
                Button {
                    //                        print("Sign Up button \(Thread.current)")
                    loginVM.isSignUp.toggle()
                } label: {
                    Text("Sign Up")
                        .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
                }
                .sheet(isPresented: $loginVM.isSignUp) {
                    SignUpView()
                }
                // Log In button
                Button {
                    //                        print("login button \(Thread.current)")
                    if loginVM.areFieldsValid {
                        loginVM.checkCredentialsAndLogIn()
                        
                    } else {
                        showAlert.toggle()
                    }
                    
                    // FocusState logic
                    if loginVM.user.emailAddress.isEmpty {
                        focusedField = .emailField
                    } else if loginVM.user.password.isEmpty {
                        focusedField = .passwordField
                    } else {
                        loginVM.checkCredentialsAndLogIn()
                        focusedField = nil
                    }
                } label: {
                    Text("Log In")
                        .brandButtonStyle(foreground: Color("highlightOne"), background: Color("primaryOne"))
                }
                .alert("MISSING INFORMATION", isPresented: $showAlert) {
                    Button("Try Again") { }
                } message: {
                    Text("Please fill all the required form fields!")
                }
                .alert(isPresented: $loginVM.isError, error: loginVM.error) {
                    Button("Try Again") { }
                }
            }
            
            Text("Forgot Password ?")
                .font(.system(.subheadline, design: .default, weight: .semibold))
                .foregroundColor(Color.secondary)
                .padding()
                .onTapGesture {
                    loginVM.isForgotPassword.toggle()
                }
                .sheet(isPresented: $loginVM.isForgotPassword) {
                    ForgotPasswordView()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
        }
    }
}
