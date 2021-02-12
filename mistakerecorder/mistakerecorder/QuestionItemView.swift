//
//  QuestionItemView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/7.
//

import SwiftUI

struct QuestionItemView: View {
    @ObservedObject var questionItem: QuestionItem
    @State var question: String = ""
    @State var rightAnswer: String = ""
    @State var questionCommit = false
    @State var rightAnswerCommit = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text("题目项题目：")
                    TextField("\(self.questionItem.question)", text: $question,
                    onEditingChanged: { isBegin in
                        if isBegin {
                            self.questionCommit = false
                        }
                    },
                    onCommit: {
                        self.questionItem.question = self.question
                        self.questionCommit = true
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
                        }
                    },
                    onCommit: {
                        self.questionItem.rightAnswer = self.rightAnswer
                        self.rightAnswerCommit = true
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
    static var previews: some View {
        QuestionItemView(questionItem: mistakeExample1.questionItems[0])
    }
}
