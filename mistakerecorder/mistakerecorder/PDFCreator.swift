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
    
    init(user: User, mistakes: [Mistake]) {
        self.user = user
        self.mistakes = mistakes
    }
    
    func createPDF() -> Data {
        let metadataKeys = [
            kCGPDFContextAuthor: user.nickname,
            kCGPDFContextCreator: "mistakerecorder",
            kCGPDFContextTitle: "错题复习卷"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = metadataKeys as [String: Any]
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let render = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = render.pdfData { context in
            context.beginPage()
            let titleBottom = addTitle(pageRect: pageRect)
            let subtitleBottom = addSubtitle(pageRect: pageRect, textTop: titleBottom)
            addBodyText(pageRect: pageRect, textTop: subtitleBottom + 36.0)
        }
        
        return data
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
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
    
    func addSubtitle(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
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
    
    func addBodyText(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        var questions = ""
        var i = 1
        for mistake in mistakes {
            questions.append("第\(i)题 \(mistake.questionDescription)\n")
            var j = 1
            for item in mistake.questionItems {
                questions.append("(\(j)) \(item.question)：(")
                for _ in 1...item.rightAnswer.count {
                    questions.append("  ")
                }
                questions.append(")\n")
                j = j + 1
            }
            questions.append("\n")
            i = i + 1
        }
        let attributedText = NSAttributedString(string: questions, attributes: textAttributes)
        let textRect = CGRect(
            x: 10,
            y: textTop,
            width: pageRect.width - 20,
            height: pageRect.height - textTop - pageRect.height / 5.0
        )
        attributedText.draw(in: textRect)
    }
}
