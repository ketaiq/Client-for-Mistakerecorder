//
//  ReviseCardView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/11.
//

import SwiftUI

struct ReviseCardView: View {
    @ObservedObject var mistake: Mistake
    
    var questions: some View {
        ScrollView(showsIndicators: false) {
            ForEach(self.mistake.questionItems.indices, id: \.self) { questionItemIndex in
                let questionItem = self.mistake.questionItems[questionItemIndex]
                
                HStack(spacing: 0) {
                    if MistakeCategory.isPresetCategory(category: self.mistake.category) {
                        if self.mistake.category == MistakeCategory.PinYinXieCi.toString() {
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
                        } else if self.mistake.category == MistakeCategory.ChengYuYiSi.toString() {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(Idiom.getExplanation(questionItem.question)).font(.system(size: 20))
                        } else if self.mistake.category == MistakeCategory.JinYiCi.toString() || self.mistake.category == MistakeCategory.FanYiCi.toString() {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(JinFanYiCiResult.getWord(questionItem.question)).font(.system(size: 20))
                        } else if self.mistake.category == MistakeCategory.MoXieGuShi.toString() {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(Poem.getTitle(questionItem.question)).font(.system(size: 20))
                        } else if self.mistake.category == MistakeCategory.ZuCi.toString() {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text("\(questionItem.question)  (     )").font(.system(size: 20))
                        } else if self.mistake.category == MistakeCategory.XiuGaiBingJu.toString() {
                            Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                            Text(BingJu.getSentence(questionItem.question)).font(.system(size: 20))
                        }
                    } else {
                        Text("\(questionItemIndex + 1).\t").font(.system(size: 20))
                        Text(questionItem.question).font(.system(size: 20))
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(mistake.subject)
                        .font(.title)
                    Spacer()
                }
                .padding(.top)
                
                Text(mistake.questionDescription)
                    .font(.system(size: 20, weight: .bold))
                
                questions
                
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: 320, height: 250)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color.green.opacity(0.8), radius: 20, x: 0, y: 20)
        }
    }
}

struct ReviseCardView_Previews: PreviewProvider {
    @StateObject static var mistakePinYinXieCi = Mistake(subject: "语文", category: MistakeCategory.PinYinXieCi.toString(), questionDescription: MistakeCategory.PinYinXieCi.generateDescription(),
            questionItems: [
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "快乐*", rightAnswer: "乐"),
                QuestionItem(question: "放松*", rightAnswer: "松")
            ])
    
    static var previews: some View {
        ReviseCardView(mistake: mistakePinYinXieCi)
    }
}
