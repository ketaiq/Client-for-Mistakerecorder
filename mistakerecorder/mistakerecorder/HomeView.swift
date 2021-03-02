//
//  HomeView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct HomeView: View {
    @ObservedObject var user: User
    @State private var showingUserMenuView = false
    @State private var userMenuViewDragPosition = CGSize.zero
    @State private var fullScreenActive = false
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleSubview(user: user, showingUserMenuView: self.$showingUserMenuView,
                                     fullScreenActive: self.$fullScreenActive)
                        CardsSubview(user: user, fullScreenActive: self.$fullScreenActive)
                    }
                    .frame(width: screen.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
            })
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: self.showingUserMenuView ? 30 : 0, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 20)
            .offset(y: self.showingUserMenuView ? -430 : 0)
            .offset(y: self.userMenuViewDragPosition.height)
            .rotation3DEffect(
                Angle(degrees: self.showingUserMenuView ? Double(self.userMenuViewDragPosition.height / 10) - 10 : 0),
                axis: (x: 1.0, y: 0.0, z: 0.0))
            .scaleEffect(self.showingUserMenuView ? 0.75 : 1)
            .statusBar(hidden: self.fullScreenActive ? true : false)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
            
            UserMenuView(user: user)
                .background(Color.black.opacity(0.001))
                .offset(y: self.showingUserMenuView ? 0 : screen.height)
                .offset(y: self.userMenuViewDragPosition.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.userMenuViewDragPosition = value.translation
                        }
                        .onEnded { value in
                            if self.userMenuViewDragPosition.height > 50 {
                                self.showingUserMenuView = false
                            }
                            self.userMenuViewDragPosition = .zero
                        }
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!.pngData()!)
    static var previews: some View {
        HomeView(user: user)
    }
}

struct TitleSubview: View {
    @ObservedObject var user: User
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
                Image(uiImage: UIImage(data: user.avatar)!)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            })
        }
        .padding(.horizontal)
        .padding(.top, 44)
    }
}

struct CardsSubview: View {
    @ObservedObject var user: User
    @Binding var fullScreenActive: Bool
    @State private var activeIndex = -1
    
    var body: some View {
        ForEach(user.mistakeList.indices, id: \.self) { index in
            let mistake = user.mistakeList[index]
            let current = DateFunctions.functions.currentDate()
            
            if DateFunctions.functions.greaterEqualThan(date1Str: current, date2Str: mistake.nextRevisionDate) {
                GeometryReader { geometry in
                    RevisingMistakeCardView(
                        mistake: mistake,
                        fullScreenActive: $fullScreenActive,
                        index: index,
                        activeIndex: $activeIndex)
                        .offset(y: mistake.isRevising ? -geometry.frame(in: .global).minY : 0)
                        .opacity(self.activeIndex != index && self.fullScreenActive ? 0 : 1)
                        .scaleEffect(self.activeIndex != index && self.fullScreenActive ? 0.5 : 1)
                        .offset(x: self.activeIndex != index && self.fullScreenActive ? screen.width : 0)
                }
                .frame(height: 250)
                .frame(maxWidth: mistake.isRevising ? .infinity : 320)
                .zIndex(mistake.isRevising ? 1 : 0)
            }
        }
        .padding()
    }
}
