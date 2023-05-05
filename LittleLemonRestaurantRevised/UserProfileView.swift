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

        VStack(alignment: .leading) {
            HeaderView(isLoggedIn: true)
            
            avatarSection

            VStack(alignment: .leading, spacing: 2) {
                FormFieldView(title: "First Name", text: $loginVM.user.firstName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: true)

                FormFieldView(title: "Last Name", text: $loginVM.user.lastName, subtitleColor: Color.secondary, isSecure: false, isEmail: false, isGivenName: false)
                
                FormFieldView(title: "Email Address", text: $loginVM.user.emailAddress, subtitleColor: Color.secondary, isSecure: false, isEmail: true, isGivenName: false)
                    
                FormFieldView(title: "Password", text: $loginVM.user.password, subtitleColor: Color.secondary, isSecure: true, isEmail: false, isGivenName: false)
            }
            
//            Text("Email notifications")
//                .font(.system(.headline, design: .rounded, weight: .semibold))
//            Label("Order status", systemImage: "square")


            Button {
                // Log out
//                loginVM.user.subscriptions.orderStatus.toggle()
            } label: {
                Text("Log out")
                    .foregroundColor(Color("primaryOne"))
                    .brandButtonStyle(foreground: Color("secondaryOne"), background: Color("primaryTwo"))
            }
            
            HStack(spacing: 30) {
                Button {
                    // Discard changes
                } label: {
                    Text("Discard changes")
                        .frame(width: 135, height: 10)
                        .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
                }

                Button {
                    // Save changes
                } label: {
                    Text("Save changes")
                        .frame(width: 135, height: 10)
                        .brandButtonStyle(foreground: Color("highlightOne"), background: Color("primaryOne"))
                }
   
            }
//            .padding(.vertical)

        }
        .padding()
    }
    
    // avatar layer
    private var avatarSection: some View {
        Group {
            Text("Personal Information")
                .font(.system(.title3, design: .serif, weight: .bold))
                .foregroundColor(Color("primaryOne"))
                .padding()
            
            HStack {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(alignment: .topLeading) {
                        Text("Avatar")
                            .font(.system(.caption, design: .rounded, weight: .medium))
                            .foregroundColor(.gray.opacity(0.8))
                            .position(x: 25, y: -5)
                    }
                    .padding(.trailing)
                
                Button {
                    // change
                } label: {
                    Text("Change")
                        .frame(width: 65, height: 10)
                        .brandButtonStyle(foreground: Color("highlightOne"), background: Color("primaryOne"))
                        
                }
//                Spacer()
                Button {
                    // remove
                } label: {
                    Text("Remove")
                        .frame(width: 65, height: 10)
                        .brandButtonStyle(foreground: Color("primaryOne"), background: Color("highlightOne"))
                }
                Spacer()
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(loginVM: LoginViewModel())
    }
}
