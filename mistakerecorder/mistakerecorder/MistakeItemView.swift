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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("所属学科：")
                    TextField("\(self.mistake.subject)", text: $subject,
                    onCommit: {
                        self.mistake.subject = self.subject
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                HStack {
                    Text("题型：")
                    TextField("\(self.mistake.category)", text: $category,
                    onCommit: {
                        self.mistake.category = self.category
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                HStack {
                    Text("题干描述：")
                    TextField("\(self.mistake.questionDescription)", text: $questionDescription,
                    onCommit: {
                        self.mistake.questionDescription = self.questionDescription
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                ForEach(mistake.questionItems) { item in
                    QuestionItemView(questionItem: item)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        mistake.questionItems.append(
                            QuestionItem(_id: UUID().uuidString,
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
                        saveButtonPressed.toggle()
                    }, label: {
                        Text("保存")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.blue)
                            .cornerRadius(20)
                    })
                    .alert(isPresented: self.$saveButtonPressed, content: {
                        return Alert(title: Text("提醒"),
                              message: Text("保存成功！"),
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
