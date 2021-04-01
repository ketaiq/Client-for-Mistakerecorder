//
//  MistakeCategory.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/31.
//

import Foundation

enum MistakeCategory {
    case PinYinXieCi // 拼音写词
    case ChengYuYiSi // 成语意思
    case JinYiCi // 近义词
    case FanYiCi // 反义词
    case MoXieGuShi // 默写古诗
    case ZuCi // 组词
    case DuoYinZi // 多音字
    case XiuGaiBingJu // 修改病句
    
    public func toString() -> String {
        if self == .PinYinXieCi {
            return "拼音写词"
        } else if self == .ChengYuYiSi {
            return "成语意思"
        } else if self == .JinYiCi {
            return "近义词"
        } else if self == .FanYiCi {
            return "反义词"
        } else if self == .MoXieGuShi {
            return "默写古诗"
        } else if self == .ZuCi {
            return "组词"
        } else if self == .DuoYinZi {
            return "多音字"
        } else if self == .XiuGaiBingJu {
            return "修改病句"
        } else {
            return ""
        }
    }
    
    public func generateDescription() -> String {
        if self == .PinYinXieCi {
            return "认真拼读音节，写出下列词语。"
        } else if self == .ChengYuYiSi {
            return "根据意思写成语。"
        } else if self == .JinYiCi {
            return "请写出下列词语的近义词。"
        } else if self == .FanYiCi {
            return "请写出下列词语的反义词。"
        } else if self == .MoXieGuShi {
            return "默写所学的古诗。"
        } else if self == .ZuCi {
            return "比较字形，然后组词。"
        } else if self == .DuoYinZi {
            return "给带点字选择正确的读音。"
        } else if self == .XiuGaiBingJu {
            return "修改下列病句。"
        } else {
            return ""
        }
    }
}

class PinYinXieCi: ObservableObject {
    @Published var items: [PinYinXieCiItem]
    
    init() {
        self.items = [PinYinXieCiItem]()
    }
    
    init(questionItem: QuestionItem) {
        self.items = [PinYinXieCiItem]()
        for word in questionItem.question {
            if word != "*" {
                self.items.append(PinYinXieCiItem(word: String(word)))
            } else {
                self.items.last!.selected = true
            }
        }
    }
    
    func copy(_ text: String) {
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

struct Idiom: Codable { // 成语
    let derivation: String // 出处
    let example: String // 例句
    let explanation: String // 解释
    let pinyin: String // 拼音
    let word: String // 成语
    let abbreviation: String // 缩写
}

struct JinFanYiCi: Codable { // 请求返回格式
    let status: Int
    let msg: String
    let result: JinFanYiCiResult
}

struct JinFanYiCiResult: Codable { // 近义词或反义词
    let word: String
    let pinyin: String
    let content: String
    let jin: [String]
    let fan: [String]
}

struct PoemChapter: Codable { // 古诗章节
    let status: Int
    let msg: String
    let result: [PoemItem]
}

struct PoemItem: Codable { // 古诗项
    let detailid: Int
    let name: String
    let author: String
}

struct PoemDetail: Codable { // 古诗详情
    let status: Int
    let msg: String
    let result: Poem
}

struct Poem: Codable { // 古诗
    let detailid: Int
    let title: String
    let type: String
    let content: String
    let explanation: String
    let appreciation: String
    let author: String
    
    static func getProperty(questionItem: QuestionItem, propety: String) -> String {
        if propety == "title" {
            return getTitle(questionItem: questionItem)
        } else if propety == "type" {
            return getType(questionItem: questionItem)
        } else if propety == "content" {
            return getContent(questionItem: questionItem)
        } else if propety == "explanation" {
            return getExplanation(questionItem: questionItem)
        } else if propety == "appreciation" {
            return getAppreciation(questionItem: questionItem)
        } else if propety == "author" {
            return getAuthor(questionItem: questionItem)
        } else {
            return ""
        }
    }
    
    private static func getType(questionItem: QuestionItem) -> String {
        if questionItem.rightAnswer.components(separatedBy: "/").count > 0 {
            return questionItem.rightAnswer.components(separatedBy: "/")[0]
        } else {
            return ""
        }
    }
    private static func getContent(questionItem: QuestionItem) -> String {
        if questionItem.rightAnswer.components(separatedBy: "/").count > 1 {
            return questionItem.rightAnswer.components(separatedBy: "/")[1]
        } else {
            return ""
        }
    }
    private static func getExplanation(questionItem: QuestionItem) -> String {
        if questionItem.rightAnswer.components(separatedBy: "/").count > 2 {
            return questionItem.rightAnswer.components(separatedBy: "/")[2]
        } else {
            return ""
        }
    }
    private static func getAppreciation(questionItem: QuestionItem) -> String {
        if questionItem.rightAnswer.components(separatedBy: "/").count > 3 {
            return questionItem.rightAnswer.components(separatedBy: "/")[3]
        } else {
            return ""
        }
    }
    private static func getAuthor(questionItem: QuestionItem) -> String {
        if questionItem.rightAnswer.components(separatedBy: "/").count > 4 {
            return questionItem.rightAnswer.components(separatedBy: "/")[4]
        } else {
            return ""
        }
    }
    private static func getTitle(questionItem: QuestionItem) -> String {
        if questionItem.rightAnswer.components(separatedBy: "/").count > 5 {
            return questionItem.rightAnswer.components(separatedBy: "/")[5]
        } else {
            return ""
        }
    }
}

struct Ci: Codable {
    let ci: String
    let explanation: String
}
