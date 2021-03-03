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
    @State private var showRevisedRecordsCalendar = false
    @State private var revisedRecordsCalendarViewDragPosition = CGSize.zero
    
    var body: some View {
        ZStack {
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
                        Button(action: {
                            self.showRevisedRecordsCalendar = true
                        }, label: {
                            Image(systemName: "calendar")
                                .font(.system(size: 32))
                                .foregroundColor(.orange)
                        })
                        
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
                                    .font(.system(size: 20, weight: .bold))
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 20))
                            }
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
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
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
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
            .blur(radius: self.showRevisedRecordsCalendar ? 10 : 0)
            RevisedRecordsCalendarView(mistake: mistake, dateArray: DateArray(dates: DateFunctions.functions.generateDatesOfMonth(givenDate: mistake.createdDate)))
                .offset(y: self.showRevisedRecordsCalendar ? 0 : 1000)
                .offset(y: self.revisedRecordsCalendarViewDragPosition.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture()
                        .onChanged() { value in
                            self.revisedRecordsCalendarViewDragPosition = value.translation
                        }
                        .onEnded() { value in
                            if self.revisedRecordsCalendarViewDragPosition.height > 50 {
                                self.showRevisedRecordsCalendar = false
                            }
                            revisedRecordsCalendarViewDragPosition = .zero
                        }
                )
        }
    }
}

struct MistakeItemView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!.pngData()!.base64EncodedString())
    static var previews: some View {
        MistakeItemView(user: user, mistake: user.mistakeList[0])
    }
}
