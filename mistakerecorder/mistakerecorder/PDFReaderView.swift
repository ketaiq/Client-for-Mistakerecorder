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
