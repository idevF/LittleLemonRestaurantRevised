//
//  FormFieldView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 3.05.2023.
//

import SwiftUI

struct FormFieldView: View {
    let title: String
    @Binding var text: String
    let subtitleColor: Color
    
    let isSecure: Bool
    let isEmail: Bool
    let isGivenName: Bool
    var errorMessage: String = ""
    
    var body: some View {
        Group {
            headerOfTheFormField
            
            formField

            footerAndValidateFormEntry
        }
        .padding(.vertical, 0)
    }
    
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
            if !isEmail && !isSecure && !isValid(name: text) {
                if isGivenName {
                    return Text("* First Name can only contain letters and cannot be blank.").foregroundColor(.red)
                } else {
                    return Text("* Last Name can only contain letters and cannot be blank.").foregroundColor(.red)
                }
            }
            
            if isEmail && !isSecure && !isGivenName && !isValid(email: text) {
                return Text("* The e-mail is invalid and cannot be blank.").foregroundColor(.red)
            }
            
            if !isEmail && isSecure && !isGivenName && !isValid(password: text) {
                return Text("* The password must be between 8 and 15 characters containing at least one number and one capital letter.").foregroundColor(.red)
            }
            
            return Text("* Required")
        }
        .font(.system(.caption, design: .default, weight: .semibold))
        .foregroundColor(subtitleColor)
        .padding([.leading, .bottom], 5)
        .fixedSize(horizontal: false, vertical: true)

    }
    
    private func isValid(name: String) -> Bool {
        guard !name.isEmpty else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    private func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
    
    private func isValid(password: String) -> Bool {
        guard !password.isEmpty else { return false }
        let passwordValidationRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
        let passwordValidationPredicate = NSPredicate(format: "SELF MATCHES %@", passwordValidationRegex)
        return passwordValidationPredicate.evaluate(with: password)
    }
}

struct FormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            FormFieldView(title: "First Name", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: false, isGivenName: true)
            FormFieldView(title: "Last Name", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: false, isGivenName: false)
            FormFieldView(title: "Email Address", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: false, isEmail: true, isGivenName: false)
            FormFieldView(title: "Password", text: .constant("required"), subtitleColor: Color("secondaryTwo"), isSecure: true, isEmail: false, isGivenName: false)
        }
//        .padding()
//        .foregroundColor(Color("highlightOne"))
//        .background(Color("primaryOne"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
