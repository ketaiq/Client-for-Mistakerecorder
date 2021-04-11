//
//  ReviseAnswerView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/11.
//

import SwiftUI

struct ReviseAnswerView: View {
    @ObservedObject var mistake: Mistake
    @Binding var showReviseAnswerView: Bool
    
    var body: some View {
        ZStack {
            Color.green
                
            VStack {
                HStack {
                    Text(self.mistake.questionDescription)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    ForEach(self.mistake.questionItems.indices, id: \.self) { index in
                        ReviseAnswerItemSubview(mistake: self.mistake, questionItemIndex: index)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        self.showReviseAnswerView = false
                    }, label: {
                        Text("返回")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .font(.system(size: 20))
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .cornerRadius(5)
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("一键识别")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .font(.system(size: 20))
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                            .cornerRadius(5)
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("完成")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .font(.system(size: 20))
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                            .cornerRadius(5)
                    })
                }
                .padding(10)
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
        }
    }
}

struct ReviseAnswerView_Previews: PreviewProvider {
    @StateObject static var mistakePinYinXieCi = Mistake(subject: "语文", category: MistakeCategory.PinYinXieCi.toString(), questionDescription: MistakeCategory.PinYinXieCi.generateDescription(),
            questionItems: [
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "快乐*", rightAnswer: "乐"),
                QuestionItem(question: "放松*", rightAnswer: "松"),
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
    @State static var showReviseAnswerView = false
    static var previews: some View {
        ReviseAnswerView(mistake: mistakeMoXieGuShi, showReviseAnswerView: $showReviseAnswerView)
    }
}

struct ReviseAnswerItemSubview: View {
    @ObservedObject var mistake: Mistake
    @StateObject private var text = ObservableString(content: "答案一")
    @State private var showOCRView = false
    var questionItemIndex: Int
    
    var question: some View {
        HStack(spacing: 0) {
            if MistakeCategory.isPresetCategory(category: self.mistake.category) {
                if self.mistake.category == MistakeCategory.PinYinXieCi.toString() {
                    Text("\(self.questionItemIndex + 1).\t").font(.system(size: 20))
                    ForEach(PinYinXieCi(questionItem: self.mistake.questionItems[self.questionItemIndex]).items.indices, id: \.self) { index in
                        let item = PinYinXieCi(questionItem: self.mistake.questionItems[self.questionItemIndex]).items[index]
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
                    Text("\(self.questionItemIndex + 1).\t").font(.system(size: 20))
                    Text(Idiom.getExplanation(self.mistake.questionItems[self.questionItemIndex].question)).font(.system(size: 20))
                } else if self.mistake.category == MistakeCategory.JinYiCi.toString() || self.mistake.category == MistakeCategory.FanYiCi.toString() {
                    Text("\(self.questionItemIndex + 1).\t").font(.system(size: 20))
                    Text(JinFanYiCiResult.getWord(self.mistake.questionItems[self.questionItemIndex].question)).font(.system(size: 20))
                } else if self.mistake.category == MistakeCategory.MoXieGuShi.toString() {
                    Text("\(self.questionItemIndex + 1).\t").font(.system(size: 20))
                    Text(Poem.getTitle(self.mistake.questionItems[self.questionItemIndex].question)).font(.system(size: 20))
                } else if self.mistake.category == MistakeCategory.ZuCi.toString() {
                    Text("\(self.questionItemIndex + 1).\t").font(.system(size: 20))
                    Text("\(self.mistake.questionItems[self.questionItemIndex].question)  (     )").font(.system(size: 20))
                } else if self.mistake.category == MistakeCategory.XiuGaiBingJu.toString() {
                    Text("\(self.questionItemIndex + 1).\t").font(.system(size: 20))
                    Text(BingJu.getSentence(self.mistake.questionItems[self.questionItemIndex].question)).font(.system(size: 20))
                }
            } else {
                Text("\(self.questionItemIndex + 1).\t").font(.system(size: 20))
                Text(self.mistake.questionItems[self.questionItemIndex].question).font(.system(size: 20))
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                question
                Spacer()
            }
            .padding(.vertical, 5)
            
            HStack(spacing: 20) {
                Button(action: {
                    self.showOCRView = true
                }, label: {
                    Image(systemName: "camera")
                        .foregroundColor(Color.black)
                        .font(.system(size: 30))
                })
                .sheet(isPresented: self.$showOCRView) {
                    MistakeOCRView(text: self.text, showMistakeOCRView: self.$showOCRView)
                }
                
                Button(action: {
                    self.text.content = ""
                }, label: {
                    Image(systemName: "clear")
                        .foregroundColor(Color.black)
                        .font(.system(size: 30))
                })
                Spacer()
            }
            
            if MistakeCategory.isLongTextCategory(self.mistake.category) {
                TextEditor(text: self.$text.content)
                    .font(.system(size: 18))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(height: 150)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .background(Color.white)
                    .cornerRadius(5)
            } else {
                TextField("请在此输入答案...", text: self.$text.content)
                    .font(.system(size: 18))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .background(Color.white)
                    .cornerRadius(5)
            }
        }
    }
}

//struct ReviseTextFieldSubview_Previews: PreviewProvider {
//    @StateObject static var mistakePinYinXieCi = Mistake(subject: "语文", category: MistakeCategory.PinYinXieCi.toString(), questionDescription: MistakeCategory.PinYinXieCi.generateDescription(),
//            questionItems: [
//                QuestionItem(question: "高兴*", rightAnswer: "兴"),
//                QuestionItem(question: "快乐*", rightAnswer: "乐"),
//                QuestionItem(question: "放松*", rightAnswer: "松"),
//                QuestionItem(question: "高兴*", rightAnswer: "兴"),
//                QuestionItem(question: "快乐*", rightAnswer: "乐"),
//                QuestionItem(question: "放松*", rightAnswer: "松")
//            ])
//    
//    static var previews: some View {
//        ReviseTextFieldSubview(mistake: mistakePinYinXieCi, questionItemIndex: 0)
//    }
//}
