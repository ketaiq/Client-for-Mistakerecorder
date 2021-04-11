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
    
    @State private var showEvaluationResult = false

    var body: some View {
        ZStack(alignment: .top) {
            RevisingCardEditSubview(mistake: self.mistake, showEvaluationResult: self.$showEvaluationResult)
            
            RevisingCardFoldSubview(mistake: self.mistake, fullScreenActive: self.$fullScreenActive, index: self.index, activeIndex: self.$activeIndex)
        }
        .frame(height: mistake.isRevising() ? screen.height - 70 : 250)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct RevisingMistakeCardView_Previews: PreviewProvider {
    @StateObject static var mistakePinYinXieCi = Mistake(subject: "语文", category: MistakeCategory.PinYinXieCi.toString(), questionDescription: MistakeCategory.PinYinXieCi.generateDescription(),
            questionItems: [
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "快乐*", rightAnswer: "乐"),
                QuestionItem(question: "放松*", rightAnswer: "松")
            ])
    @StateObject static var mistakeChengYuYiSi = Mistake(subject: "语文", category: MistakeCategory.ChengYuYiSi.toString(), questionDescription: MistakeCategory.ChengYuYiSi.generateDescription(),
            questionItems: [
                QuestionItem(question: Idiom(derivation: "出自1", example: "例句1", explanation: "解释1", pinyin: "拼音1", word: "成语1", abbreviation: "sx1").toJsonString(), rightAnswer: "成语1"),
                QuestionItem(question: Idiom(derivation: "出自2", example: "例句2", explanation: "解释2", pinyin: "拼音2", word: "成语2", abbreviation: "sx2").toJsonString(), rightAnswer: "成语2"),
                QuestionItem(question: Idiom(derivation: "出自3", example: "例句3", explanation: "解释3", pinyin: "拼音3", word: "成语3", abbreviation: "sx3").toJsonString(), rightAnswer: "成语3")
            ])
    @StateObject static var mistakeJinYiCi = Mistake(subject: "语文", category: MistakeCategory.JinYiCi.toString(), questionDescription: MistakeCategory.JinYiCi.generateDescription(),
            questionItems: [
                QuestionItem(question: JinFanYiCiResult(word: "查询词语1", pinyin: "拼音1", content: "解释1", jin: ["近义词11", "近义词12", "近义词13"], fan: ["反义词11", "反义词12", "反义词13"]).toJsonString(), rightAnswer: "答案1"),
                QuestionItem(question: JinFanYiCiResult(word: "查询词语2", pinyin: "拼音2", content: "解释2", jin: ["近义词21", "近义词22", "近义词23"], fan: ["反义词21", "反义词22", "反义词23"]).toJsonString(), rightAnswer: "答案2"),
                QuestionItem(question: JinFanYiCiResult(word: "查询词语3", pinyin: "拼音3", content: "解释3", jin: ["近义词31", "近义词32", "近义词33"], fan: ["反义词31", "反义词32", "反义词33"]).toJsonString(), rightAnswer: "答案3")
            ])
    @StateObject static var mistakeMoXieGuShi = Mistake(subject: "语文", category: MistakeCategory.MoXieGuShi.toString(), questionDescription: MistakeCategory.MoXieGuShi.generateDescription(),
            questionItems: [
                QuestionItem(question: Poem(detailid: 0, title: "行宫1", type: "五言绝句1", content: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。1", explanation: "⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。1", appreciation: "元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。1", author: "元稹1").toJsonString(), rightAnswer: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。1"),
                QuestionItem(question: Poem(detailid: 1, title: "行宫2", type: "五言绝句2", content: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。2", explanation: "⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。2", appreciation: "元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。2", author: "元稹2").toJsonString(), rightAnswer: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。2"),
                QuestionItem(question: Poem(detailid: 2, title: "行宫3", type: "五言绝句3", content: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。3", explanation: "⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。3", appreciation: "元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。3", author: "元稹3").toJsonString(), rightAnswer: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。3")
            ])
    @StateObject static var mistakeZuCi = Mistake(subject: "语文", category: MistakeCategory.ZuCi.toString(), questionDescription: MistakeCategory.ZuCi.generateDescription(),
            questionItems: [
                QuestionItem(question: "传1", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染"),
                QuestionItem(question: "传2", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染"),
                QuestionItem(question: "传3", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染")
            ])
    @StateObject static var mistakeXiuGaiBingJu = Mistake(subject: "语文", category: MistakeCategory.XiuGaiBingJu.toString(), questionDescription: MistakeCategory.XiuGaiBingJu.generateDescription(),
            questionItems: [
                QuestionItem(question: BingJu(sentence: "为了班集体，做了很多好事。1", type: ["成分残缺", "用词不当"]).toJsonString(), rightAnswer: "为了班集体，小明做了很多好事。"),
                QuestionItem(question: BingJu(sentence: "为了班集体，做了很多好事。2", type: ["成分残缺", "用词不当"]).toJsonString(), rightAnswer: "为了班集体，小明做了很多好事。"),
                QuestionItem(question: BingJu(sentence: "为了班集体，做了很多好事。3", type: ["成分残缺", "用词不当"]).toJsonString(), rightAnswer: "为了班集体，小明做了很多好事。")
            ])
    @State static var fullScreenActive = false
    static var index = 1
    @State static var activeIndex = 1
    
    static var previews: some View {
        RevisingMistakeCardView(mistake: mistakeXiuGaiBingJu, fullScreenActive: $fullScreenActive, index: index, activeIndex: $activeIndex)
    }
}

struct RevisingCardEditSubview: View {
    @ObservedObject var mistake: Mistake
    @Binding var showEvaluationResult: Bool
    @State private var answerText: String = "请在这里按题目顺序填写答案，用空格隔开"
    
    private func evaluateAnswers() {
        // 评价复习结果并记录
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
    
    private func planNextRevisionDate() {
        // 计算下一次复习时间
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
    
    var body: some View {
        ZStack {
            VStack {
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
            .frame(maxWidth: mistake.isRevising() ? .infinity : 200,
                   maxHeight: mistake.isRevising() ? .infinity : 200)
            .offset(y: mistake.isRevising() ? 300: 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 20)
            .opacity(mistake.isRevising() ? 1 : 0)
        }
        
        if self.showEvaluationResult {
            EvaluationView(answers: self.answerText.components(separatedBy: " "), mistake: mistake, showEvaluationResult: self.$showEvaluationResult)
        }
    }
}

struct RevisingCardFoldSubview: View {
    @ObservedObject var mistake: Mistake
    @Binding var fullScreenActive: Bool
    var index: Int
    @Binding var activeIndex: Int
    
    var questions: some View {
        ScrollView(showsIndicators: false) {
            ForEach(self.mistake.questionItems.indices, id: \.self) { questionItemIndex in
                let questionItem = self.mistake.questionItems[questionItemIndex]
                
                if MistakeCategory.isPresetCategory(category: self.mistake.category) {
                    if self.mistake.category == MistakeCategory.PinYinXieCi.toString() {
                        HStack(spacing: 0) {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            ForEach(PinYinXieCi(questionItem: questionItem).items.indices, id: \.self) { index in
                                let item = PinYinXieCi(questionItem: questionItem).items[index]
                                if item.selected {
                                    VStack {
                                        Text(item.pin_yin)
                                        Text("(     )").font(.system(size: 20))
                                    }
                                } else {
                                    VStack {
                                        Text(item.pin_yin).hidden()
                                        Text(item.word).font(.system(size: 20))
                                    }
                                }
                            }
                        }
                    } else if self.mistake.category == MistakeCategory.ChengYuYiSi.toString() {
                        HStack(spacing: 0) {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(Idiom.getExplanation(questionItem.question)).font(.system(size: 20))
                        }
                    } else if self.mistake.category == MistakeCategory.JinYiCi.toString() || self.mistake.category == MistakeCategory.FanYiCi.toString() {
                        HStack(spacing: 0) {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(JinFanYiCiResult.getWord(questionItem.question)).font(.system(size: 20))
                        }
                    } else if self.mistake.category == MistakeCategory.MoXieGuShi.toString() {
                        HStack(spacing: 0) {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(Poem.getTitle(questionItem.question)).font(.system(size: 20))
                        }
                    } else if self.mistake.category == MistakeCategory.ZuCi.toString() {
                        HStack(spacing: 0) {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text("\(questionItem.question)  (     )").font(.system(size: 20))
                        }
                    } else if self.mistake.category == MistakeCategory.XiuGaiBingJu.toString() {
                        HStack(spacing: 0) {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(BingJu.getSentence(questionItem.question)).font(.system(size: 20))
                        }
                    }
                } else {
                    HStack(spacing: 0) {
                        Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                        Text(questionItem.question).font(.system(size: 20))
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(mistake.subject)
                    .font(.title)
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .opacity(mistake.isRevising() ? 1 : 0)
                    .onTapGesture {
                        self.mistake.revisionStatus = "false"
                        fullScreenActive = false
                        activeIndex = -1
                    }
            }
            .padding(.top)
            
            Text(mistake.questionDescription)
                .font(.system(size: 20, weight: .bold))
            
            questions
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: mistake.isRevising() ? 300 : 250)
        .frame(maxWidth: mistake.isRevising() ? .infinity : 320)
        .background(Color.green)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .shadow(color: Color.green.opacity(0.8), radius: 20, x: 0, y: 20)
        .onTapGesture {
            self.mistake.revisionStatus = "true"
            fullScreenActive = true
            activeIndex = index
            hideKeyboard()
        }
    }
}
