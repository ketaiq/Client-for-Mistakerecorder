//
//  TabBar.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

struct TabBar: View {
    @ObservedObject var user: User
    @StateObject var revisingMistakeStore = RevisingMistakeStore()
    @State private var selected = 0
    var body: some View {
        TabView(selection: $selected) {
            HomeView(revisingMistakeStore: revisingMistakeStore).tabItem {
                Image(systemName: (selected == 0 ? "house.fill" : "house"))
                Text("主页")
            }
            .tag(0)
            PhotographView().tabItem {
                Image(systemName: (selected == 1 ? "camera.fill" : "camera"))
                Text("拍照")
            }
            .tag(1)
            ReviseListView(revisingMistakeStore: revisingMistakeStore).tabItem {
                Image(systemName: (selected == 2 ? "doc.text.fill" : "doc.text"))
                Text("复习")
            }
            .tag(2)
            MistakeListView(mistakeList: $user.mistakeList).tabItem {
                Image(systemName: (selected == 3 ? "book.fill" : "book"))
                Text("错题本")
            }
            .tag(3)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    @StateObject static var user = User(_id: "", username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")
    static var previews: some View {
        TabBar(user: user)
    }
}
