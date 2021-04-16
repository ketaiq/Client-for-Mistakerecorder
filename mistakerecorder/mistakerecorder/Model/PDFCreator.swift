//
//  PDFCreator.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/6.
//

import Foundation
import UIKit
import PDFKit

class PDFCreator {
    let user: User
    let mistakes: [Mistake]
    let pageRect = CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: 11 * 72.0)
    
    init(user: User, mistakes: [Mistake]) {
        self.user = user
        self.mistakes = mistakes
    }
    
    func createPDF() -> Data {
        let metadataKeys = [
            kCGPDFContextAuthor: self.user.nickname,
            kCGPDFContextCreator: "mistakerecorder",
            kCGPDFContextTitle: "错题复习卷"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = metadataKeys as [String: Any]
        
        let render = UIGraphicsPDFRenderer(bounds: self.pageRect, format: format)
        
        let data = render.pdfData { context in
            context.beginPage()
            let titleBottom = self.addTitle()
            let subtitleBottom = self.addSubtitle(textTop: titleBottom)
            self.addBodyText(textTop: subtitleBottom + 24.0, context: context)
        }
        
        return data
    }
    
    private func addTitle() -> CGFloat {// 标题
        let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: "错题复习卷", attributes: titleAttributes)
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: (pageRect.width - titleStringSize.width) / 2.0,
            y: 36,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    private func addSubtitle(textTop: CGFloat) -> CGFloat { // 副标题信息
        let subtitleFont = UIFont.systemFont(ofSize: 13.0)
        let subtitleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: subtitleFont]
        
        let currentDate = DateFunctions.functions.currentDate()
        let currentDay = DateFunctions.functions.getDayFromDate(givenDate: currentDate)
        let currentMonth = DateFunctions.functions.getMonthFromDate(givenDate: currentDate)
        let currentYear = DateFunctions.functions.getYearFromDate(givenDate: currentDate)
        let currentDateString = "\(currentYear.description)年\(currentMonth)月\(currentDay)日"
        
        let attributedSubtitle = NSAttributedString(string: "姓名：\(user.realname)\t日期：\(currentDateString)", attributes: subtitleAttributes)
        let subtitleStringSize = attributedSubtitle.size()
        let subtitleStringRect = CGRect(
            x: (pageRect.width - subtitleStringSize.width) / 2.0,
            y: textTop,
            width: subtitleStringSize.width,
            height: subtitleStringSize.height
        )
        attributedSubtitle.draw(in: subtitleStringRect)
        return subtitleStringRect.origin.y + subtitleStringRect.size.height
    }
    
    private func questionPinYinXieCi(questionItem: QuestionItem, j: Int) -> String {
        var question = ""
        for item in PinYinXieCi(questionItem: questionItem).items {
            if item.selected {
                question.append("\(item.pin_yin)")
            } else {
                question.append("\(item.word)")
            }
        }
        question.append("：")
        for _ in 1 ... questionItem.rightAnswer.count { // 下划线填写答案
            question.append("____")
        }
        question.append("\t")
        if (j + 1) % 4 == 0 { // 一行最多四个
            question.append("\n")
        }
        return question
    }
    
    private func questionChengYuYiSi(questionItem: QuestionItem, j: Int, questionItemCount: Int) -> String {
        var question = ""
        question.append("\(Idiom.getExplanation(questionItem.question))")
        for _ in 1 ... questionItem.rightAnswer.count { // 下划线填写答案
            question.append("____")
        }
        if j < questionItemCount - 1 {
            question.append("\n")
        }
        return question
    }
    
    private func questionJinFanYiCi(questionItem: QuestionItem, j: Int) -> String {
        var question = ""
        question.append("\(JinFanYiCiResult.getWord(questionItem.question))：")
        question.append("________")
        question.append("\t")
        if (j + 1) % 4 == 0 { // 一行最多四个
            question.append("\n")
        }
        return question
    }
    
    private func questionMoXieGuShi(questionItem: QuestionItem, j: Int, questionItemCount: Int) -> String {
        var question = ""
        question.append("\(Poem.getTitle(questionItem.question))：")
        for _ in 1 ... questionItem.rightAnswer.count { // 下划线填写答案
            question.append("____")
        }
        if j < questionItemCount - 1 {
            question.append("\n")
        }
        return question
    }
    
    private func questionZuCi(questionItem: QuestionItem, j: Int) -> String {
        var question = ""
        question.append("\(questionItem.question)：")
        question.append("________")
        question.append("\t")
        if (j + 1) % 4 == 0 { // 一行最多四个
            question.append("\n")
        }
        return question
    }
    
    private func questionXiuGaiBingJu(questionItem: QuestionItem, j: Int, questionItemCount: Int) -> String {
        var question = ""
        question.append("\(BingJu.getSentence(questionItem.question))：")
        for _ in 1 ... questionItem.rightAnswer.count { // 下划线填写答案
            question.append("____")
        }
        if j < questionItemCount - 1 {
            question.append("\n")
        }
        return question
    }
    
    private func questionStandard(questionItem: QuestionItem) -> String {
        var question = ""
        question.append("\(questionItem.question)：")
        for _ in 1 ... questionItem.rightAnswer.count { // 下划线填写答案
            question.append("____")
        }
        question.append("\t")
        return question
    }
    
    private func extractQuestions() -> String { // 提取错题中的题目
        var questions = ""
        
        for i in 0 ..< self.mistakes.count {
            let mistake = self.mistakes[i]
            questions.append("第\(i + 1)题 \(mistake.questionDescription)\n")
            
            for j in 0 ..< mistake.questionItems.count {
                questions.append("(\(j + 1)) ")
                let questionItem = mistake.questionItems[j]
                
                if MistakeCategory.isPresetCategory(category: mistake.category) {
                    if mistake.category == MistakeCategory.PinYinXieCi.toString() {
                        questions.append(self.questionPinYinXieCi(questionItem: questionItem, j: j))
                    } else if mistake.category == MistakeCategory.ChengYuYiSi.toString() {
                        questions.append(self.questionChengYuYiSi(questionItem: questionItem, j: j, questionItemCount: mistake.questionItems.count))
                    } else if mistake.category == MistakeCategory.JinYiCi.toString() || mistake.category == MistakeCategory.FanYiCi.toString() {
                        questions.append(self.questionJinFanYiCi(questionItem: questionItem, j: j))
                    } else if mistake.category == MistakeCategory.MoXieGuShi.toString() {
                        questions.append(self.questionMoXieGuShi(questionItem: questionItem, j: j, questionItemCount: mistake.questionItems.count))
                    } else if mistake.category == MistakeCategory.ZuCi.toString() {
                        questions.append(self.questionZuCi(questionItem: questionItem, j: j))
                    } else if mistake.category == MistakeCategory.XiuGaiBingJu.toString() {
                        questions.append(self.questionXiuGaiBingJu(questionItem: questionItem, j: j, questionItemCount: mistake.questionItems.count))
                    }
                } else {
                    questions.append(self.questionStandard(questionItem: questionItem))
                }
            }
            questions.append("\n\n")
        }
        
        return questions
    }
    
    private func addBodyText(textTop: CGFloat, context: UIGraphicsPDFRendererContext) { // 错题
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        
        let questions = self.extractQuestions()
        
        let attributedText = CFAttributedStringCreate(nil, questions as CFString, textAttributes as CFDictionary)
        let framesetter = CTFramesetterCreateWithAttributedString(attributedText!)
        
        var currentRange = CFRangeMake(0, 0)
        var currentPage = 1
        var done = false
        repeat {
            if currentPage > 1 {
                context.beginPage()
            }
            addPageNumber(currentPage)
            currentRange = renderPage(textTop: textTop, pageNumber: currentPage, withTextRange: currentRange, andFramesetter: framesetter)
            if currentRange.location == CFAttributedStringGetLength(attributedText) {
                done = true
            }
            currentPage += 1
        } while !done
    }
    
    private func renderPage(textTop: CGFloat, pageNumber: Int, withTextRange currentRange: CFRange, andFramesetter framesetter: CTFramesetter?) -> CFRange {
        var currentRange = currentRange
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.textMatrix = .identity
        let frameRect = CGRect(
            x: 10,
            y: 10,
            width: self.pageRect.width - 20,
            height: pageNumber == 1 ? (self.pageRect.height - 20 - textTop) : (self.pageRect.height - 20))
        let framePath = CGMutablePath()
        framePath.addRect(frameRect, transform: .identity)
        let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)
        currentContext?.translateBy(x: 0, y: self.pageRect.height)
        currentContext?.scaleBy(x: 1.0, y: -1.0)
        CTFrameDraw(frameRef, currentContext!)
        
        currentRange = CTFrameGetVisibleStringRange(frameRef)
        currentRange.location += currentRange.length
        currentRange.length = CFIndex(0)
        
        return currentRange
    }
    
    private func addPageNumber(_ pageNumber: Int) { // 页码
        let pageNumberFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let pageNumberAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: pageNumberFont]
        let attributedPageNumber = NSAttributedString(string: "\(pageNumber)", attributes: pageNumberAttributes)
        let pageNumberStringSize = attributedPageNumber.size()
        let pageNumberStringRect = CGRect(
            x: (pageRect.width - pageNumberStringSize.width) / 2.0,
            y: pageRect.height - pageNumberStringSize.height / 2.0 - 15,
            width: pageNumberStringSize.width,
            height: pageNumberStringSize.height
        )
        attributedPageNumber.draw(in: pageNumberStringRect)
    }
}
