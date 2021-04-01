//
//  MistakeJinFanYiCiEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/31.
//

import SwiftUI

struct MistakeJinFanYiCiEditView: View {
    var type: String // 近义词或反义词
    @ObservedObject var questionItem: QuestionItem
    
    @StateObject private var text = ObservableString(content: "")
    @State private var showOCRView = false
    
    func save() {
        NetworkAPIFunctions.functions.jinFanYiCiSearch(word: self.text.content, type: type, questionItem: questionItem)
        questionItem.question = self.text.content
    }
    
    var body: some View {
        VStack {
            Text("编辑\(type)题")
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
            
            TextField("请在此输入一个词语...", text: self.$text.content)
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
            .padding()
            
            VStack(spacing: 20) {
                HStack {
                    Text("当前题目：")
                        .font(.system(size: 20))
                        .bold()
                    Text("\(questionItem.question)")
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
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct MistakeJinFanYiCiEditView_Previews: PreviewProvider {
    static let type = MistakeCategory.JinYiCi.toString()
    @StateObject static var questionItem = QuestionItem(question: "希罕", rightAnswer: "稀少")
    static var previews: some View {
        MistakeJinFanYiCiEditView(type: type, questionItem: questionItem)
    }
}
