//
//  User.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/23.
//

import Foundation

func confirmTextTypeMatch(textType: String, textContent: String) -> Bool {// 匹配昵称格式
    var textTypeExpression = ""
    switch textType {
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

