//
//  OtherFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/23.
//

import Foundation
import SwiftUI

extension String {
    func removePunctuations() -> String {
        var string = self
        let punctuations: Set<Character> = ["。", "，", "（", "）", "：", "；", "“", ".", ",", "(", ")", ":", ";", "_"]
        string.removeAll(where: { punctuations.contains($0) })
        return string
    }
}

func hideKeyboard() { // 隐藏键盘
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
    case "真实姓名": // 可由2到5个汉字或1到32位大小写字母及空格组成
        textTypeExpression = "^[\u{4e00}-\u{9fa5}]{2,5}|[A-Za-z\\s]{1,32}$"
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

func readJSONData(fileName: String) -> Data? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
        do {
            let jsonData = try String(contentsOfFile: path).data(using: .utf8)
            return jsonData
        } catch {
            print(error)
        }
    }
    return nil
}
