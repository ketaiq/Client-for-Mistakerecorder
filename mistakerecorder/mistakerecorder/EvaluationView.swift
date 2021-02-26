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
    @Binding var showEvaluationResult: Bool
    @State private var show = false
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    func revisedRecordColor() -> Color {
        let performance = mistake.revisedRecords[mistake.revisedRecords.count - 1].revisedPerformance
        if performance == "掌握" {
            return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        } else if performance == "模糊" {
            return Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        } else if performance == "忘记" {
            return Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        } else {
            return Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        }
    }
    
    var body: some View {
        ZStack {
            LottieView(filename: "congratulations", isLoop: false)
                .frame(width: 300, height: 400)
            VStack {
                HStack {
                    Text("复习情况：")
                        .font(.title)
                        .bold()
                    Text("\(mistake.revisedRecords[mistake.revisedRecords.count - 1].revisedPerformance)")
                        .font(.title)
                        .bold()
                        .foregroundColor(revisedRecordColor())
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .font(.title)
                        .onTapGesture {
                            self.showEvaluationResult = false
                        }
                }
                .padding(.horizontal)
                .padding(.top)
                LazyVGrid(columns: columns) {
                    Text("你的答案").bold()
                    Text("正确答案").bold()
                    Text("评价").bold()
                }
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(mistake.questionItems.indices, id: \.self) { index in
                            if index >= answers.count {
                                Text("")
                                Text(mistake.questionItems[index].rightAnswer)
                                LottieView(filename: "failed", isLoop: false)
                            } else if index < answers.count && mistake.questionItems[index].rightAnswer != answers[index] {
                                Text(answers[index])
                                Text(mistake.questionItems[index].rightAnswer)
                                LottieView(filename: "failed", isLoop: false)
                            } else {
                                Text(answers[index])
                                Text(mistake.questionItems[index].rightAnswer)
                                LottieView(filename: "success", isLoop: false)
                            }
                        }
                    }
                }
            }
        }
        .frame(width: 300, height: 500)
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
    static var answers = ["错误答案", "错误答案", "答案三", "错误答案", "错误答案", "答案三", "错误答案", "错误答案", "答案三", "错误答案", "错误答案", "答案三", "错误答案", "错误答案", "答案三", "错误答案", "错误答案"]
    static var mistake = Mistake(subject: "错题学科一", category: "错题类型一", questionDescription: "题干描述一",
        questionItems: [
            QuestionItem(question: "题目一", rightAnswer: "答案一"),
            QuestionItem(question: "题目二", rightAnswer: "答案二"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三"),
            QuestionItem(question: "题目三", rightAnswer: "答案三")
        ])
    @State static var showEvaluationResult = false
    static var previews: some View {
        EvaluationView(answers: answers, mistake: mistake, showEvaluationResult: $showEvaluationResult)
    }
}
