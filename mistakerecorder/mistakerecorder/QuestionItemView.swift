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
    
    var body: some View {
        VStack {
            HStack {
                Text("题目项题目：")
                TextField("\(self.questionItem.question)", text: $question,
                onCommit: {
                    self.questionItem.question = self.question
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            }
            HStack {
                Text("题目项答案：")
                TextField("\(self.questionItem.rightAnswer)", text: $rightAnswer,
                onCommit: {
                    self.questionItem.rightAnswer = self.rightAnswer
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            }
        }
    }
}

struct QuestionItemView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionItemView(questionItem: mistakeExample1.questionItems[0])
    }
}
