//
//  MistakeItemView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/29.
//

import SwiftUI

struct MistakeItemView: View {
    @ObservedObject var user: User
    @ObservedObject var mistake: Mistake
    @State private var subject: String = ""
    @State private var category: String = ""
    @State private var questionDescription: String = ""
    @State private var saveButtonPressed = false
    @State private var subjectCommit = false
    @State private var categoryCommit = false
    @State private var questionDescriptionCommit = false
    @State private var questionItemSaved = false
    @State private var mistakeUnsavedAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("创建时间：\(self.mistake.createdDate)")
                    Spacer()
                }
                HStack {
                    Text("下一次复习时间：\(self.mistake.nextRevisionDate)")
                    Spacer()
                }
                HStack {
                    Text("复习记录：")
                    Image(systemName: "calendar")
                        .font(.system(size: 32))
                        .foregroundColor(.orange)
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(mistake.revisedRecords.indices, id: \.self) { index in
//                                VStack {
//                                    Text(mistake.revisedRecords[index].revisedDate)
//                                    Text(mistake.revisedRecords[index].revisedPerformance)
//                                }
//                            }
//                        }
//                    }
                }
                ZStack {
                    HStack {
                        Text("所属学科：")
                        TextField("\(self.mistake.subject)", text: $subject,
                        onEditingChanged: { isBegin in
                            if isBegin {
                                self.subjectCommit = false
                                self.questionItemSaved = false
                            }
                        },
                        onCommit: {
                            self.mistake.subject = self.subject
                            self.subjectCommit = true
                            self.questionItemSaved = true
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    HStack {
                        Spacer()
                        Image(systemName: self.subjectCommit ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(self.subjectCommit ? .blue : .gray)
                            .opacity(self.subjectCommit ? 1 : 0.5)
                            .font(.system(size: 20))
                    }
                }
                ZStack {
                    HStack {
                        Text("题型：")
                        TextField("\(self.mistake.category)", text: $category,
                        onEditingChanged: { isBegin in
                            if isBegin {
                                self.categoryCommit = false
                                self.questionItemSaved = false
                            }
                        },
                        onCommit: {
                            self.mistake.category = self.category
                            self.categoryCommit = true
                            self.questionItemSaved = true
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    HStack {
                        Spacer()
                        Image(systemName: self.categoryCommit ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(self.categoryCommit ? .blue : .gray)
                            .opacity(self.categoryCommit ? 1 : 0.5)
                            .font(.system(size: 20))
                    }
                }
                ZStack {
                    HStack {
                        Text("题干描述：")
                        TextField("\(self.mistake.questionDescription)", text: $questionDescription,
                        onEditingChanged: { isBegin in
                            if isBegin {
                                self.questionDescriptionCommit = false
                                self.questionItemSaved = false
                            }
                        },
                        onCommit: {
                            self.mistake.questionDescription = self.questionDescription
                            self.questionDescriptionCommit = true
                            self.questionItemSaved = true
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    HStack {
                        Spacer()
                        Image(systemName: self.questionDescriptionCommit ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(self.questionDescriptionCommit ? .blue : .gray)
                            .opacity(self.questionDescriptionCommit ? 1 : 0.5)
                            .font(.system(size: 20))
                    }
                }
                ForEach(mistake.questionItems) { item in
                    QuestionItemView(questionItem: item, questionItemSaved: $questionItemSaved)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        questionItemSaved = false
                        mistake.questionItems.append(
                            QuestionItem(question: "题目项题目",
                                         rightAnswer: "题目项答案"))
                    }, label: {
                        HStack {
                            Text("增加题目项")
                                .font(.system(size: 16))
                                .bold()
                                .foregroundColor(.white)
                            Image(systemName: "plus.circle")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(width: 160, height: 50)
                        .background(Color.blue)
                        .cornerRadius(20)
                    })
                    Spacer()
                    Button(action: {
                        if questionItemSaved {
                            NetworkAPIFunctions.functions.updateMistakeList(user: user)
                            saveButtonPressed = true
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            mistakeUnsavedAlert = true
                        }
                    }, label: {
                        Text("同步")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.blue)
                            .cornerRadius(20)
                    })
                    .alert(isPresented: self.$saveButtonPressed, content: {
                        return Alert(title: Text("提醒"),
                                     message: Text("同步成功！"),
                                     dismissButton: .default(Text("确认")) {
                                        saveButtonPressed = false
                                     })
                    })
                    .alert(isPresented: self.$mistakeUnsavedAlert, content: {
                        return Alert(title: Text("警告"),
                                     message: Text("输入数据后需按回车确认！"),
                                     dismissButton: .default(Text("确认")) {
                                        saveButtonPressed = false
                                     })
                    })
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct MistakeItemView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")
    static var previews: some View {
        MistakeItemView(user: user, mistake: user.mistakeList[0])
    }
}
