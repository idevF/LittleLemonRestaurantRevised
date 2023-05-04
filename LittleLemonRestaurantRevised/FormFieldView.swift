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
    
    var body: some View {
        Group {
            Group { Text(title) + Text(" *").foregroundColor(subtitleColor) }.font(.headline)
            
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

            Text("* Required")
                .font(.system(.caption, design: .default, weight: .semibold))
                .foregroundColor(subtitleColor)
                .padding(.bottom, 5)
        }
        .padding(.vertical, 0)
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
