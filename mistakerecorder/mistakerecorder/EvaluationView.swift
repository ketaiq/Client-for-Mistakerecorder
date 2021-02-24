//
//  EvaluationView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/24.
//

import SwiftUI

struct EvaluationView: View {
    var answers: [String]
    var mistake: Mistake
    @State private var show = false
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text("成绩")
                        .font(.title).bold()
                        .opacity(self.show ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(0.2))
                    LazyVGrid(columns: columns) {
                        Text("你的答案")
                            .opacity(self.show ? 1 : 0)
                            .animation(Animation.linear(duration: 1).delay(0.2))
                        Text("正确答案")
                            .opacity(self.show ? 1 : 0)
                            .animation(Animation.linear(duration: 1).delay(0.2))
                        Text("评价")
                            .opacity(self.show ? 1 : 0)
                            .animation(Animation.linear(duration: 1).delay(0.2))
                    }
                    LazyVGrid(columns: columns) {
                        ForEach(mistake.questionItems.indices, id: \.self) { index in
                            if index >= answers.count {
                                Text("")
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                                Text(mistake.questionItems[index].rightAnswer)
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                                LottieView(filename: "failed", isLoop: false)
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                            } else if index < answers.count && mistake.questionItems[index].rightAnswer != answers[index] {
                                Text(answers[index])
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                                Text(mistake.questionItems[index].rightAnswer)
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                                LottieView(filename: "failed", isLoop: false)
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                            } else {
                                Text(answers[index])
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                                Text(mistake.questionItems[index].rightAnswer)
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                                LottieView(filename: "success", isLoop: false)
                                    .opacity(self.show ? 1 : 0)
                                    .animation(Animation.linear(duration: 1).delay(0.2))
                            }
                        }
                    }
                }
                LottieView(filename: "congratulations", isLoop: false)
                    .frame(width: 300, height: 400)
                    .opacity(self.show ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(0.4))
            }
        }
        .padding(.top, 30)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(self.show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear {
            self.show = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.3 : 0))
        .animation(.linear(duration: 0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EvaluationView_Previews: PreviewProvider {
    static var answers = ["错误答案一", "错误答案二", "答案三"]
    static var mistake = Mistake(subject: "错题学科一", category: "错题类型一", questionDescription: "题干描述一",
        questionItems: [
         QuestionItem(question: "题目一", rightAnswer: "答案一"),
         QuestionItem(question: "题目二", rightAnswer: "答案二"),
         QuestionItem(question: "题目三", rightAnswer: "答案三")
        ])
    static var previews: some View {
        EvaluationView(answers: answers, mistake: mistake)
    }
}
