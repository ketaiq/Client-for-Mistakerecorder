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
    var _id: String
    @Published var username: String
    @Published var nickname: String
    @Published var realname: String
    @Published var idcard: String
    @Published var emailaddress: String
    @Published var password: String
    @Published var avatar: String
    @Published var mistakeList: [Mistake] // 错题列表
//    @Published var revisingList: [RevisingMistake] // 待复习列表
    
    enum CodingKeys: CodingKey {
        case _id
        case username
        case nickname
        case realname
        case idcard
        case emailaddress
        case password
        case avatar
        case mistakeList
//        case revisingList
    }
    
    init(_id: String, username: String, nickname: String, realname: String, idcard: String, emailaddress: String, password: String, avatar: String) {
        self._id = _id
        self.username = username
        self.nickname = nickname
        self.realname = realname
        self.idcard = idcard
        self.emailaddress = emailaddress
        self.password = password
        self.avatar = avatar
        self.mistakeList = [Mistake]()
//        self.revisingList = [RevisingMistake]()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try values.decode(String.self, forKey: ._id)
        self.username = try values.decode(String.self, forKey: .username)
        self.nickname = try values.decode(String.self, forKey: .nickname)
        self.realname = try values.decode(String.self, forKey: .realname)
        self.idcard = try values.decode(String.self, forKey: .idcard)
        self.emailaddress = try values.decode(String.self, forKey: .emailaddress)
        self.password = try values.decode(String.self, forKey: .password)
        self.avatar = try values.decode(String.self, forKey: .avatar)
        self.mistakeList = try values.decode([Mistake].self, forKey: .mistakeList)
//        self.revisingList = try values.decode([RevisingMistake].self, forKey: .revisingList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(username, forKey: .username)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(realname, forKey: .realname)
        try container.encode(idcard, forKey: .idcard)
        try container.encode(emailaddress, forKey: .emailaddress)
        try container.encode(password, forKey: .password)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(mistakeList, forKey: .mistakeList)
//        try container.encode(revisingList, forKey: .revisingList)
    }
}

class MistakeStore: ObservableObject { // 错题列表
    @Published var list: [Mistake] = mistakeListExample
}

class RevisingMistakeStore: ObservableObject { // 复习题列表
    @Published var list: [RevisingMistake] = revisingMistakeListExample
}

class Mistake: ObservableObject, Identifiable, Codable { // 错题
    var _id: String
    @Published var subject: String // 错题所属学科：语文、数学、英语等
    @Published var category: String // 错题类型：近义词、反义词等
    @Published var questionDescription: String // 题干描述："写出下列词语的反义词。"
    @Published var questionItems: [QuestionItem] // 题目项数组
    
    enum CodingKeys: CodingKey {
        case _id
        case subject
        case category
        case questionDescription
        case questionItems
    }
    
    init(_id: String, subject: String, category: String, questionDescription: String, questionItems: [QuestionItem]) {
        self._id = _id
        self.subject = subject
        self.category = category
        self.questionDescription = questionDescription
        self.questionItems = questionItems
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try values.decode(String.self, forKey: ._id)
        self.subject = try values.decode(String.self, forKey: .subject)
        self.category = try values.decode(String.self, forKey: .category)
        self.questionDescription = try values.decode(String.self, forKey: .questionDescription)
        self.questionItems = try values.decode([QuestionItem].self, forKey: .questionItems)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(subject, forKey: .subject)
        try container.encode(category, forKey: .category)
        try container.encode(questionDescription, forKey: .questionDescription)
        try container.encode(questionItems, forKey: .questionItems)
    }
}

class RevisingMistake: ObservableObject, Identifiable { // 复习题
    var _id: String
    @Published var mistake: Mistake
    @Published var occupyFullScreen: Bool = false
    
    init(_id: String, mistake: Mistake) {
        self._id = _id
        self.mistake = mistake
    }
}

class QuestionItem: ObservableObject, Identifiable, Codable { // 题目项
    var _id: String
    @Published var question: String // 题目
    @Published var rightAnswer: String // 正确答案
    
    enum CodingKeys: CodingKey {
        case _id
        case question
        case rightAnswer
    }
    
    init(_id: String, question: String, rightAnswer: String) {
        self._id = _id
        self.question = question
        self.rightAnswer = rightAnswer
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try values.decode(String.self, forKey: ._id)
        self.question = try values.decode(String.self, forKey: .question)
        self.rightAnswer = try values.decode(String.self, forKey: .rightAnswer)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(question, forKey: .question)
        try container.encode(rightAnswer, forKey: .rightAnswer)
    }
}

var revisingMistakeListExample = [revisingMistakeExample1, revisingMistakeExample2, revisingMistakeExample3, revisingMistakeExample4]
var mistakeListExample = [mistakeExample1, mistakeExample2, mistakeExample3, mistakeExample4]
var mistakeExample1 = Mistake(
    _id: "",
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(_id: "", question: "认真", rightAnswer: "马虎"),
        QuestionItem(_id: "", question: "长", rightAnswer: "短"),
        QuestionItem(_id: "", question: "高兴", rightAnswer: "难过"),
        QuestionItem(_id: "", question: "早", rightAnswer: "晚")]
)
var mistakeExample2 = Mistake(
    _id: "",
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(_id: "", question: "认真", rightAnswer: "马虎"),
        QuestionItem(_id: "", question: "长", rightAnswer: "短"),
        QuestionItem(_id: "", question: "高兴", rightAnswer: "难过"),
        QuestionItem(_id: "", question: "早", rightAnswer: "晚")]
)
var mistakeExample3 = Mistake(
    _id: "",
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(_id: "", question: "认真", rightAnswer: "马虎"),
        QuestionItem(_id: "", question: "长", rightAnswer: "短"),
        QuestionItem(_id: "", question: "高兴", rightAnswer: "难过"),
        QuestionItem(_id: "", question: "早", rightAnswer: "晚")]
)
var mistakeExample4 = Mistake(
    _id: "",
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(_id: "", question: "认真", rightAnswer: "马虎"),
        QuestionItem(_id: "", question: "长", rightAnswer: "短"),
        QuestionItem(_id: "", question: "高兴", rightAnswer: "难过"),
        QuestionItem(_id: "", question: "早", rightAnswer: "晚")]
)
var revisingMistakeExample1 = RevisingMistake(_id: "", mistake: mistakeExample1)
var revisingMistakeExample2 = RevisingMistake(_id: "", mistake: mistakeExample2)
var revisingMistakeExample3 = RevisingMistake(_id: "", mistake: mistakeExample3)
var revisingMistakeExample4 = RevisingMistake(_id: "", mistake: mistakeExample4)



