//
//  EvaluationView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/24.
//

import SwiftUI

struct EvaluationView: View {
    @ObservedObject var mistake: Mistake
    @Binding var showEvaluationView: Bool
    @Binding var rightAnswerNum: Double
    @Binding var wrongAnswerNum: Double
    
    @State private var show = false
    
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
            VStack {
                HStack {
                    Text("复习情况：")
                        .font(.system(size: 30, weight: .bold))
                        .bold()
                    Text("\(mistake.revisedRecords[mistake.revisedRecords.count - 1].revisedPerformance)")
                        .font(.system(size: 30, weight: .bold))
                        .bold()
                        .foregroundColor(self.revisedRecordColor())
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .font(.system(size: 30, weight: .bold))
                        .onTapGesture {
                            self.showEvaluationView = false
                        }
                }
                .padding(.top, 20)
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 30))
                        Text("正确个数：\(Int(self.rightAnswerNum))")
                            .font(.system(size: 24))
                    }
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 30))
                        Text("错误个数：\(Int(self.wrongAnswerNum))")
                            .font(.system(size: 24))
                    }
                    HStack {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 30))
                        Text("准确率：\(String(format: "%.3f", self.rightAnswerNum / (self.rightAnswerNum + self.wrongAnswerNum)))")
                            .font(.system(size: 24))
                    }
                }
                .padding(.vertical)
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: 350, height: 300)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .opacity(self.show ? 1 : 0)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
            .scaleEffect(self.show ? 1 : 0.5)
            .onAppear {
                self.show = true
            }
            .animation(.easeInOut)
            
            LottieView(filename: "congratulations", isLoop: false)
                .frame(width: 300, height: 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(self.show ? 0.3 : 0))
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
    @State static var showEvaluationView = true
    @State static var rightAnswerNum: Double = 5
    @State static var wrongAnswerNum: Double = 3
    
    static var previews: some View {
        EvaluationView(mistake: mistake, showEvaluationView: $showEvaluationView, rightAnswerNum: $rightAnswerNum, wrongAnswerNum: $wrongAnswerNum)
    }
}
