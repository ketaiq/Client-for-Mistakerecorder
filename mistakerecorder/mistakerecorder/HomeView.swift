//
//  HomeView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct HomeView: View {
    @ObservedObject var revisingMistakeStore: RevisingMistakeStore
    @State private var showingUserMenuView = false
    @State private var userMenuViewDragPosition = CGSize.zero
    @State private var fullScreenActive = false
    @State private var activeIndex = -1
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleView(showingUserMenuView: $showingUserMenuView,
                                  fullScreenActive: $fullScreenActive)
                        ForEach(revisingMistakeStore.list.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                RevisingMistakeCardView(
                                    revisingMistake: revisingMistakeStore.list[index],
                                    fullScreenActive: $fullScreenActive,
                                    index: index,
                                    activeIndex: $activeIndex)
                                    .offset(y: revisingMistakeStore.list[index].occupyFullScreen ? -geometry.frame(in: .global).minY : 0)
                                    .opacity(self.activeIndex != index && self.fullScreenActive ? 0 : 1)
                                    .scaleEffect(self.activeIndex != index && self.fullScreenActive ? 0.5 : 1)
                                    .offset(x: self.activeIndex != index && self.fullScreenActive ? screen.width : 0)
                            }
                            .frame(height: 250)
                            .frame(maxWidth: revisingMistakeStore.list[index].occupyFullScreen ? .infinity : 320)
                            .zIndex(revisingMistakeStore.list[index].occupyFullScreen ? 1 : 0)
                        }
                        .padding()
                    }
                    .frame(width: screen.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
            })
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: showingUserMenuView ? 30 : 0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
            .offset(y: showingUserMenuView ? -370 : 0)
            .offset(y: userMenuViewDragPosition.height)
            .rotation3DEffect(
                Angle(degrees: showingUserMenuView ? Double(userMenuViewDragPosition.height / 10) - 10 : 0),
                axis: (x: 1.0, y: 0.0, z: 0.0))
            .scaleEffect(showingUserMenuView ? 0.75 : 1)
            .statusBar(hidden: fullScreenActive ? true : false)
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(revisingMistakeStore: RevisingMistakeStore())
    }
}

struct TitleView: View {
    @Binding var showingUserMenuView: Bool
    @Binding var fullScreenActive: Bool
    
    var body: some View {
        HStack {
            Text("今日待复习错题")
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .blur(radius: fullScreenActive ? 20 : 0)
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
        .padding(.horizontal)
        .padding(.top, 44)
    }
}
