//
//  MistakeCardView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/26.
//

import SwiftUI

struct MistakeCardView: View {
    var mistake: Mistake
    @Binding var unfoldMistakeCards: Bool
    @Binding var dragPosition: CGSize
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.green)
                .cornerRadius(15)
                .shadow(radius: 20)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 40, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(3.0)
                        .opacity(0.2)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragPosition = value.translation
                                    unfoldMistakeCards = true
                                }
                                .onEnded { value in
                                    dragPosition = CGSize.zero
                                    unfoldMistakeCards = false
                                }
                        )
                    Spacer()
                }
                HStack {
                    Text(mistake.subject)
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom)
                Text(mistake.questionDescription)
                    .font(.headline)
                Spacer()
                
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
