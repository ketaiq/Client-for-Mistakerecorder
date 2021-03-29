//
//  PinYinXieCi.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/29.
//

import Foundation

class PinYinXieCiCollection: ObservableObject {
    @Published var objects: [PinYinXieCi]
    
    init() {
        self.objects = [PinYinXieCi]()
    }
}

class PinYinXieCi: ObservableObject {
    @Published var items: [PinYinXieCiItem]
    
    init(_ text: String) {
        self.items = [PinYinXieCiItem]()
        for word in text {
            self.items.append(PinYinXieCiItem(word: String(word)))
        }
    }
    
    func getQuestion() -> String {
        var question = ""
        for item in self.items {
            if item.selected {
                question.append(item.word + "*") // 标记要展示拼音的词
            } else {
                question.append(item.word)
            }
        }
        return question
    }
    
    func getRightAnswer() -> String {
        var answer = ""
        for item in self.items {
            if item.selected {
                answer.append(item.word)
            }
        }
        return answer
    }
}

class PinYinXieCiItem: ObservableObject {
    @Published var word: String
    @Published var selected: Bool
    @Published var pin_yin: String
    
    init(word: String) {
        self.word = word
        self.selected = false
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[\u{4e00}-\u{9fa5}]{1}$")
        if predicate.evaluate(with: word) {
            let wordRef = NSMutableString(string: word) as CFMutableString
            CFStringTransform(wordRef, nil, kCFStringTransformToLatin, false)
            self.pin_yin = wordRef as String
        } else {
            self.pin_yin = ""
        }
    }
}
