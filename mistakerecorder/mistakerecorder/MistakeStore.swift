//
//  MistakeStore.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/29.
//

import Foundation

class MistakeStore: ObservableObject { // 错题列表
    @Published var mistakeList: [Mistake] = mistakeListExample
}

class Mistake: ObservableObject, Identifiable { // 错题
    var id = UUID() // 自动生成的ID
    @Published var subject: String // 错题所属学科：语文、数学、英语等
    @Published var category: String // 错题类型：近义词、反义词等
    @Published var questionDescription: String // 题干描述："写出下列词语的反义词。"
    @Published var questionItems: [QuestionItem] // 题目项数组
    
    init(subject: String, category: String, questionDescription: String, questionItems: [QuestionItem]) {
        self.subject = subject
        self.category = category
        self.questionDescription = questionDescription
        self.questionItems = questionItems
    }
}

class QuestionItem: ObservableObject, Identifiable { // 题目项
    var id = UUID() // 自动生成的ID
    @Published var question: String // 题目
    @Published var rightAnswer: String // 正确答案
    
    init(question: String, rightAnswer: String) {
        self.question = question
        self.rightAnswer = rightAnswer
    }
}

var mistakeListExample = [mistakeExample1, mistakeExample2, mistakeExample3, mistakeExample4]
var mistakeExample1 = Mistake(
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(question: "认真", rightAnswer: "马虎"),
        QuestionItem(question: "长", rightAnswer: "短"),
        QuestionItem(question: "高兴", rightAnswer: "难过"),
        QuestionItem(question: "早", rightAnswer: "晚")]
)
var mistakeExample2 = Mistake(
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(question: "认真", rightAnswer: "马虎"),
        QuestionItem(question: "长", rightAnswer: "短"),
        QuestionItem(question: "高兴", rightAnswer: "难过"),
        QuestionItem(question: "早", rightAnswer: "晚")]
)
var mistakeExample3 = Mistake(
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(question: "认真", rightAnswer: "马虎"),
        QuestionItem(question: "长", rightAnswer: "短"),
        QuestionItem(question: "高兴", rightAnswer: "难过"),
        QuestionItem(question: "早", rightAnswer: "晚")]
)
var mistakeExample4 = Mistake(
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(question: "认真", rightAnswer: "马虎"),
        QuestionItem(question: "长", rightAnswer: "短"),
        QuestionItem(question: "高兴", rightAnswer: "难过"),
        QuestionItem(question: "早", rightAnswer: "晚")]
)
