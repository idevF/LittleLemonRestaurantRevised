//
//  FormFieldView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import SwiftUI

struct FormFieldView: View {
    // MARK: PROPERTIES
    @ObservedObject var loginVM: LoginViewModel
    
    let title: String
    @Binding var text: String
    let subtitleColor: Color
    let isSecure: Bool
    let isEmail: Bool
    let isGivenName: Bool
    
    // MARK: BODY
    var body: some View {
        Group {
            headerOfTheFormField
            formField
            footerAndValidateFormEntry
        }
        .padding(.vertical, 0)
    }
}

// MARK: PREVIEW
struct FormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            FormFieldView(loginVM: LoginViewModel(), title: "First Name", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: false, isGivenName: true)
            FormFieldView(loginVM: LoginViewModel(), title: "Last Name", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: false, isGivenName: false)
            FormFieldView(loginVM: LoginViewModel(), title: "Email Address", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: true, isGivenName: false)
            FormFieldView(loginVM: LoginViewModel(), title: "Password", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: true, isEmail: false, isGivenName: false)
        }
        //        .padding()
        //        .foregroundColor(Color("highlightOne"))
        //        .background(Color("primaryOne"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

// MARK: COMPONENTS
extension FormFieldView {
    private var headerOfTheFormField: some View {
        Group { Text(title) + Text(" *").foregroundColor(subtitleColor) }.font(.headline)
    }
    
    private var formField: some View {
        Group {
            if isSecure {
                SecureField(title, text: $text)
                    .textContentType(.password)
                    .submitLabel(.done)
            } else {
                TextField(title, text: $text)
                    .textContentType(isEmail ? .emailAddress :
                                        isGivenName ? .givenName : .familyName)
                    .submitLabel(.continue)
            }
        }
        .brandFormFieldStyle(fieldColor: subtitleColor)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .keyboardType(isEmail ? .emailAddress : .default)
    }
    
    private var footerAndValidateFormEntry: some View {
        VStack {
            if !isEmail && !isSecure && !loginVM.isValid(name: text) {
                if isGivenName {
                    return Text("* First Name can only contain letters and cannot be blank.").foregroundColor(.red)
                } else {
                    return Text("* Last Name can only contain letters and cannot be blank.").foregroundColor(.red)
                }
            }
            
            if isEmail && !isSecure && !isGivenName && !loginVM.isValid(email: text) {
                return Text("* The e-mail is invalid and cannot be blank.").foregroundColor(.red)
            }
            
            if !isEmail && isSecure && !isGivenName && !loginVM.isValid(password: text) {
                return Text("* The password must be between 8 and 15 characters containing at least one number and one capital letter.").foregroundColor(.red)
            }
            
            return Text("* Required")
        }
        .font(.system(.caption, design: .default, weight: .semibold))
        .foregroundColor(subtitleColor)
        .padding([.leading, .bottom], 5)
        .fixedSize(horizontal: false, vertical: true)
        
    }
}
