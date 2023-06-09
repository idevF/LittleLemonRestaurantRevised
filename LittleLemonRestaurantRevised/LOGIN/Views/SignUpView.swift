//
//  SignUpView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 9.05.2023.
//

import SwiftUI

struct SignUpView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var loginVM: LoginViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showAlert: Bool = false
    @State private var showSignInAlert: Bool = false
    
    // MARK: BODY
    var body: some View {
        VStack {
            headerSection
            formFieldSection
            signInButton
        }
        .padding()
        .background(.thinMaterial)
    }
}

// MARK: PREVIEW
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(LoginViewModel())
    }
}

// MARK: COMPONENTS
extension SignUpView {
    private var headerSection: some View {
        HeaderView(isLoggedIn: false).padding()
            .overlay(alignment: .topLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Quit", systemImage: "xmark.app.fill")
                        .foregroundColor(Color("secondaryOne"))
                        .font(.subheadline)
                }
            }
    }
    
    private var formFieldSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Please fill the form below to discover delicious food!")
                .font(.system(.subheadline, design: .serif, weight: .semibold))
                .foregroundColor(Color("secondaryOne"))
                .padding(.bottom)
            
            FormFieldView(title: "First Name", text: $loginVM.user.firstName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: true)
            
            FormFieldView(title: "Last Name", text: $loginVM.user.lastName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: false)
            
            FormFieldView(title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color.secondary, isSecure: false, isEmail: true, isGivenName: false)
            
            FormFieldView(title: "Password", text: $loginVM.user.password, subtitleColor: Color.secondary, isSecure: true, isEmail: false, isGivenName: false)
            
            subscriptionsSection
        }
    }
    
    private var subscriptionsSection: some View {
        Group {
            Text("Email notifications")
                .font(.system(.headline, design: .rounded, weight: .semibold))
            
            ForEach($loginVM.user.subscriptions) { $item in
                Label(item.name.rawValue,
                      systemImage: item.isSelected ? "checkmark.square.fill" : "square")
                .font(.system(.subheadline, design: .rounded, weight: .regular))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        item.isSelected.toggle()
                    }
                }
            }
        }
    }
    
    private var signInButton: some View {
        // Sign In button
        Button {
            //            print("Sign In button \(Thread.current)")
            if loginVM.areFieldsValid {
                showSignInAlert.toggle()
            } else {
                showAlert.toggle()
            }
        } label: {
            Text("Sign In")
                .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
        }
        .alert("MISSING INFORMATION", isPresented: $showAlert) {
            Button("Try Again") { }
        } message: {
            Text("Please fill all the required form fields!")
        }
        .alert("CONGRATS!", isPresented: $showSignInAlert) {
            Button("OK") { dismiss() }
        } message: {
            Text("A confirmation message has sent to your e-mail address. Please confirm the link in the message to login!")
        }
    }
}
