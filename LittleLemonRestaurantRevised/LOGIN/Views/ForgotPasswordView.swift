//
//  ForgotPasswordView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 10.05.2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var loginVM: LoginViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert: Bool = false
    @State private var showResetAlert: Bool = false
    
    var body: some View {
        VStack {
            HeaderView(isLoggedIn: false).padding()
            formFieldSection
            resetButton
        }
        .padding()
        .background(.thinMaterial)
    }
    
    
    private var formFieldSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Please fill the form to reset your password.")
                .font(.system(.subheadline, design: .serif, weight: .semibold))
                .foregroundColor(Color("secondaryOne"))
                .padding(.bottom)
            
            
            FormFieldView(loginVM: loginVM, title: "Last Name", text: $loginVM.user.lastName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: false)
            
            FormFieldView(loginVM: loginVM, title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color.secondary, isSecure: false, isEmail: true, isGivenName: false)
            
        }
    }
    
    private var resetButton: some View {
        // Reset Password button
        Button {
//                print("Reset button \(Thread.current)")
            if loginVM.areFieldsValid {
                showResetAlert.toggle()
            } else {
                showAlert.toggle()
            }
        } label: {
            Text("Reset Password")
                .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
        }
        .alert("MISSING INFORMATION", isPresented: $showAlert) {
            Button("Try Again") { }
        } message: {
            Text("Please fill all the required form fields!")
        }
        .alert("Would you like to Reset Your Password?", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { dismiss() }
            Button("Reset", role: .none) {
                loginVM.isForgotPassword.toggle()
            }
        } message: {
            Text("We will send you a link to your e-mail address for resetting your password.\n Please check your e-mail!")
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(loginVM: LoginViewModel())
    }
}
