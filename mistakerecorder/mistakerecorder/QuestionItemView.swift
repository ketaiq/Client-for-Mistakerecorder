//
//  QuestionItemView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/7.
//

import SwiftUI

struct QuestionItemView: View {
    @ObservedObject var questionItem: QuestionItem
    @Binding var questionItemSaved: Bool
    @State private var question: String = ""
    @State private var rightAnswer: String = ""
    @State private var questionCommit = false
    @State private var rightAnswerCommit = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text("题目项题目：")
                    TextField("\(self.questionItem.question)", text: $question,
                    onEditingChanged: { isBegin in
                        if isBegin {
                            self.questionCommit = false
                            self.questionItemSaved = false
                        }
                    },
                    onCommit: {
                        self.questionItem.question = self.question
                        self.questionCommit = true
                        self.questionItemSaved = true
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                HStack {
                    Spacer()
                    Image(systemName: self.questionCommit ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundColor(self.questionCommit ? .blue : .gray)
                        .opacity(self.questionCommit ? 1 : 0.5)
                        .font(.system(size: 20))
                }
            }
            ZStack {
                HStack {
                    Text("题目项答案：")
                    TextField("\(self.questionItem.rightAnswer)", text: $rightAnswer,
                    onEditingChanged: { isBegin in
                        if isBegin {
                            self.rightAnswerCommit = false
                            self.questionItemSaved = false
                        }
                    },
                    onCommit: {
                        self.questionItem.rightAnswer = self.rightAnswer
                        self.rightAnswerCommit = true
                        self.questionItemSaved = true
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                HStack {
                    Spacer()
                    Image(systemName: self.rightAnswerCommit ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundColor(self.rightAnswerCommit ? .blue : .gray)
                        .opacity(self.rightAnswerCommit ? 1 : 0.5)
                        .font(.system(size: 20))
                }
            }
        }
    }
}

struct QuestionItemView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!.pngData()!)
    @State static var questionItemSaved = false
    static var previews: some View {
        QuestionItemView(questionItem: user.mistakeList[0].questionItems[0], questionItemSaved: $questionItemSaved)
    }
}
