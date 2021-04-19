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
    @Binding var textFieldOffset: CGFloat
    
    @State private var nicknameOffset: CGFloat = 200
    @State private var realnameOffset: CGFloat = 150
    @State private var idOffset: CGFloat = 100
    @State private var emailaddressOffset: CGFloat = 50
    @State private var passwordOffset: CGFloat = 0
    @State private var repeatPasswordOffset: CGFloat = -50
    
    @State private var usernameOffset: CGFloat = 200
    @State private var newPasswordOffset: CGFloat = 0
    @State private var repeatNewPasswordOffset: CGFloat = -50
    
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
                                if self.textType == "昵称" {
                                    self.textFieldOffset = self.nicknameOffset
                                } else if self.textType == "真实姓名" {
                                    self.textFieldOffset = self.realnameOffset
                                } else if self.textType == "身份证号" {
                                    self.textFieldOffset = self.idOffset
                                } else if self.textType == "邮箱" {
                                    self.textFieldOffset = self.emailaddressOffset
                                } else if self.textType == "密码" {
                                    self.textFieldOffset = self.passwordOffset
                                } else if self.textType == "再次输入密码" {
                                    self.textFieldOffset = self.repeatPasswordOffset
                                } else if self.textType == "账号" {
                                    self.textFieldOffset = self.usernameOffset
                                } else if self.textType == "新密码" {
                                    self.textFieldOffset = self.newPasswordOffset
                                } else if self.textType == "再次输入新密码" {
                                    self.textFieldOffset = self.repeatNewPasswordOffset
                                }
                            }
                            if !isBegin {
                                if !confirmTextTypeMatch(textType: textType, textContent: textContent) {
                                    textWarningOpacity = 1
                                } else {
                                    textWarningOpacity = 0
                                }
                                self.textFieldOffset = 0
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
    @State static var textFieldOffset: CGFloat = 0
    static var previews: some View {
        RegisterTextField(
            textType: "昵称", textContent: $textContent,
            textWarningOpacity: $textWarningOpacity,
            formatRequirement: "可由1到32个汉字、大小写字母和数字组成", textFieldOffset: $textFieldOffset)
    }
}
