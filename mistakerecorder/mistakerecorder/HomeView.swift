//
//  HomeView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

let screen = UIScreen.main.bounds
var mistakeListExample = [mistakeExample, mistakeExample, mistakeExample, mistakeExample]
var mistakeExample = Mistake(
    subject: "语文",
    category: "反义词",
    questionDescription: "写出下列词语的反义词。",
    questionItems: [
        QuestionItem(question: "认真", rightAnswer: "马虎"),
        QuestionItem(question: "长", rightAnswer: "短"),
        QuestionItem(question: "高兴", rightAnswer: "难过"),
        QuestionItem(question: "早", rightAnswer: "晚")]
)

struct HomeView: View {
    @State var unfoldMistakeCards = false
    @State var mistakeCardViewDragPosition = CGSize.zero
    @State var showingUserMenuView = false
    @State var userMenuViewDragPosition = CGSize.zero
    
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
                    MistakeCardGroupView(unfoldMistakeCards: $unfoldMistakeCards, mistakeCardViewDragPosition: $mistakeCardViewDragPosition)
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
                .offset(y: userMenuViewDragPosition.height)
                .rotation3DEffect(
                    Angle(degrees: showingUserMenuView ? Double(userMenuViewDragPosition.height / 10) - 10 : 0),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .scaleEffect(showingUserMenuView ? 0.8 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                UserMenuView()
                    .background(Color.black.opacity(0.001))
                    .offset(y: showingUserMenuView ? 0 : screen.height)
                    .offset(y: userMenuViewDragPosition.height)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    .onTapGesture {
                        showingUserMenuView.toggle()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                userMenuViewDragPosition = value.translation
                            }
                            .onEnded { value in
                                if userMenuViewDragPosition.height > 50 {
                                    showingUserMenuView = false
                                }
                                userMenuViewDragPosition = .zero
                            }
                    )
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
            Text("今日待复习错题")
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

struct MistakeCardGroupView: View {
    @Binding var unfoldMistakeCards: Bool
    @Binding var mistakeCardViewDragPosition: CGSize
    var body: some View {
        ZStack {
            BackMistakeCardView(mistake: mistakeExample)
                .offset(x: 0, y: unfoldMistakeCards ? -250 : -40)
                .offset(x: mistakeCardViewDragPosition.width, y: mistakeCardViewDragPosition.height)
                .scaleEffect(unfoldMistakeCards ? 0.6 : 0.9)
                .rotationEffect(.degrees(unfoldMistakeCards ? 0 : 10))
                .animation(.easeInOut(duration: 0.5))
            BackMistakeCardView(mistake: mistakeExample)
                .offset(x: 0, y: unfoldMistakeCards ? -100 : -20)
                .offset(x: mistakeCardViewDragPosition.width, y: mistakeCardViewDragPosition.height)
                .scaleEffect(unfoldMistakeCards ? 0.8 : 0.95)
                .rotationEffect(.degrees(unfoldMistakeCards ? 0 : 5))
                .animation(.easeInOut(duration: 0.3))
            MistakeCardView(mistake: mistakeExample, unfoldMistakeCards: $unfoldMistakeCards, dragPosition: $mistakeCardViewDragPosition)
                .offset(x: mistakeCardViewDragPosition.width, y: mistakeCardViewDragPosition.height)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
            
        }
        .offset(y: 100)
    }
}
