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

func confirmTextTypeMatch(textType: String, textContent: String) -> Bool {// 匹配昵称格式
    var textTypeExpression = ""
    switch textType {
    case "账号": // 注册后得到的8位数字
        textTypeExpression = "^[0-9]{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", textTypeExpression)
        if !predicate.evaluate(with: textContent) {
            return false
        } else {
            return true
        }
    case "昵称": // 可由汉字、大小写字母和数字组成
        textTypeExpression = "^[\u{4e00}-\u{9fa5}A-Za-z0-9]{1,32}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", textTypeExpression)
        if !predicate.evaluate(with: textContent) {
            return false
        } else {
            return true
        }
    case "真实姓名": // 可由2到5位汉字组成
        textTypeExpression = "^[\u{4e00}-\u{9fa5}]{2,5}|[A-Za-z]{1,32}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", textTypeExpression)
        if !predicate.evaluate(with: textContent) {
            return false
        } else {
            return true
        }
    case "身份证号": // 18位
        textTypeExpression = "^[0-9]{17}[0-9Xx]$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", textTypeExpression)
        if !predicate.evaluate(with: textContent) {
            return false
        } else {
            return true
        }
    case "邮箱":
        textTypeExpression = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", textTypeExpression)
        if !predicate.evaluate(with: textContent) {
            return false
        } else {
            return true
        }
    case "密码": // 可由字母和数字组成，至少8位密码，最多32位
        textTypeExpression = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,32}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", textTypeExpression)
        if !predicate.evaluate(with: textContent) {
            return false
        } else {
            return true
        }
    case "再次输入密码": // 可由字母和数字组成，至少8位密码，最多32位
        textTypeExpression = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,32}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", textTypeExpression)
        if !predicate.evaluate(with: textContent) {
            return false
        } else {
            return true
        }
    default:
        return true
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
