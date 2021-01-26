//
//  HomeView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

struct HomeView: View {
    @State var unfoldMistakeCards = false
    @State var dragPosition = CGSize.zero
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                TitleView()
                    .blur(radius: unfoldMistakeCards ? 20 : 0)
                    .animation(.default)
                Spacer()
                ZStack {
                    BackMistakeCardView()
                        .offset(x: 0, y: unfoldMistakeCards ? -250 : -40)
                        .offset(x: dragPosition.width, y: dragPosition.height)
                        .scaleEffect(unfoldMistakeCards ? 0.6 : 0.9)
                        .rotationEffect(.degrees(unfoldMistakeCards ? 0 : 10))
                        .animation(.easeInOut(duration: 0.5))
                    BackMistakeCardView()
                        .offset(x: 0, y: unfoldMistakeCards ? -100 : -20)
                        .offset(x: dragPosition.width, y: dragPosition.height)
                        .scaleEffect(unfoldMistakeCards ? 0.8 : 0.95)
                        .rotationEffect(.degrees(unfoldMistakeCards ? 0 : 5))
                        .animation(.easeInOut(duration: 0.3))
                    MistakeCardView(unfoldMistakeCards: $unfoldMistakeCards, dragPosition: $dragPosition)
                        .offset(x: dragPosition.width, y: dragPosition.height)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                    
                }
                
                Spacer()
                HomeNavigationBar()
                    .blur(radius: unfoldMistakeCards ? 20 : 0)
                    .animation(.default)
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TitleView: View {
    var body: some View {
        HStack {
            Text("待复习错题")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
        }
    }
}
