//
//  MistakeZuCiEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/1.
//

import SwiftUI

struct MistakeZuCiEditView: View {
    @ObservedObject var questionItem: QuestionItem
    
    @StateObject private var text = ObservableString("")
    @State private var showOCRView = false
    
    func save() {
        questionItem.question = self.text.content
        questionItem.rightAnswer = ""
        let ciDictionaryData = readJSONData(fileName: "ci.json")!
        do {
            let ciDictionary = try JSONDecoder().decode([Ci].self, from: ciDictionaryData)
            let ciArray = ciDictionary.filter { $0.ci.contains(self.text.content) }
            for ci in ciArray {
                questionItem.rightAnswer.append(ci.ci + "/")
            }
            questionItem.rightAnswer.removeLast()
        } catch {
            print("词典编码错误！")
        }
    }
    
    var body: some View {
        VStack {
            Text("编辑\(MistakeCategory.ZuCi.toString())题")
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
            
            TextField("请在此输入一个字用于组词...", text: self.$text.content)
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
                    Text("\(questionItem.question)  (     )")
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Text("当前答案：")
                        .font(.system(size: 20))
                        .bold()
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("\(questionItem.rightAnswer)")
                                .font(.system(size: 20))
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(9)
                    .background(Color.green)
                    .cornerRadius(15)
                    Spacer()
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct MistakeZuCiEditView_Previews: PreviewProvider {
    @StateObject static var questionItem = QuestionItem(question: "传", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染")
    
    static var previews: some View {
        MistakeZuCiEditView(questionItem: questionItem)
    }
}
