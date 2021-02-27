//
//  RevisingMistakeCardView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/26.
//

import SwiftUI

struct RevisingMistakeCardView: View {
    @ObservedObject var mistake: Mistake
    @Binding var fullScreenActive: Bool
    var index: Int
    @Binding var activeIndex: Int
    @State private var answerText: String = "请在这里按题目顺序填写答案，用空格隔开"
    @State private var showEvaluationResult = false
    
    func evaluateAnswers() { // 评价复习结果并记录
        var rightAnswerNum: Double = 0
        var wrongAnswerNum: Double = 0
        var i = 0
        let answers = self.answerText.components(separatedBy: " ")
        for answer in answers {
            if i >= mistake.questionItems.count {
                break
            }
            if mistake.questionItems[i].rightAnswer == answer { // 答对
                rightAnswerNum = rightAnswerNum + 1
            } else { // 答错
                wrongAnswerNum = wrongAnswerNum + 1
            }
            i = i + 1
        }
        if i < mistake.questionItems.count { // 答案不全
            wrongAnswerNum = wrongAnswerNum + 1
            i = i + 1
        }
        // 记录复习结果
        let accurateRatio = rightAnswerNum / (rightAnswerNum + wrongAnswerNum)
        if accurateRatio >= 0.8 {
            mistake.revisedRecords.append(RevisedRecord(revisedDate: DateFunctions.functions.currentDate(), revisedPerformance: "掌握"))
        } else if accurateRatio >= 0.4 && accurateRatio < 0.8 {
            mistake.revisedRecords.append(RevisedRecord(revisedDate: DateFunctions.functions.currentDate(), revisedPerformance: "模糊"))
        } else {
            mistake.revisedRecords.append(RevisedRecord(revisedDate: DateFunctions.functions.currentDate(), revisedPerformance: "忘记"))
        }
    }
    
    func planNextRevisionDate() { // 计算下一次复习时间
        let revisedCount = mistake.revisedRecords.count
        let lastRevisedPerformance = mistake.revisedRecords[revisedCount - 1].revisedPerformance
        let lastRevisedDate = mistake.revisedRecords[revisedCount - 1].revisedDate
        if revisedCount == 1 { // 第一次复习
            mistake.nextRevisionDate = DateFunctions.functions.addDate(startDate: lastRevisedDate, addition: 1) // 无论第一次复习结果如何，都是第二天继续需要复习
        } else { // 复习次数 >= 2
            let secondToLastRevisedDate = mistake.revisedRecords[revisedCount - 2].revisedDate // 倒数第二次的复习日期
            let intervalDays = DateFunctions.functions.subtractDate(startDate: secondToLastRevisedDate, endDate: lastRevisedDate) // 最后两次复习之间的间隔天数
            if lastRevisedPerformance == "掌握" {
                mistake.nextRevisionDate = DateFunctions.functions.addDate(startDate: lastRevisedDate, addition: Int((Double(intervalDays) * 1.5).rounded()))
            } else if lastRevisedPerformance == "模糊" {
                mistake.nextRevisionDate = DateFunctions.functions.addDate(startDate: lastRevisedDate, addition: intervalDays)
            } else { // 忘记
                mistake.nextRevisionDate = DateFunctions.functions.addDate(startDate: lastRevisedDate, addition: 1)
            }
        }
    }
    
    func showRightAnswers() { // 显示正确答案
        self.answerText.append("\n正确答案：")
        for item in mistake.questionItems {
            self.answerText.append("\(item.rightAnswer) ")
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                TextEditor(text: self.$answerText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical)
                HStack {
                    Button(action: {
                        self.answerText = ""
                    }, label: {
                        Text("清空")
                            .font(.headline)
                            .font(.system(size: 16))
                    })
                    .frame(width: 100, height: 50)
                    .background(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    
                    Button(action: {
                        self.evaluateAnswers()
                        self.showEvaluationResult = true
                        self.planNextRevisionDate()
                    }, label: {
                        Text("确认")
                            .font(.headline)
                            .font(.system(size: 16))
                    })
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                Rectangle().foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: mistake.isRevising ? .infinity : 200,
                   maxHeight: mistake.isRevising ? .infinity : 200)
            .offset(y: mistake.isRevising ? 300: 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 20)
            .opacity(mistake.isRevising ? 1 : 0)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(mistake.subject)
                        .font(.title)
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .opacity(mistake.isRevising ? 1 : 0)
                }
                .padding(.top)
                Text(mistake.questionDescription)
                    .font(.headline)
                VStack(spacing: 10) {
                    ForEach(mistake.questionItems) { item in
                        HStack {
                            Text(item.question)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .frame(
                width: mistake.isRevising ? .infinity : 320,
                height: mistake.isRevising ? 300 : 250)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color.green.opacity(0.8), radius: 20, x: 0, y: 20)
            .onTapGesture {
                mistake.isRevising.toggle()
                fullScreenActive.toggle()
                if mistake.isRevising {
                    activeIndex = index
                } else {
                    activeIndex = -1
                }
            }
            
            if self.showEvaluationResult {
                EvaluationView(answers: self.answerText.components(separatedBy: " "), mistake: mistake, showEvaluationResult: self.$showEvaluationResult)
            }
        }
        .frame(height: mistake.isRevising ? screen.height - 70 : 250)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct RevisingMistakeCardView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")
    @State static var fullScreenActive = false
    static var index = 1
    @State static var activeIndex = 1
    
    static var previews: some View {
        RevisingMistakeCardView(mistake: user.mistakeList[0],
            fullScreenActive: $fullScreenActive, index: index, activeIndex: $activeIndex)
    }
}
