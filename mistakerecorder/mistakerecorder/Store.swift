//
//  Store.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/3.
//

import Foundation

protocol DataDelegate {
    func fetch(newData: String)
}

class User: ObservableObject, Codable { // 用户
    @Published var username: String
    @Published var nickname: String
    @Published var realname: String
    @Published var idcard: String
    @Published var emailaddress: String
    @Published var password: String
    @Published var avatar: String
    @Published var mistakeList: [Mistake] // 错题列表
    
    enum CodingKeys: CodingKey {
        case username
        case nickname
        case realname
        case idcard
        case emailaddress
        case password
        case avatar
        case mistakeList
    }
    
    init(username: String, nickname: String, realname: String, idcard: String, emailaddress: String, password: String, avatar: String) {
        self.username = username
        self.nickname = nickname
        self.realname = realname
        self.idcard = idcard
        self.emailaddress = emailaddress
        self.password = password
        self.avatar = avatar
        self.mistakeList = [
            Mistake(subject: "错题学科一", category: "错题类型一", questionDescription: "题干描述一",
                    questionItems: [
                        QuestionItem(question: "题目一", rightAnswer: "答案一"),
                        QuestionItem(question: "题目二", rightAnswer: "答案二"),
                        QuestionItem(question: "题目三", rightAnswer: "答案三")
                    ]),
            Mistake(subject: "错题学科二", category: "错题类型二", questionDescription: "题干描述二",
                    questionItems: [
                        QuestionItem(question: "题目一", rightAnswer: "答案一"),
                        QuestionItem(question: "题目二", rightAnswer: "答案二"),
                        QuestionItem(question: "题目三", rightAnswer: "答案三")
                    ]),
            Mistake(subject: "错题学科三", category: "错题类型三", questionDescription: "题干描述三",
                    questionItems: [
                        QuestionItem(question: "题目一", rightAnswer: "答案一"),
                        QuestionItem(question: "题目二", rightAnswer: "答案二"),
                        QuestionItem(question: "题目三", rightAnswer: "答案三")
                    ])
        ]
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try values.decode(String.self, forKey: .username)
        self.nickname = try values.decode(String.self, forKey: .nickname)
        self.realname = try values.decode(String.self, forKey: .realname)
        self.idcard = try values.decode(String.self, forKey: .idcard)
        self.emailaddress = try values.decode(String.self, forKey: .emailaddress)
        self.password = try values.decode(String.self, forKey: .password)
        self.avatar = try values.decode(String.self, forKey: .avatar)
        self.mistakeList = try values.decode([Mistake].self, forKey: .mistakeList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(realname, forKey: .realname)
        try container.encode(idcard, forKey: .idcard)
        try container.encode(emailaddress, forKey: .emailaddress)
        try container.encode(password, forKey: .password)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(mistakeList, forKey: .mistakeList)
    }
}

class Mistake: ObservableObject, Identifiable, Codable { // 错题
    @Published var subject: String // 错题所属学科：语文、数学、英语等
    @Published var category: String // 错题类型：近义词、反义词等
    @Published var questionDescription: String // 题干描述："写出下列词语的反义词。"
    @Published var questionItems: [QuestionItem] // 题目项数组
    @Published var createdDate: String // 创建的时间
    @Published var revisedRecords: [RevisedRecord] // 已经复习的记录
    @Published var nextRevisionDate: String // 下一次复习的时间
    @Published var revisionStatus: String // 正在复习标记
    
    func equals(mistake: Mistake) -> Bool {
        if self.subject == mistake.subject &&
            self.category == mistake.category &&
            self.questionDescription == mistake.questionDescription &&
            self.createdDate == mistake.createdDate &&
            self.nextRevisionDate == mistake.nextRevisionDate &&
            self.revisionStatus == mistake.revisionStatus {
            return true
        } else {
            return false
        }
    }
    
    func totalRevisionEvaluation() -> Double { // 根据所有复习记录计算总的复习进度，返回值在[0, 1]之间
        var progress: Double = 0
        
        let familiar: Double = 100 // 掌握为100分
        let vague: Double = 50 // 模糊为50分
        let forgotten: Double = 0 // 忘记为0分
        
        if self.revisedRecords.count != 0 {
            for record in self.revisedRecords {
                if record.revisedPerformance == "掌握" {
                    progress += familiar
                } else if record.revisedPerformance == "模糊" {
                    progress += vague
                } else {
                    progress += forgotten
                }
            }
            progress /= Double(self.revisedRecords.count) * 100.0
        }
        
        return progress
    }
    
    func isRevising() -> Bool {
        if self.revisionStatus == "true" {
            return true
        } else {
            return false
        }
    }
    
    func toggleRevisionStatus() {
        if self.revisionStatus == "true" {
            self.revisionStatus = "false"
        } else {
            self.revisionStatus = "true"
        }
    }
    
    enum CodingKeys: CodingKey {
        case subject
        case category
        case questionDescription
        case questionItems
        case createdDate
        case revisedRecords
        case nextRevisionDate
        case revisionStatus
    }
    
    init(subject: String, category: String, questionDescription: String, questionItems: [QuestionItem]) {
        self.subject = subject
        self.category = category
        self.questionDescription = questionDescription
        self.questionItems = questionItems
        self.createdDate = DateFunctions.functions.currentDate()
        self.revisedRecords = [
            RevisedRecord(revisedDate: "3/3/21", revisedPerformance: "掌握"),
            RevisedRecord(revisedDate: "3/8/21", revisedPerformance: "模糊"),
            RevisedRecord(revisedDate: "3/13/21", revisedPerformance: "忘记"),
            RevisedRecord(revisedDate: "3/15/21", revisedPerformance: "模糊"),
            RevisedRecord(revisedDate: "3/17/21", revisedPerformance: "掌握"),
            RevisedRecord(revisedDate: "3/23/21", revisedPerformance: "模糊")]
        self.nextRevisionDate = DateFunctions.functions.currentDate()
        self.revisionStatus = "false"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.subject = try values.decode(String.self, forKey: .subject)
        self.category = try values.decode(String.self, forKey: .category)
        self.questionDescription = try values.decode(String.self, forKey: .questionDescription)
        self.questionItems = try values.decode([QuestionItem].self, forKey: .questionItems)
        self.createdDate = try values.decode(String.self, forKey: .createdDate)
        self.revisedRecords = try values.decode([RevisedRecord].self, forKey: .revisedRecords)
        self.nextRevisionDate = try values.decode(String.self, forKey: .nextRevisionDate)
        self.revisionStatus = try values.decode(String.self, forKey: .revisionStatus)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subject, forKey: .subject)
        try container.encode(category, forKey: .category)
        try container.encode(questionDescription, forKey: .questionDescription)
        try container.encode(questionItems, forKey: .questionItems)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(revisedRecords, forKey: .revisedRecords)
        try container.encode(nextRevisionDate, forKey: .nextRevisionDate)
        try container.encode(revisionStatus, forKey: .revisionStatus)
    }
}

struct RevisedRecord: Codable { // 已复习记录
    let revisedDate: String
    let revisedPerformance: String
}

class QuestionItem: ObservableObject, Identifiable, Codable { // 题目项
    @Published var question: String // 题目
    @Published var rightAnswer: String // 正确答案
    
    enum CodingKeys: CodingKey {
        case question
        case rightAnswer
    }
    
    init(question: String, rightAnswer: String) {
        self.question = question
        self.rightAnswer = rightAnswer
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.question = try values.decode(String.self, forKey: .question)
        self.rightAnswer = try values.decode(String.self, forKey: .rightAnswer)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(question, forKey: .question)
        try container.encode(rightAnswer, forKey: .rightAnswer)
    }
}
