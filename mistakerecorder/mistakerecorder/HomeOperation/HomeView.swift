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
    
    @State private var showUserMenuView = false
    @State private var userMenuViewDragPosition = CGSize.zero
    @State private var showReviseAnswerView = false
    @State private var mistakeIndex = 0
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView(showsIndicators: false) {
                    TitleSubview(user: user, showingUserMenuView: self.$showUserMenuView)
                    CardsSubview(user: user, showReviseAnswerView: self.$showReviseAnswerView, mistakeIndex: self.$mistakeIndex)
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: self.showUserMenuView ? 30 : 0, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 20)
            .offset(y: self.showUserMenuView ? -430 : 0)
            .offset(y: self.userMenuViewDragPosition.height)
            .rotation3DEffect(
                Angle(degrees: self.showUserMenuView ? Double(self.userMenuViewDragPosition.height / 10) - 10 : 0),
                axis: (x: 1.0, y: 0.0, z: 0.0))
            .scaleEffect(self.showUserMenuView ? 0.75 : 1)
            .edgesIgnoringSafeArea(.all)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
            UserMenuView(user: user)
                .background(Color.black.opacity(0.001))
                .offset(y: self.showUserMenuView ? 0 : screen.height)
                .offset(y: self.userMenuViewDragPosition.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.userMenuViewDragPosition = value.translation
                        }
                        .onEnded { value in
                            if self.userMenuViewDragPosition.height > 50 {
                                self.showUserMenuView = false
                            }
                            self.userMenuViewDragPosition = .zero
                        }
                )
            
            ReviseAnswerView(mistake: self.user.mistakeList[self.mistakeIndex], answers: ObservableStringArray(self.user.mistakeList[self.mistakeIndex].questionItems.count), showReviseAnswerView: self.$showReviseAnswerView)
                .opacity(self.showReviseAnswerView ? 1 : 0)
                .scaleEffect(self.showReviseAnswerView ? 1 : 0.5)
                .animation(.easeInOut)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(systemName: "person.circle")!.pngData()!.base64EncodedString())
    static var previews: some View {
        HomeView(user: user)
    }
}

struct TitleSubview: View {
    @ObservedObject var user: User
    @Binding var showingUserMenuView: Bool
    
    var body: some View {
        HStack {
            Text("今日待复习错题")
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                showingUserMenuView.toggle()
            }, label: {
                Image(uiImage: UIImage(data: Data(base64Encoded: user.avatar)!)!)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            })
        }
        .padding(.horizontal)
        .padding(.top, 44)
    }
}

struct CardsSubview: View {
    @ObservedObject var user: User
    @Binding var showReviseAnswerView: Bool
    @Binding var mistakeIndex: Int
    
    var body: some View {
        ForEach(user.mistakeList.indices, id: \.self) { index in
            let mistake = user.mistakeList[index]
            let current = DateFunctions.functions.currentDate()
            
            if DateFunctions.functions.greaterEqualThan(date1Str: current, date2Str: mistake.nextRevisionDate) {
                ReviseCardView(mistake: mistake)
                    .padding()
                    .onTapGesture {
                        self.mistakeIndex = index
                        self.showReviseAnswerView = true
                    }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
