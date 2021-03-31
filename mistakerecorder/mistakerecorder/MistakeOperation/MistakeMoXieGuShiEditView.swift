//
//  MistakeMoXieGuShiEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/31.
//

import SwiftUI

struct MistakeMoXieGuShiEditView: View {
    @ObservedObject var questionItem: QuestionItem
    
    @StateObject private var title = ObservableString(content: "")
    @StateObject private var author = ObservableString(content: "")
    @State private var titleCommitted = false
    @State private var authorCommitted = false
    @State private var showTitleOCRView = false
    @State private var showAuthorOCRView = false
    @State private var showPoem = false
    @State private var showExplanation = false
    @State private var showAppreciation = false
    
    func save() {
        NetworkAPIFunctions.functions.guShiSearch(title: self.title.content, author: author.content, questionItem: questionItem)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("编辑\(MistakeCategory.MoXieGuShi.toString())题")
                    .font(.system(size: 22))
                    .bold()
                    .padding()
                
                HStack(spacing: 20) {
                    Button(action: {
                        self.showTitleOCRView = true
                    }, label: {
                        Image(systemName: "camera")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    .sheet(isPresented: self.$showTitleOCRView) {
                        MistakeOCRView(text: self.title, showMistakeOCRView: self.$showTitleOCRView)
                    }
                    Button(action: {
                        self.title.content = ""
                    }, label: {
                        Image(systemName: "clear")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField("请在此输入古诗的标题...", text: self.$title.content, onCommit: {
                    self.titleCommitted = true
                })
                .font(.system(size: 20))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.vertical, 10)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button(action: {
                        self.showAuthorOCRView = true
                    }, label: {
                        Image(systemName: "camera")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    .sheet(isPresented: self.$showAuthorOCRView) {
                        MistakeOCRView(text: self.author, showMistakeOCRView: self.$showAuthorOCRView)
                    }
                    Button(action: {
                        self.author.content = ""
                    }, label: {
                        Image(systemName: "clear")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 30))
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField("请在此输入古诗的作者...", text: self.$author.content, onCommit: {
                    self.authorCommitted = true
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
                            self.title.content = ""
                            self.author.content = ""
                            self.titleCommitted = false
                            self.authorCommitted = false
                        }, label: {
                            Text("保存")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                .background(self.titleCommitted && self.authorCommitted && !self.title.content.isEmpty && !self.author.content.isEmpty ? Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        })
                    }
                    if !self.titleCommitted || !self.authorCommitted || self.title.content.isEmpty || self.author.content.isEmpty {
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
                        Text("当前答案：")
                            .font(.system(size: 20))
                            .bold()
                        ScrollView(showsIndicators: false) {
                            Text("\(Poem.getProperty(questionItem: questionItem, propety: "content").replacingOccurrences(of: "。", with: "。\n"))")
                                .font(.system(size: 20))
                                .onTapGesture {
                                    self.showPoem = true
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(Color.green)
                        .cornerRadius(15)
                        Spacer()
                    }
                    HStack {
                        Text("作者：")
                            .font(.system(size: 20))
                            .bold()
                        Text("\(Poem.getProperty(questionItem: questionItem, propety: "author"))")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    HStack {
                        Text("类型：")
                            .font(.system(size: 20))
                            .bold()
                        Text("\(Poem.getProperty(questionItem: questionItem, propety: "type"))")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    HStack {
                        Text("注释：")
                            .font(.system(size: 20))
                            .bold()
                        ScrollView(showsIndicators: false) {
                            Text("\(Poem.getProperty(questionItem: questionItem, propety: "explanation").replacingOccurrences(of: "。", with: "。\n"))")
                                .font(.system(size: 20))
                                .onTapGesture {
                                    self.showExplanation = true
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(15)
                        Spacer()
                    }
                    HStack {
                        Text("赏析：")
                            .font(.system(size: 20))
                            .bold()
                        ScrollView(showsIndicators: false) {
                            Text("\(Poem.getProperty(questionItem: questionItem, propety: "appreciation").replacingOccurrences(of: "。", with: "。\n"))")
                                .font(.system(size: 20))
                                .onTapGesture {
                                    self.showAppreciation = true
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(15)
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            MagnifyTextView(show: self.$showPoem, questionItem: questionItem, propety: "content")
            MagnifyTextView(show: self.$showExplanation, questionItem: questionItem, propety: "explanation")
            MagnifyTextView(show: self.$showAppreciation, questionItem: questionItem, propety: "appreciation")
        }
    }
}

struct MistakeMoXieGuShiEditView_Previews: PreviewProvider {
    @StateObject static var questionItem = QuestionItem(question: "行宫", rightAnswer: "五言绝句/寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。/⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。/元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。/元稹")
    static var previews: some View {
        MistakeMoXieGuShiEditView(questionItem: questionItem)
    }
}
