//
//  mistakerecorderApp.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/21.
//

import SwiftUI

@main
struct mistakerecorderApp: App {
    var mistake = Mistake(subject: "错题学科一", category: "错题类型一", questionDescription: "题干描述一",
        questionItems: [
          QuestionItem(question: "题目一", rightAnswer: "答案一"),
          QuestionItem(question: "题目二", rightAnswer: "答案二"),
          QuestionItem(question: "题目三", rightAnswer: "答案三")
        ])
    var body: some Scene {
        WindowGroup {
//            ContentView()
            RevisedRecordsCalendarView(mistake: mistake, dateArray: DateArray(dates: DateFunctions.functions.generateDatesOfMonth(givenDate: mistake.createdDate)))
        }
    }
}
