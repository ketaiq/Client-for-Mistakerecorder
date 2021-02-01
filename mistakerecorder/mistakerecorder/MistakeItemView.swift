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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("所属学科：")
                    TextField("", text: $subject)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("题型：")
                    TextField("", text: $category)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("题干描述：")
                    TextField("", text: $questionDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Button(action: {
                    mistake.subject = subject
                    mistake.category = category
                    mistake.questionDescription = questionDescription
                }, label: {
                    Text("保存")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .cornerRadius(20)
                })
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
            .navigationBarTitle(mistake.subject)
            .padding()
        }
    }
}

struct MistakeItemView_Previews: PreviewProvider {
    static var previews: some View {
        MistakeItemView(mistake: mistakeListExample[0])
    }
}
