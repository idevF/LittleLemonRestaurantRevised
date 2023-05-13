//
//  UserProfileView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 4.05.2023.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var loginVM: LoginViewModel
    
    @State private var showAlert: Bool = false

    var body: some View {

        VStack(alignment: .center) {
            Spacer()
            HeaderView(isLoggedIn: true)
            avatarSection
            formFieldSection
            logoutButton
            discardChangesAndSaveButtons
            Spacer()
        }
        .padding()
    }
    
    // avatar layer
    private var avatarSection: some View {
        Group {
            Text("Personal Information")
                .font(.system(.title3, design: .serif, weight: .bold))
                .foregroundColor(.primary)
                .padding(.bottom)
            
            HStack {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(alignment: .topLeading) {
                        Text("Avatar")
                            .font(.system(.caption, design: .rounded, weight: .medium))
                            .foregroundColor(.secondary)
                            .position(x: 25, y: -10)
                    }
                    .padding(.trailing)
                
                Button {
                    // change
                } label: {
                    Text("Change")
                        .frame(width: 65, height: 5)
                        .brandButtonStyle(foreground: Color("highlightOne"), background: Color("primaryOne"))
                        
                }
//                Spacer()
                Button {
                    // remove
                } label: {
                    Text("Remove")
                        .frame(width: 65, height: 5)
                        .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
                }
                Spacer()
            }
        }
    }
    
    private var formFieldSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            FormFieldView(loginVM: loginVM, title: "First Name", text: $loginVM.user.firstName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: true)

            FormFieldView(loginVM: loginVM, title: "Last Name", text: $loginVM.user.lastName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: false)

            FormFieldView(loginVM: loginVM, title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color.secondary, isSecure: false, isEmail: true, isGivenName: false)

            FormFieldView(loginVM: loginVM, title: "Password", text: $loginVM.user.password, subtitleColor: Color.secondary, isSecure: true, isEmail: false, isGivenName: false)

            Spacer()
            
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
    
    private var logoutButton: some View {
        // Log out
        Button {
            loginVM.logOut()
        } label: {
            Text("Log out")
                .frame(height: 12)
                .foregroundColor(Color("primaryOne"))
                .brandButtonStyle(foreground: Color("secondaryOne"), background: Color("primaryTwo"))
        }
    }
    
    private var discardChangesAndSaveButtons: some View {
        HStack(spacing: 30) {
            // Discard changes
            Button {
                loginVM.discardChanges()
//                print("discard changes \(Thread.current)")
            } label: {
                Text("Discard changes")
                    .frame(width: 135, height: 10)
                    .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
            }
            // Save changes
            Button {
                if loginVM.areFieldsValid {
                    loginVM.isSaved.toggle()
                } else {
                    showAlert.toggle()
                }
//                print(loginVM.areFieldsValid)
            } label: {
                Text("Save changes")
                    .frame(width: 135, height: 10)
                    .brandButtonStyle(foreground: Color("highlightOne"), background: Color("primaryOne"))
            }
            .alert("MISSING INFORMATION", isPresented: $showAlert) {
                Button("Try Again") { }
            } message: {
                Text("Please fill all the required form fields!")
            }
            .alert("NOTICE", isPresented: $loginVM.isSaved) {
                Button("Cancel", role: .cancel) { }
                Button("Save", role: .none) { loginVM.saveChanges() }
            } message: {
                Text("Would you like to save changes?")
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(loginVM: LoginViewModel())
    }
}
