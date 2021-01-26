//
//  BackMistakeCardView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/26.
//

import SwiftUI

struct BackMistakeCardView: View {
    @State var answers: [String] = [String](repeating: "", count: 4)
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.green)
                .cornerRadius(15)
                .shadow(radius: 20)
            VStack(alignment: .leading) {
                HStack {
                    Text("语文")
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom)
                Text("写出下列词语的反义词。")
                    .font(.headline)
                Spacer()
                HStack {
                    Text("认真")
                    TextField("", text: $answers[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 16))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Text("长")
                    TextField("", text: $answers[1])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 16))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Spacer()
                HStack {
                    Text("高兴")
                    TextField("", text: $answers[2])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 16))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Text("早")
                    TextField("", text: $answers[3])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 16))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Spacer()
            }
            .padding()
        }
        .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct BackMistakeCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackMistakeCardView()
    }
}
