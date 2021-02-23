//
//  RegisterTextField.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/23.
//

import SwiftUI

struct RegisterTextField: View {
    var textType: String
    @Binding var textContent: String
    @Binding var textWarningOpacity: Double
    var formatRequirement: String
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                HStack {
                    Text("\(textType)：")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    TextField(
                        "",
                        text: $textContent,
                        onEditingChanged: { isBegin in
                            if isBegin {
                                textWarningOpacity = 0
                            }
                            if !isBegin {
                                if !confirmTextTypeMatch(textType: textType, textContent: textContent) {
                                    textWarningOpacity = 1
                                } else {
                                    textWarningOpacity = 0
                                }
                            }
                        })
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.system(size: 16))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Spacer()
                    Label("", systemImage: "exclamationmark.triangle")
                        .opacity(textWarningOpacity)
                        .foregroundColor(.red)
                }
            }
            HStack {
                Text("\(formatRequirement)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

struct RegisterTextField_Previews: PreviewProvider {
    @State static var textContent = "889"
    @State static var textWarningOpacity: Double = 1
    static var previews: some View {
        RegisterTextField(
            textType: "昵称", textContent: $textContent,
            textWarningOpacity: $textWarningOpacity,
            formatRequirement: "可由1到32个汉字、大小写字母和数字组成")
    }
}
