//
//  mistakerecorderApp.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/21.
//

import SwiftUI

@main
struct mistakerecorderApp: App {
    @StateObject var mistake = Mistake(subject: "语文", category: "错题类型一", questionDescription: "题干描述一",
                                       questionItems: [
                                           QuestionItem(question: "题目一", rightAnswer: "答案一"),
                                           QuestionItem(question: "题目二", rightAnswer: "答案二"),
                                           QuestionItem(question: "题目三", rightAnswer: "答案三")
                                       ])
    @State var editStatus = false
    var body: some Scene {
        WindowGroup {
//            TabBar().environmentObject(LoginStatus())
            MistakePinYinXieCiEditView(mistake: mistake, editStatus: $editStatus)
        }
    }
}
