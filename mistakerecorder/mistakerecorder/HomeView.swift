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
    @State var showingUserMenuView = false
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                    TitleView(showingUserMenuView: $showingUserMenuView)
                        .foregroundColor(.black)
                        .blur(radius: unfoldMistakeCards ? 20 : 0)
                        .animation(.default)
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
                    .offset(y: 100)
                    Spacer()
                    HomeNavigationBar()
                        .blur(radius: unfoldMistakeCards ? 20 : 0)
                        .animation(.default)
                        .padding(.bottom)
                    
                })
                .padding(.top, 44)
                .padding(.horizontal)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: showingUserMenuView ? 30 : 0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
                .offset(y: showingUserMenuView ? -370 : 0)
                .rotation3DEffect(
                    Angle(degrees: showingUserMenuView ? -20 : 0),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .scaleEffect(showingUserMenuView ? 0.8 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                UserMenuView()
                    .offset(y: showingUserMenuView ? 0 : 600)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
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
    @Binding var showingUserMenuView: Bool
    var body: some View {
        HStack {
            Text("待复习错题")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Button(action: {
                showingUserMenuView.toggle()
            }, label: {
                Image("ac84bcb7d0a20cf4800d77cc74094b36acaf990f")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            })
        }
    }
}
