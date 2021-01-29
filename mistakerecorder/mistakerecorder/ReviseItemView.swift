//
//  ReviseItemView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct ReviseItemView: View {
    var mistake: Mistake
    @State var showingRightAnswers = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(mistake.questionDescription)
                    .font(.system(size: 20))
                ForEach(mistake.questionItems) { item in
                    HStack {
                        Text(item.question)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
                Button(action: {
                    showingRightAnswers.toggle()
                }, label: {
                    HStack {
                        Text("显示/隐藏答案")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                })
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                ForEach(mistake.questionItems) { item in
                    HStack {
                        Text("\(item.question) -------- \(item.rightAnswer)")
                            .font(.system(size: 16))
                    }
                    .padding(.vertical, 5)
                }
                .opacity(showingRightAnswers ? 1 : 0)
            }
            .navigationBarTitle(mistake.subject)
            .padding()
        }
    }
}

struct ReviseItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReviseItemView(mistake: mistakeListExample[0])
    }
}
