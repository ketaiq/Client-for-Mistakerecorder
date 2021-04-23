//
//  OCRFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/23.
//

import Foundation

class OCRFunctions {
    public static func combineAnswers(mistake: Mistake, updateText: ObservableBool, ocr_results: DocOCR, questionItemIndex: Int) {
        mistake.questionItems[questionItemIndex].answer = ""
        for result in ocr_results.results {
            mistake.questionItems[questionItemIndex].answer.append(result.words.word)
        }
        updateText.content = true
    }
    
    public static func extractAnswers(mistake: Mistake, updateText: ObservableBool, ocr_results: DocOCR) {
        var question_string = ""
        var answer_begin_index = 0
        
        for i in 0 ..< ocr_results.results_num {
            let result = ocr_results.results[i]
            if result.words_type == "print" && MistakeCategory.isGeneratedDescription(result.words.word) {
                question_string = result.words.word.removePunctuations()
                answer_begin_index = i + 1
                break
            }
        }
        
        let PinYinXieCiDescription = MistakeCategory.PinYinXieCi.generateDescription().removePunctuations()
        let ChengYuYiSiDescription = MistakeCategory.ChengYuYiSi.generateDescription().removePunctuations()
        let JinYiCiDescription = MistakeCategory.JinYiCi.generateDescription().removePunctuations()
        let FanYiCiDescription = MistakeCategory.FanYiCi.generateDescription().removePunctuations()
        let MoXieGuShiDescription = MistakeCategory.MoXieGuShi.generateDescription().removePunctuations()
        let ZuCiDescription = MistakeCategory.ZuCi.generateDescription().removePunctuations()
        let XiuGaiBingJuDescription = MistakeCategory.XiuGaiBingJu.generateDescription().removePunctuations()
        
        for i in 0 ..< mistake.questionItems.count {
            mistake.questionItems[i].answer = "识别结果为空！"
            var question = ""
            if question_string.contains(PinYinXieCiDescription) {
                for item in PinYinXieCi(questionItem: mistake.questionItems[i]).items {
                    if !item.selected {
                        question.append("\(item.word)")
                    }
                }
            } else if question_string.contains(ChengYuYiSiDescription) {
                question = Idiom.getExplanation(mistake.questionItems[i].question).removePunctuations()
            } else if question_string.contains(JinYiCiDescription) || question_string.contains(FanYiCiDescription) {
                question = JinFanYiCiResult.getWord(mistake.questionItems[i].question)
            } else if question_string.contains(MoXieGuShiDescription) {
                question = Poem.getTitle(mistake.questionItems[i].question)
            } else if question_string.contains(ZuCiDescription) {
                question = mistake.questionItems[i].question
            } else if question_string.contains(XiuGaiBingJuDescription) {
                question = BingJu.getSentence(mistake.questionItems[i].question).removePunctuations()
            }
            var findQuestion = false
            if MistakeCategory.isLongTextCategory(mistake.category) {
                for j in answer_begin_index ..< ocr_results.results_num {
                    let result = ocr_results.results[j]
                    if result.words_type == "print" {
                        if result.words.word.removePunctuations().contains(question) && !findQuestion {
                            findQuestion = true
                        } else if !result.words.word.removePunctuations().contains(question) && findQuestion {
                            answer_begin_index = j
                            break
                        }
                    }
                    if findQuestion && result.words_type == "handwriting" {
                        if mistake.questionItems[i].answer == "识别结果为空！" {
                            mistake.questionItems[i].answer = ""
                        }
                        mistake.questionItems[i].answer.append(result.words.word)
                    }
                }
            } else {
                for j in answer_begin_index ..< ocr_results.results_num - 1 {
                    let result = ocr_results.results[j]
                    let nextResult = ocr_results.results[j + 1]
                    
                    if result.words_type == "print" && result.words.word.removePunctuations().contains(question) && nextResult.words_type == "handwriting" {
                        mistake.questionItems[i].answer = nextResult.words.word
                        answer_begin_index += 2
                        break
                    }
                }
            }
        }
        updateText.content = true
    }
}
