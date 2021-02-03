//
//  RevisingMistakeCardView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/26.
//

import SwiftUI

struct RevisingMistakeCardView: View {
    @State var answerText: String = "请在这里填写答案"
    @ObservedObject var revisingMistake: RevisingMistake
    @Binding var fullScreenActive: Bool
    var index: Int
    @Binding var activeIndex: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                TextEditor(text: $answerText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical)
                HStack {
                    Button(action: {
                        answerText = ""
                    }, label: {
                        Text("清空")
                            .font(.headline)
                            .font(.system(size: 16))
                    })
                    .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("确认")
                            .font(.headline)
                            .font(.system(size: 16))
                    })
                    .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                Rectangle().foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: revisingMistake.occupyFullScreen ? .infinity : 200,
                   maxHeight: revisingMistake.occupyFullScreen ? .infinity : 200)
            .offset(y: revisingMistake.occupyFullScreen ? 300: 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
            .opacity(revisingMistake.occupyFullScreen ? 1 : 0)
            
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(revisingMistake.mistake.subject)
                        .font(.title)
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .opacity(revisingMistake.occupyFullScreen ? 1 : 0)
                }
                .padding(.top)
                Text(revisingMistake.mistake.questionDescription)
                    .font(.headline)
                VStack(spacing: 10) {
                    ForEach(revisingMistake.mistake.questionItems) { item in
                        HStack {
                            Text(item.question)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .frame(
                width: revisingMistake.occupyFullScreen ? .infinity : 320,
                height: revisingMistake.occupyFullScreen ? 300 : 250)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color.green.opacity(0.8), radius: 20, x: 0, y: 20)
            .onTapGesture {
                revisingMistake.occupyFullScreen.toggle()
                fullScreenActive.toggle()
                if revisingMistake.occupyFullScreen {
                    activeIndex = index
                } else {
                    activeIndex = -1
                }
            }
        }
        .frame(height: revisingMistake.occupyFullScreen ? screen.height - 70 : 250)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}
