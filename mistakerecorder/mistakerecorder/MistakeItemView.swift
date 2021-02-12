//
//  MistakeItemView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/29.
//

import SwiftUI

struct MistakeItemView: View {
    @ObservedObject var mistake: Mistake
    @State var subject: String = ""
    @State var category: String = ""
    @State var questionDescription: String = ""
    @State var saveButtonPressed = false
    @State var subjectCommit = false
    @State var categoryCommit = false
    @State var questionDescriptionCommit = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    HStack {
                        Text("所属学科：")
                        TextField("\(self.mistake.subject)", text: $subject,
                        onEditingChanged: { isBegin in
                            if isBegin {
                                self.subjectCommit = false
                            }
                        },
                        onCommit: {
                            self.mistake.subject = self.subject
                            self.subjectCommit = true
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
                            }
                        },
                        onCommit: {
                            self.mistake.category = self.category
                            self.categoryCommit = true
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
                            }
                        },
                        onCommit: {
                            self.mistake.questionDescription = self.questionDescription
                            self.questionDescriptionCommit = true
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
                    QuestionItemView(questionItem: item)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        mistake.questionItems.append(
                            QuestionItem(_id: "",
                                         question: "题目项题目",
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
                        NetworkAPIFunctions.functions.updateMistake(mistake: self.mistake)
                        saveButtonPressed.toggle()
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
                              dismissButton: .default(Text("确认")))
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
    static var previews: some View {
        MistakeItemView(mistake: mistakeListExample[0])
    }
}
