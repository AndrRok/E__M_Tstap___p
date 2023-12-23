//
//  CustomTextField.swift
//  EMTstapp
//
//  Created by ARMBP on 12/19/23.
//

import SwiftUI

struct CustomTextField: View {
    private let emailMode: Bool
    private let phoneMode: Bool
    private let placeHolder: String
    private let secondaryLabelColor: Color = Color(red: 0.66, green: 0.67, blue: 0.72)
    @Binding private var bodyText: String
    @FocusState private var isFocused: Bool
    
    init(emailMode: Bool =  false, phoneMode: Bool = false, placeHolder: String, bodyText: Binding<String>) {
        self.emailMode = emailMode
        self.phoneMode = phoneMode
        self.placeHolder = placeHolder
        self._bodyText = bodyText
    }
    
    var body: some View {
        
        ZStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 0){
                if bodyText.count != 0 {
                    Text(self.placeHolder)
                        .foregroundColor(secondaryLabelColor)
                        .font(.system(size: 12))
                        .padding(.init(top: 4, leading: 8, bottom: 0, trailing: 8))
                }
                
                TextField("", text: $bodyText)
                    .font(.system(size: 16))
                    .padding(.horizontal, 8)
                    .focused($isFocused)
            }
            
            Text( bodyText.count == 0 ? self.placeHolder : "")
                .foregroundColor(secondaryLabelColor)
                .font(.system(size: 17))
                .padding(.horizontal, 8)
        }
        .onTapGesture {
            isFocused.toggle()
        }
        .frame(height: 52)
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundStyle( (isValidEmail(bodyText) || !emailMode || bodyText.isEmpty) ?
                              Color(red: 0.96, green: 0.96, blue: 0.98) : Color.red)
                    
        )
        .padding(8)
        .onChange(of: self.bodyText) {
            if phoneMode{
                bodyText = bodyText.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    CustomTextField(placeHolder: "placeHolder", bodyText: .constant("dd"))
}
