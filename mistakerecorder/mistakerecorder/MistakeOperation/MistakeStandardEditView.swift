//
//  MistakeStandardEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/28.
//

import SwiftUI

struct MistakeStandardEditView: View {
    @ObservedObject var questionItem: QuestionItem
    @ObservedObject var questionText: ObservableString
    @ObservedObject var answerText: ObservableString
    @Binding var editStatus: Bool
    
    @State private var emptyAlert = false
    @State private var showQuestionOCRView = false
    @State private var showAnswerOCRView = false
    
    var body: some View {
        VStack {
            HStack {
                Text("编辑题目和答案")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {
                    if self.questionText.content != "" && self.answerText.content != "" {
                        if self.questionText.content != "请在此输入题目..." {
                            questionItem.question = self.questionText.content
                        }
                        if self.answerText.content != "请在此输入答案..." {
                            questionItem.rightAnswer = self.answerText.content
                        }
                        self.editStatus = false
                    } else {
                        self.emptyAlert = true
                    }
                }, label: {
                    Text("完成")
                        .bold()
                        .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                        .padding(.horizontal, 20)
                        .padding(10)
                        .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                        .cornerRadius(10)
                        .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                        .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                })
                .alert(isPresented: self.$emptyAlert) {
                    return Alert(
                        title: Text("警告"),
                        message: Text("题目或答案不能为空！"),
                        dismissButton: .default(Text("确认"))
                    )
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack {
                Text("题目：\(questionItem.question)")
                    .padding()
                Spacer()
            }
            HStack {
                Button(action: {
                    self.showQuestionOCRView = true
                }, label: {
                    Image(systemName: "camera")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .font(.system(size: 30))
                        .padding(.horizontal)
                })
                .sheet(isPresented: self.$showQuestionOCRView) {
                    MistakeOCRView(text: self.questionText, showMistakeOCRView: self.$showQuestionOCRView)
                }
                Button(action: {
                    self.questionText.content = ""
                }, label: {
                    Image(systemName: "clear")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .font(.system(size: 30))
                        .padding(.horizontal)
                })
                Spacer()
            }
            TextEditor(text: self.$questionText.content)
                .lineSpacing(5)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding()
                .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), center: .center, startRadius: 10, endRadius: 400))
                .onTapGesture {
                    if self.questionText.content == "请在此输入题目..." {
                        self.questionText.content = ""
                    }
                }
            HStack {
                Text("答案：\(questionItem.rightAnswer)")
                    .padding()
                Spacer()
            }
            HStack {
                Button(action: {
                    self.showAnswerOCRView = true
                }, label: {
                    Image(systemName: "camera")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .font(.system(size: 30))
                        .padding(.horizontal)
                })
                .sheet(isPresented: self.$showAnswerOCRView) {
                    MistakeOCRView(text: self.answerText, showMistakeOCRView: self.$showAnswerOCRView)
                }
                Button(action: {
                    self.answerText.content = ""
                }, label: {
                    Image(systemName: "clear")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .font(.system(size: 30))
                        .padding(.horizontal)
                })
                Spacer()
            }
            TextEditor(text: self.$answerText.content)
                .lineSpacing(5)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding()
                .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), center: .center, startRadius: 10, endRadius: 400))
                .onTapGesture {
                    if self.answerText.content == "请在此输入答案..." {
                        self.answerText.content = ""
                    }
                }
        }
    }
}

struct MistakeStandardEditView_Previews: PreviewProvider {
    @StateObject static var questionItem = QuestionItem(question: "题目一", rightAnswer: "答案一")
    @StateObject static var questionText = ObservableString(content: "请在此输入题目...")
    @StateObject static var answerText = ObservableString(content: "请在此输入答案...")
    @State static var editStatus = false
    
    static var previews: some View {
        MistakeStandardEditView(questionItem: questionItem, questionText: questionText, answerText: answerText, editStatus: $editStatus)
    }
}
