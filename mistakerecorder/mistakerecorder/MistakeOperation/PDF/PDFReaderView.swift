//
//  PDFReaderView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/6.
//

import SwiftUI
import PDFKit

struct PDFReaderView: UIViewRepresentable {
    var pdfData: Data?
    
    func makeUIView(context: UIViewRepresentableContext<PDFReaderView>) -> UIView {
        let pdfView = PDFView()
        
        if let data = pdfData {
            pdfView.document = PDFDocument(data: data)
            pdfView.autoScales = true
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFReaderView>) {
        
    }
}

struct PDFReaderView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: "")
    @State static var mistakes = [
        Mistake(subject: "语文", category: MistakeCategory.PinYinXieCi.toString(), questionDescription: MistakeCategory.PinYinXieCi.generateDescription(),
            questionItems: [
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "高兴*", rightAnswer: "兴")
            ]),
        Mistake(subject: "语文", category: MistakeCategory.ChengYuYiSi.toString(), questionDescription: MistakeCategory.ChengYuYiSi.generateDescription(),
            questionItems: [
                QuestionItem(question: Idiom(derivation: "出自", example: "例句", explanation: "向四处张望。形容这里那里地到处看。", pinyin: "拼音", word: "成语", abbreviation: "sx").toJsonString(), rightAnswer: "东张西望"),
                QuestionItem(question: Idiom(derivation: "出自", example: "例句", explanation: "向四处张望。形容这里那里地到处看。", pinyin: "拼音", word: "成语", abbreviation: "sx").toJsonString(), rightAnswer: "东张西望"),
                QuestionItem(question: Idiom(derivation: "出自", example: "例句", explanation: "向四处张望。形容这里那里地到处看。", pinyin: "拼音", word: "成语", abbreviation: "sx").toJsonString(), rightAnswer: "东张西望")
            ]),
        Mistake(subject: "语文", category: MistakeCategory.JinYiCi.toString(), questionDescription: MistakeCategory.JinYiCi.generateDescription(),
            questionItems: [
                QuestionItem(question: JinFanYiCiResult(word: "查询词语", pinyin: "拼音", content: "解释", jin: ["近义词1", "近义词2", "近义词3"], fan: ["反义词1", "反义词2", "反义词3"]).toJsonString(), rightAnswer: "答案"),
                QuestionItem(question: JinFanYiCiResult(word: "查询词语", pinyin: "拼音", content: "解释", jin: ["近义词1", "近义词2", "近义词3"], fan: ["反义词1", "反义词2", "反义词3"]).toJsonString(), rightAnswer: "答案"),
                QuestionItem(question: JinFanYiCiResult(word: "查询词语", pinyin: "拼音", content: "解释", jin: ["近义词1", "近义词2", "近义词3"], fan: ["反义词1", "反义词2", "反义词3"]).toJsonString(), rightAnswer: "答案"),
                QuestionItem(question: JinFanYiCiResult(word: "查询词语", pinyin: "拼音", content: "解释", jin: ["近义词1", "近义词2", "近义词3"], fan: ["反义词1", "反义词2", "反义词3"]).toJsonString(), rightAnswer: "答案"),
                QuestionItem(question: JinFanYiCiResult(word: "查询词语", pinyin: "拼音", content: "解释", jin: ["近义词1", "近义词2", "近义词3"], fan: ["反义词1", "反义词2", "反义词3"]).toJsonString(), rightAnswer: "答案"),
                QuestionItem(question: JinFanYiCiResult(word: "查询词语", pinyin: "拼音", content: "解释", jin: ["近义词1", "近义词2", "近义词3"], fan: ["反义词1", "反义词2", "反义词3"]).toJsonString(), rightAnswer: "答案")
            ]),
        Mistake(subject: "语文", category: MistakeCategory.MoXieGuShi.toString(), questionDescription: MistakeCategory.MoXieGuShi.generateDescription(),
            questionItems: [
                QuestionItem(question: Poem(detailid: 0, title: "行宫", type: "五言绝句", content: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。", explanation: "⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。", appreciation: "元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。", author: "元稹").toJsonString(), rightAnswer: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。"),
                QuestionItem(question: Poem(detailid: 0, title: "行宫", type: "五言绝句", content: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。", explanation: "⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。", appreciation: "元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。", author: "元稹").toJsonString(), rightAnswer: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。"),
                QuestionItem(question: Poem(detailid: 0, title: "行宫", type: "五言绝句", content: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。", explanation: "⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。", appreciation: "元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。", author: "元稹").toJsonString(), rightAnswer: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。")
            ]),
        Mistake(subject: "语文", category: MistakeCategory.ZuCi.toString(), questionDescription: MistakeCategory.ZuCi.generateDescription(),
            questionItems: [
                QuestionItem(question: "传", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染"),
                QuestionItem(question: "传", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染"),
                QuestionItem(question: "传", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染")
            ]),
        Mistake(subject: "语文", category: MistakeCategory.XiuGaiBingJu.toString(), questionDescription: MistakeCategory.XiuGaiBingJu.generateDescription(),
            questionItems: [
                QuestionItem(question: BingJu(sentence: "为了班集体，做了很多好事。", type: ["成分残缺", "用词不当"]).toJsonString(), rightAnswer: "为了班集体，小明做了很多好事。"),
                QuestionItem(question: BingJu(sentence: "为了班集体，做了很多好事。", type: ["成分残缺", "用词不当"]).toJsonString(), rightAnswer: "为了班集体，小明做了很多好事。"),
                QuestionItem(question: BingJu(sentence: "为了班集体，做了很多好事。", type: ["成分残缺", "用词不当"]).toJsonString(), rightAnswer: "为了班集体，小明做了很多好事。")
            ]),
        Mistake(subject: "错题学科一", category: "错题类型一", questionDescription: "题干描述一",
            questionItems: [
              QuestionItem(question: "题目一", rightAnswer: "答案一"),
              QuestionItem(question: "题目二", rightAnswer: "答案二"),
              QuestionItem(question: "题目三", rightAnswer: "答案三")
            ]),
        Mistake(subject: "错题学科二", category: "错题类型二", questionDescription: "题干描述二",
            questionItems: [
              QuestionItem(question: "题目一", rightAnswer: "答案一"),
              QuestionItem(question: "题目二", rightAnswer: "答案二"),
              QuestionItem(question: "题目三", rightAnswer: "答案三")
            ]),
        Mistake(subject: "错题学科三", category: "错题类型三", questionDescription: "题干描述三",
            questionItems: [
              QuestionItem(question: "题目一", rightAnswer: "答案一"),
              QuestionItem(question: "题目二", rightAnswer: "答案二"),
              QuestionItem(question: "题目三", rightAnswer: "答案三")
            ]),
        Mistake(subject: "错题学科一", category: "错题类型一", questionDescription: "题干描述一",
            questionItems: [
              QuestionItem(question: "题目一", rightAnswer: "答案一"),
              QuestionItem(question: "题目二", rightAnswer: "答案二"),
              QuestionItem(question: "题目三", rightAnswer: "答案三")
            ]),
        Mistake(subject: "错题学科二", category: "错题类型二", questionDescription: "题干描述二",
            questionItems: [
              QuestionItem(question: "题目一", rightAnswer: "答案一"),
              QuestionItem(question: "题目二", rightAnswer: "答案二"),
              QuestionItem(question: "题目三", rightAnswer: "答案三")
            ]),
        Mistake(subject: "错题学科三", category: "错题类型三", questionDescription: "题干描述三",
            questionItems: [
              QuestionItem(question: "题目一", rightAnswer: "答案一"),
              QuestionItem(question: "题目二", rightAnswer: "答案二"),
              QuestionItem(question: "题目三", rightAnswer: "答案三")
            ])
    ]
    static var previews: some View {
        PDFReaderView(pdfData: PDFCreator(user: user, mistakes: mistakes).createPDF())
    }
}
