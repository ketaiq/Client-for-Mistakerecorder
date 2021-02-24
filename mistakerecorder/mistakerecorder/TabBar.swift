//
//  TabBar.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var loginStatus: LoginStatus
    @StateObject private var user = User(username: "", nickname: "", realname: "", idcard: "", emailaddress: "", password: "", avatar: "")
    @State private var selected = 0
    
    var body: some View {
        ZStack {
            if !loginStatus.showTabView {
                LoginView(user: self.user)
            } else {
                TabView(selection: self.$selected) {
                    HomeView(user: user).tabItem {
                        Image(systemName: (self.selected == 0 ? "house.fill" : "house"))
                        Text("主页")
                    }
                    .tag(0)
                    PhotographView().tabItem {
                        Image(systemName: (self.selected == 1 ? "camera.fill" : "camera"))
                        Text("拍照")
                    }
                    .tag(1)
                    MistakeListView(user: self.user).tabItem {
                        Image(systemName: (self.selected == 3 ? "book.fill" : "book"))
                        Text("错题本")
                    }
                    .tag(2)
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBar().environmentObject(LoginStatus())
    }
}
