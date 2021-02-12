//
//  NetworkAPIFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/6.
//

import Foundation
import Alamofire

class CreatedMistake: Encodable { // 错题
    var subject: String // 错题所属学科：语文、数学、英语等
    var category: String // 错题类型：近义词、反义词等
    var questionDescription: String // 题干描述："写出下列词语的反义词。"
    var questionItems: [CreatedQuestionItem] // 题目项数组
    
    enum CodingKeys: CodingKey {
        case subject
        case category
        case questionDescription
        case questionItems
    }
    
    init(subject: String, category: String, questionDescription: String, createdQuestionItems: [CreatedQuestionItem]) {
        self.subject = subject
        self.category = category
        self.questionDescription = questionDescription
        self.questionItems = createdQuestionItems
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subject, forKey: .subject)
        try container.encode(category, forKey: .category)
        try container.encode(questionDescription, forKey: .questionDescription)
        try container.encode(questionItems, forKey: .questionItems)
    }
}

class CreatedQuestionItem: Encodable { // 题目项
    var question: String // 题目
    var rightAnswer: String // 正确答案
    
    enum CodingKeys: CodingKey {
        case question
        case rightAnswer
    }
    
    init(question: String, rightAnswer: String) {
        self.question = question
        self.rightAnswer = rightAnswer
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(question, forKey: .question)
        try container.encode(rightAnswer, forKey: .rightAnswer)
    }
}

class NetworkAPIFunctions {
    var delegate: DataDelegate?
    static let functions = NetworkAPIFunctions()
    
    func login(user: User, loginStatus: LoginStatus) {
        AF.request("http://47.100.54.54:8080/login",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in
                let userStr = String(data: response.data!, encoding: .utf8)!
                print(userStr)
                if userStr == "0" {
                    loginStatus.wrongPasswordAlert = true // 账号密码不匹配
                } else if userStr == "-1" {
                    loginStatus.inexistentUsernameAlert = true // 账号不存在
                } else {
                    self.delegate?.fetch(newData: userStr) // 登录成功
                    loginStatus.loginSuccessfully = true
                }
        }
    }
    func createMistake(mistake: Mistake) {
        var createdQuestionItems = [CreatedQuestionItem]()
        var i = 0
        while i < mistake.questionItems.count {
            createdQuestionItems.append(
                CreatedQuestionItem(
                    question: mistake.questionItems[i].question,
                    rightAnswer: mistake.questionItems[i].rightAnswer))
            i = i + 1
        }
        let createdMistake = CreatedMistake(
            subject: mistake.subject,
            category: mistake.category,
            questionDescription: mistake.questionDescription,
            createdQuestionItems: createdQuestionItems)
        AF.request("http://47.100.54.54:8080/createMistake",
            method: .post,
            parameters: createdMistake,
            encoder: JSONParameterEncoder.default).response { response in
                debugPrint(response)}
    }
    func updateMistake(mistake: Mistake) {
        AF.request("http://47.100.54.54:8080/updateMistake",
            method: .post,
            parameters: mistake,
            encoder: JSONParameterEncoder.default).response { response in
                debugPrint(response)}
    }
    func deleteMistake(mistake: Mistake) {
        AF.request("http://47.100.54.54:8080/deleteMistake",
            method: .post,
            parameters: mistake,
            encoder: JSONParameterEncoder.default).response { response in
                debugPrint(response)}
    }
    func register(user: User) {
        AF.request("http://47.100.54.54:8080/register",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in
                user.username = String(data: response.data!, encoding: .utf8)!
            }
    }
}

