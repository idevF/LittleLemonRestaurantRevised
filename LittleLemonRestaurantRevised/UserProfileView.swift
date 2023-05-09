//
//  UserProfileView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 4.05.2023.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var loginVM: LoginViewModel

    var body: some View {

        VStack(alignment: .center) {
            Spacer()
            
            HeaderView(isLoggedIn: true)
            
            avatarSection

            VStack(alignment: .leading, spacing: 2) {
                FormFieldView(loginVM: loginVM, title: "First Name", text: $loginVM.user.firstName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: true)

                FormFieldView(loginVM: loginVM, title: "Last Name", text: $loginVM.user.lastName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: false)

                FormFieldView(loginVM: loginVM, title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color.secondary, isSecure: false, isEmail: true, isGivenName: false)

                FormFieldView(loginVM: loginVM, title: "Password", text: $loginVM.user.password, subtitleColor: Color.secondary, isSecure: true, isEmail: false, isGivenName: false)

                Spacer()
                
                subscriptionsSection

            }

            // Log out
            Button {
                loginVM.logOut()
            } label: {
                Text("Log out")
                    .frame(height: 12)
                    .foregroundColor(Color("primaryOne"))
                    .brandButtonStyle(foreground: Color("secondaryOne"), background: Color("primaryTwo"))
            }
            
            HStack(spacing: 30) {
                // Discard changes
                Button {
                    loginVM.discardChanges()
                    print("discard changes \(Thread.current)")
                } label: {
                    Text("Discard changes")
                        .frame(width: 135, height: 10)
                        .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
                }
                // Save changes
                Button {
                    loginVM.isSaved.toggle()
                } label: {
                    Text("Save changes")
                        .frame(width: 135, height: 10)
                        .brandButtonStyle(foreground: Color("highlightOne"), background: Color("primaryOne"))
                }
                .alert("NOTICE", isPresented: $loginVM.isSaved) {
                    Button("Cancel", role: .cancel) { }
                    Button("Save", role: .none) { loginVM.saveChanges() }
                } message: {
                    Text("Would you like to save changes?")
                }

   
            }
            .padding(.vertical, 5)
//            Spacer()
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
    
    private var subscriptionsSection: some View {
        Group {
            Text("Email notifications")
                .font(.system(.headline, design: .rounded, weight: .semibold))
            
            ForEach($loginVM.user.subscriptions) { item in
                Label(item.wrappedValue.name.rawValue,
                      systemImage: item.wrappedValue.isSelected ? "square" : "checkmark.square.fill")
                    .font(.system(.subheadline, design: .rounded, weight: .regular))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            item.wrappedValue.isSelected.toggle()
                        }
                    }
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(loginVM: LoginViewModel())
    }
}
