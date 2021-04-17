//
//  MistakeChengYuYiSiEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/30.
//

import SwiftUI

struct MistakeChengYuYiSiEditView: View {
    @ObservedObject var questionItem: QuestionItem
    
    @StateObject private var text = ObservableString("")
    @State private var showOCRView = false
    
    func save() {
        let idiomDictionaryData = readJSONData(fileName: "idiom.json")!
        do {
            let idiomDictionary = try JSONDecoder().decode([Idiom].self, from: idiomDictionaryData)
            let idiom = idiomDictionary.filter { $0.word == self.text.content }.first ?? Idiom(derivation: "", example: "", explanation: "", pinyin: "", word: "", abbreviation: "")
            if idiom.explanation != "" {
                questionItem.question = idiom.toJsonString()
                print(questionItem.question)
            } else {
                questionItem.question = "该成语不存在。"
            }
        } catch {
            print("成语词典编码错误！")
        }
        questionItem.rightAnswer = self.text.content
    }
    
    var body: some View {
        VStack {
            Text("编辑\(MistakeCategory.ChengYuYiSi.toString())题")
                .font(.system(size: 22))
                .bold()
                .padding()
            
            HStack(spacing: 20) {
                Button(action: {
                    self.showOCRView = true
                }, label: {
                    Image(systemName: "camera")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .font(.system(size: 30))
                })
                .sheet(isPresented: self.$showOCRView) {
                    MistakeOCRView(text: self.text, showMistakeOCRView: self.$showOCRView)
                }
                Button(action: {
                    self.text.content = ""
                }, label: {
                    Image(systemName: "clear")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .font(.system(size: 30))
                })
                Spacer()
            }
            .padding(.horizontal)
            
            TextField("请在此输入一个成语...", text: self.$text.content)
            .font(.system(size: 20))
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
            .padding(.horizontal)
            
            ZStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.save()
                        self.text.content = ""
                    }, label: {
                        Text("保存")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 40)
                            .background(!self.text.content.isEmpty ? Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    })
                }
                if self.text.content.isEmpty {
                    Color.white.opacity(0.1)
                }
            }
            .frame(height: 40)
            .padding(.horizontal)
            
            VStack(spacing: 20) {
                HStack {
                    Text("当前题目：")
                        .font(.system(size: 20))
                        .bold()
                    Text("\(Idiom.getExplanation(self.questionItem.question))")
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Text("当前答案：")
                        .font(.system(size: 20))
                        .bold()
                    Text("\(questionItem.rightAnswer)")
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Text("例句：")
                        .font(.system(size: 20))
                        .bold()
                    Text("\(Idiom.getExample(self.questionItem.question))")
                        .font(.system(size: 20))
                    Spacer()
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct MistakeChengYuYiSiEditView_Previews: PreviewProvider {
    @StateObject static var questionItem = QuestionItem(question: Idiom(derivation: "出自", example: "例句", explanation: "解释", pinyin: "拼音", word: "成语", abbreviation: "sx").toJsonString(), rightAnswer: "东张西望")
    
    static var previews: some View {
        MistakeChengYuYiSiEditView(questionItem: questionItem)
    }
}
