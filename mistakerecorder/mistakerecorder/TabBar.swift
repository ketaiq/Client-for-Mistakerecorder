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
    @State private var selected = "主页"
    
    var body: some View {
        if !loginStatus.showTabView {
            LoginView(user: self.user)
        } else {
            NavigationView {
                TabView(selection: self.$selected) {
                    HomeView(user: user).tabItem {
                        Image(systemName: (self.selected == "主页" ? "house.fill" : "house"))
                        Text("主页")
                    }
                    .tag("主页")
                    MistakeListView(user: self.user).tabItem {
                        Image(systemName: (self.selected == "错题本" ? "book.fill" : "book"))
                        Text("错题本")
                    }
                    .tag("错题本")
                }
                .navigationTitle(self.selected)
                .navigationBarHidden(true)
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBar().environmentObject(LoginStatus())
    }
}
