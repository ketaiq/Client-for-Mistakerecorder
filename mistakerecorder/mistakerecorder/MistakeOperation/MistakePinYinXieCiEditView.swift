//
//  MistakePinYinXieCiEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/28.
//

import SwiftUI

struct MistakePinYinXieCiEditView: View {
    @ObservedObject var questionItem: QuestionItem
    
    @StateObject private var pin_yin_xie_ci = PinYinXieCi()
    @StateObject private var text = ObservableString(content: "")
    @State private var committed = false
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var showOCRView = false
    
    func save() {
        questionItem.question = self.pin_yin_xie_ci.getQuestion()
        questionItem.rightAnswer = self.pin_yin_xie_ci.getRightAnswer()
    }
    
    var body: some View {
        VStack {
            Text("编辑\(MistakeCategory.PinYinXieCi.toString())题")
                .font(.system(size: 22))
                .bold()
                .padding(.top)
            
            ZStack {
                VStack {
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
                    TextField("请在此输入一个词语...", text: self.$text.content, onCommit: {
                        self.pin_yin_xie_ci.copy(self.text.content)
                        self.committed = true
                    })
                    .font(.system(size: 20))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                    .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    .padding(.bottom)
                }
                .frame(height: 150)
                .scaleEffect(self.committed ? 0.5 : 1)
                .opacity(self.committed ? 0 : 1)
                .animation(.easeInOut)
                
                VStack {
                    HStack {
                        Text("标记为拼音的字：")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(self.pin_yin_xie_ci.items.indices, id: \.self) { index in
                                PinYinXieCiSelectionSubview(item: self.pin_yin_xie_ci.items[index])
                            }
                        }
                    }
                    HStack {
                        Button(action: {
                            self.committed = false
                        }, label: {
                            Text("返回")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        })
                        Button(action: {
                            self.save()
                            self.text.content = ""
                            self.committed = false
                        }, label: {
                            Text("保存")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        })
                    }
                }
                .frame(height: 150)
                .scaleEffect(self.committed ? 1 : 0.5)
                .opacity(self.committed ? 1 : 0)
                .animation(.easeInOut)
            }
            .padding(.horizontal)
            .padding(.top)
        
            LazyVGrid(columns: columns) {
                Text("当前题目")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.bottom)
                Text("当前答案")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.bottom)
                HStack(spacing: 0) {
                    ForEach(PinYinXieCi(questionItem: questionItem).items.indices, id: \.self) { index in
                        let item = PinYinXieCi(questionItem: questionItem).items[index]
                        if item.selected {
                            VStack {
                                Text(item.pin_yin)
                                Text("(     )").font(.system(size: 20))
                            }
                        } else {
                            VStack {
                                Text(item.pin_yin).hidden()
                                Text(item.word).font(.system(size: 20))
                            }
                        }
                    }
                }
                HStack(spacing: 0) {
                    ForEach(PinYinXieCi(questionItem: questionItem).items.indices, id: \.self) { index in
                        let item = PinYinXieCi(questionItem: questionItem).items[index]
                        VStack {
                            Text(item.pin_yin).hidden()
                            Text(item.word).font(.system(size: 20))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
    }
}

struct MistakePinYinXieCiEditView_Previews: PreviewProvider {
    @StateObject static var questionItem = QuestionItem(question: "高兴*",
                                                        rightAnswer: "兴")

    static var previews: some View {
        MistakePinYinXieCiEditView(questionItem: questionItem)
    }
}

struct PinYinXieCiSelectionSubview: View {
    @ObservedObject var item: PinYinXieCiItem
    
    var body: some View {
        VStack {
            Text(item.selected ? item.pin_yin : item.word)
                .font(.system(size: 20))
                .frame(height: 30)
            Image(systemName: item.selected ? "circle.fill" : "circle")
                .font(.system(size: 25))
                .foregroundColor(item.selected ? .green : .gray)
                .onTapGesture {
                    item.selected.toggle()
                }
        }
    }
}
