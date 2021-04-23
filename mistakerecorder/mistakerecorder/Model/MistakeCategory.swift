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
        } else if self == .XiuGaiBingJu {
            return "修改下列病句。"
        } else {
            return ""
        }
    }
    
    public static func isPresetCategory(category: String) -> Bool {
        if category == MistakeCategory.PinYinXieCi.toString() || category == MistakeCategory.ChengYuYiSi.toString() || category == MistakeCategory.JinYiCi.toString() || category == MistakeCategory.FanYiCi.toString() || category == MistakeCategory.MoXieGuShi.toString() || category == MistakeCategory.ZuCi.toString() || category == MistakeCategory.XiuGaiBingJu.toString() {
            return true
        } else {
            return false
        }
    }
    
    public static func isLongTextCategory(_ category: String) -> Bool {
        if category == MistakeCategory.PinYinXieCi.toString() || category == MistakeCategory.ChengYuYiSi.toString() || category == MistakeCategory.JinYiCi.toString() || category == MistakeCategory.FanYiCi.toString() || category == MistakeCategory.ZuCi.toString() {
            return false
        } else {
            return true
        }
    }
    
    public static func isGeneratedDescription(_ description: String) -> Bool {
        if description.removePunctuations().contains(MistakeCategory.PinYinXieCi.generateDescription().removePunctuations()) || description.removePunctuations().contains(MistakeCategory.ChengYuYiSi.generateDescription().removePunctuations()) || description.removePunctuations().contains(MistakeCategory.JinYiCi.generateDescription().removePunctuations()) || description.removePunctuations().contains(MistakeCategory.FanYiCi.generateDescription().removePunctuations()) || description.removePunctuations().contains(MistakeCategory.MoXieGuShi.generateDescription().removePunctuations()) || description.removePunctuations().contains(MistakeCategory.ZuCi.generateDescription().removePunctuations()) || description.removePunctuations().contains(MistakeCategory.XiuGaiBingJu.generateDescription().removePunctuations()) {
            return true
        } else {
            return false
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
    
    public func toJsonString() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
    
    public static func getDerivation(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let idiom = try JSONDecoder().decode(Idiom.self, from: jsonData)
                return idiom.derivation
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getExample(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let idiom = try JSONDecoder().decode(Idiom.self, from: jsonData)
                return idiom.example
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getExplanation(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let idiom = try JSONDecoder().decode(Idiom.self, from: jsonData)
                return idiom.explanation
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getPinyin(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let idiom = try JSONDecoder().decode(Idiom.self, from: jsonData)
                return idiom.pinyin
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getWord(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let idiom = try JSONDecoder().decode(Idiom.self, from: jsonData)
                return idiom.word
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getAbbreviation(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let idiom = try JSONDecoder().decode(Idiom.self, from: jsonData)
                return idiom.abbreviation
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
}

struct JinFanYiCi: Codable { // 请求返回格式
    let status: Int
    let msg: String
    let result: JinFanYiCiResult
}

struct JinFanYiCiResult: Codable { // 近义词或反义词
    let word: String // 查询词语
    let pinyin: String // 查询词语的拼音
    let content: String // 解释
    let jin: [String] // 近义词组
    let fan: [String] // 反义词组
    
    public func toJsonString() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
    
    public static func getWord(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let jinFanYiCiResult = try JSONDecoder().decode(JinFanYiCiResult.self, from: jsonData)
                return jinFanYiCiResult.word
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getPinyin(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let jinFanYiCiResult = try JSONDecoder().decode(JinFanYiCiResult.self, from: jsonData)
                return jinFanYiCiResult.pinyin
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getContent(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let jinFanYiCiResult = try JSONDecoder().decode(JinFanYiCiResult.self, from: jsonData)
                return jinFanYiCiResult.content
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getJin(_ jsonString: String) -> [String] {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let jinFanYiCiResult = try JSONDecoder().decode(JinFanYiCiResult.self, from: jsonData)
                return jinFanYiCiResult.jin
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return [String]()
    }
    
    public static func getFan(_ jsonString: String) -> [String] {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let jinFanYiCiResult = try JSONDecoder().decode(JinFanYiCiResult.self, from: jsonData)
                return jinFanYiCiResult.fan
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return [String]()
    }
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
    let detailid: Int // 详情ID
    let title: String // 名称
    let type: String // 类型
    let content: String // 内容
    let explanation: String // 解释
    let appreciation: String // 赏析
    let author: String // 作者
    
    public func toJsonString() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
    
    public static func getDetailid(_ jsonString: String) -> Int {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let poemResult = try JSONDecoder().decode(Poem.self, from: jsonData)
                return poemResult.detailid
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return -1
    }
    
    public static func getTitle(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let poemResult = try JSONDecoder().decode(Poem.self, from: jsonData)
                return poemResult.title
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getType(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let poemResult = try JSONDecoder().decode(Poem.self, from: jsonData)
                return poemResult.type
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getContent(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let poemResult = try JSONDecoder().decode(Poem.self, from: jsonData)
                return poemResult.content
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getExplanation(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let poemResult = try JSONDecoder().decode(Poem.self, from: jsonData)
                return poemResult.explanation
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getAppreciation(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let poemResult = try JSONDecoder().decode(Poem.self, from: jsonData)
                return poemResult.appreciation
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getAuthor(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let poemResult = try JSONDecoder().decode(Poem.self, from: jsonData)
                return poemResult.author
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
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

struct BingJu: Codable {
    let sentence: String
    let type: [String]
    
    public func toJsonString() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
    
    public static func getSentence(_ jsonString: String) -> String {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let bingJuResult = try JSONDecoder().decode(BingJu.self, from: jsonData)
                return bingJuResult.sentence
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return ""
    }
    
    public static func getType(_ jsonString: String) -> [String] {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let bingJuResult = try JSONDecoder().decode(BingJu.self, from: jsonData)
                return bingJuResult.type
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("jsonData提取失败！")
        }
        return [String]()
    }
}

enum BingJuCategory {
    case ChengFenCanQue // 成分残缺
    case YongCiBuDang // 用词不当
    case DaPeiBuDang // 搭配不当
    case QianHouMaoDun // 前后矛盾
    case CiXuDianDao // 词序颠倒
    case ChongFuLuoSuo // 重复啰嗦
    case GaiNianBuQing // 概念不清
    case BuHeLuoJi // 不合逻辑
    case ZhiDaiBuMing // 指代不明
    
    public func toString() -> String {
        if self == .ChengFenCanQue {
            return "成分残缺"
        } else if self == .YongCiBuDang {
            return "用词不当"
        } else if self == .DaPeiBuDang {
            return "搭配不当"
        } else if self == .QianHouMaoDun {
            return "前后矛盾"
        } else if self == .CiXuDianDao {
            return "词序颠倒"
        } else if self == .ChongFuLuoSuo {
            return "重复啰嗦"
        } else if self == .GaiNianBuQing {
            return "概念不清"
        } else if self == .BuHeLuoJi {
            return "不合逻辑"
        } else if self == .ZhiDaiBuMing {
            return "指代不明"
        } else {
            return ""
        }
    }
    
    public func getDetail() -> String {
        if self == .ChengFenCanQue {
            return "句子里缺少了某些必要的成分，意思表达就不完整，不明确。\n例如：“为了班集体，做了很多好事。”谁做了许多好事，不明确。"
        } else if self == .YongCiBuDang {
            return "由于对词义理解不清，就容易在词义范围大小、褒贬等方面使用不当，特别是近义词、关联词用错，造成病句。\n例如：“他做事很冷静、武断。”“武断”是贬义词，用得不当，应改为“果断”。"
        } else if self == .DaPeiBuDang {
            return "在句子中某些词语在意义上不能相互搭配或者搭配起来不合事理，违反了语言的习惯，造成了病句。包括一些关联词语的使用不当。\n例如：“在联欢会上，我们听到悦耳的歌声和优美的舞蹈。”“听到”与“优美的舞蹈”显然不能搭配，应改为“在联欢会上，我们听到悦耳的歌声，看到优美的舞蹈。”\n例如：“如果我们生活富裕了，就不应该浪费。”显然关联词使用错误，应改为“即使我们生活富裕了，也不应该浪费。”"
        } else if self == .QianHouMaoDun {
            return "在同一个句子中，前后表达的意思自相矛盾，造成了语意不明。\n例如：“我估计他这道题目肯定做错了。”前半句估计是不够肯定的意思，而后半句又肯定他错了，便出现了矛盾，到底情况如何呢？使人不清楚。可以改为“我估计他这道题做错了。”或“我断定他这道题做错了。”"
        } else if self == .CiXuDianDao {
            return "在一般情况下，一句话里面的词序是固定的，词序变了，颠倒了位置，句子的意思就会发生变化，甚至造成病句。\n例如：“语文对我很感兴趣。”“语文”和“我”的位置颠倒了，应改为“我对语文很感兴趣。”"
        } else if self == .ChongFuLuoSuo {
            return "在句子中，所用的词语的意思重复了，显得罗嗦累赘。\n例如：“他兴冲冲地跑进教室，兴高采烈地宣布了明天去春游的好消息。”句中“兴冲冲”和“兴高采烈”都是表示他很高兴的样子，可删去其中一个。"
        } else if self == .GaiNianBuQing {
            return "指句子中词语的概念不清，属性不当，范围大小归属混乱。\n例如:“万里长城、故宫博物院和南京长江大桥是中外游客向往的古迹。”这里的“南京长江大桥”不属于“古迹”，归属概念不清，应改为“万里长城、故宫博物院是中外游客向往的古迹。”"
        } else if self == .BuHeLuoJi {
            return "句子中某些词语概念不清，使用错误，或表达的意思不符合事理，也易造成病句。\n例如：“稻子成熟了，田野上一片碧绿，一派丰收的景象。”稻子成熟时是一片金黄色，而本句中形容一片碧绿，不合事理。"
        } else if self == .ZhiDaiBuMing {
            return "指句子中出现多个人或状物时，指代不明确，含混不清。\n代词分为人称代词［我、你、他（她、它）、我们……］，指示代词［这、那、这里、那儿……］和疑问代词［谁、哪里］三种，指代不明的病句指的是代词使用错误。这类病句主要有二类。一类是一个代词同时代替几个人或物，造成指代混乱。二类指示代词和疑问代词误用。\n例如：刘明和陈庆是好朋友，他经常约他去打球。——应将“他经常约他去打球”改为“刘明经常约陈庆去打球”。"
        } else {
            return ""
        }
    }
}
