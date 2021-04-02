//
//  MistakeXiuGaiBingJuEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/2.
//

import SwiftUI

struct MistakeXiuGaiBingJuEditView: View {
    @ObservedObject var questionItem: QuestionItem
    
    @StateObject private var wrongSentence = ObservableString(content: "")
    @StateObject private var rightSentence = ObservableString(content: "")
    @State private var typeArray = [String]()
    @State private var showWrongSentenceOCRView = false
    @State private var showRightSentenceOCRView = false
    @State private var showMagnifyTextView = false
    @State private var magnifyText = ""
    
    func save() {
        questionItem.question = self.wrongSentence.content
        questionItem.rightAnswer = ""
        for type in self.typeArray {
            questionItem.rightAnswer.append(type + "&")
        }
        if questionItem.rightAnswer.last == "&" {
            questionItem.rightAnswer.removeLast()
        }
        questionItem.rightAnswer.append("/" + self.rightSentence.content)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("编辑\(MistakeCategory.XiuGaiBingJu.toString())题")
                    .font(.system(size: 22))
                    .bold()
                    .padding()
                
                HStack(spacing: 20) {
                    Button(action: {
                        self.showWrongSentenceOCRView = true
                    }, label: {
                        Image(systemName: "camera")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    .sheet(isPresented: self.$showWrongSentenceOCRView) {
                        MistakeOCRView(text: self.wrongSentence, showMistakeOCRView: self.$showWrongSentenceOCRView)
                    }
                    Button(action: {
                        self.wrongSentence.content = ""
                    }, label: {
                        Image(systemName: "clear")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField("请在此输入一句病句...", text: self.$wrongSentence.content)
                    .font(.system(size: 20))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                    .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button(action: {
                        self.showRightSentenceOCRView = true
                    }, label: {
                        Image(systemName: "camera")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    .sheet(isPresented: self.$showRightSentenceOCRView) {
                        MistakeOCRView(text: self.rightSentence, showMistakeOCRView: self.$showRightSentenceOCRView)
                    }
                    Button(action: {
                        self.rightSentence.content = ""
                    }, label: {
                        Image(systemName: "clear")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField("请在此输入正确句子...", text: self.$rightSentence.content)
                    .font(.system(size: 20))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                    .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    .padding(.horizontal)
                
                HStack {
                    Text("请挑选病句类型：")
                        .font(.system(size: 20))
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.ChengFenCanQue, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.YongCiBuDang, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.DaPeiBuDang, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.QianHouMaoDun, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.CiXuDianDao, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.ChongFuLuoSuo, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.GaiNianBuQing, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.BuHeLuoJi, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                            BingJuTypeSubview(typeArray: self.$typeArray, type: BingJuCategory.ZhiDaiBuMing, showMagnifyTextView: self.$showMagnifyTextView, magnifyText: self.$magnifyText)
                        }
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.save()
                            self.wrongSentence.content = ""
                            self.rightSentence.content = ""
                        }, label: {
                            Text("保存")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                .background(!self.wrongSentence.content.isEmpty && !self.rightSentence.content.isEmpty ? Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        })
                    }
                    if self.wrongSentence.content.isEmpty || self.rightSentence.content.isEmpty {
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
                        Text("\(questionItem.question)")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    HStack {
                        Text("病句类型：")
                            .font(.system(size: 20))
                            .bold()
                        Text("\(BingJu.getTypes(questionItem: questionItem))")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    HStack {
                        Text("当前答案：")
                            .font(.system(size: 20))
                            .bold()
                        Text("\(BingJu.getSentence(questionItem: questionItem))")
                            .font(.system(size: 20))
                        Spacer()
                    }
                }
                .padding()
                Spacer()
            }
            
            MagnifyTextView(show: self.$showMagnifyTextView, text: self.$magnifyText)
        }
    }
}

struct MistakeXiuGaiBingJuEditView_Previews: PreviewProvider {
    @StateObject static var questionItem = QuestionItem(question: "为了班集体，做了很多好事。", rightAnswer: "成分残缺&用词不当/为了班集体，小明做了很多好事。")
    
    static var previews: some View {
        MistakeXiuGaiBingJuEditView(questionItem: questionItem)
    }
}

struct BingJuTypeSubview: View {
    @Binding var typeArray: [String]
    let type: BingJuCategory
    @Binding var showMagnifyTextView: Bool
    @Binding var magnifyText: String
    
    @State private var typeButtonPressed = false
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
            Text(type.toString())
                .font(.system(size: 18))
                .foregroundColor(self.typeButtonPressed ? Color.white : Color.black)
            Image(systemName: "info.circle")
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .onTapGesture {
                    magnifyText = type.getDetail()
                    showMagnifyTextView = true
                }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(self.typeButtonPressed ? Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)) : Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
        .cornerRadius(20)
        .onTapGesture {
            self.typeButtonPressed.toggle()
            if self.typeButtonPressed {
                typeArray.append(type.toString())
            } else {
                let index = typeArray.firstIndex(of: type.toString())
                typeArray.remove(at: index!)
            }
        }
    }
}
