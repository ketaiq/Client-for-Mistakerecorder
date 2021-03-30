//
//  MistakeChengYuYiSiEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/30.
//

import SwiftUI

struct MistakeChengYuYiSiEditView: View {
    @ObservedObject var questionItem: QuestionItem
    
    @StateObject private var text = ObservableString(content: "")
    @State private var committed = false
    @State private var showOCRView = false
    
    func save() {
        let idiomDictionaryData = readJSONData(fileName: "idiom.json")!
        do {
            let idiomDictionary = try JSONDecoder().decode([Idiom].self, from: idiomDictionaryData)
            let idiom = idiomDictionary.filter { $0.word == self.text.content }.first ?? Idiom(derivation: "", example: "", explanation: "", pinyin: "", word: "", abbreviation: "")
            if idiom.explanation != "" {
                questionItem.question = idiom.explanation
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
                .padding(.top)
            
            HStack {
                Button(action: {
                    self.showOCRView = true
                }, label: {
                    Image(systemName: "camera")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .font(.system(size: 30))
                        .padding(.horizontal)
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
                        .padding(.horizontal)
                })
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            TextField("请在此输入一个成语...", text: self.$text.content, onCommit: {
                self.committed = true
            })
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
                        self.committed = false
                    }, label: {
                        Text("保存")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 40)
                            .background(self.committed ? Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    })
                }
                if !self.committed {
                    Color.white.opacity(0.1)
                }
            }
            .frame(height: 40)
            .padding()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("当前题目：")
                        .font(.system(size: 20))
                        .bold()
                    Text("\(questionItem.question)")
                        .font(.system(size: 20))
                }
                .padding(.horizontal)
                HStack {
                    Text("当前答案：")
                        .font(.system(size: 20))
                        .bold()
                    Text("\(questionItem.rightAnswer)")
                        .font(.system(size: 20))
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}

struct MistakeChengYuYiSiEditView_Previews: PreviewProvider {
    @StateObject static var questionItem = QuestionItem(question: "东看看，西看看，形容四处张望。", rightAnswer: "东张西望")
    
    static var previews: some View {
        MistakeChengYuYiSiEditView(questionItem: questionItem)
    }
}
