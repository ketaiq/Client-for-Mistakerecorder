//
//  mistakerecorderApp.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/21.
//

import SwiftUI

@main
struct mistakerecorderApp: App {
    @StateObject var questionItem = QuestionItem(question: "题目一", rightAnswer: "答案一")
    var body: some Scene {
        WindowGroup {
//            TabBar().environmentObject(LoginStatus())
            MistakeMoXieGuShiEditView(questionItem: questionItem)
        }
    }
}
