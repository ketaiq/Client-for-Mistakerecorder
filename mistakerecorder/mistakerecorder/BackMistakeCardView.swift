//
//  BackMistakeCardView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/26.
//

import SwiftUI

struct BackMistakeCardView: View {
    var mistake: Mistake
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.green)
                .cornerRadius(15)
                .shadow(radius: 20)
            VStack(alignment: .leading) {
                HStack {
                    Text(mistake.subject)
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom)
                Text(mistake.questionDescription)
                    .font(.headline)
                VStack {
                    ForEach(mistake.questionItems) { item in
                        HStack {
                            Text(item.question)
                            Spacer()
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
        .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct BackMistakeCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackMistakeCardView(mistake: mistake)
    }
}
