//
//  TabBar.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house")
                Text("主页")
            }
            PhotographView().tabItem {
                Image(systemName: "camera")
                Text("拍照")
            }
            ReviseListView().tabItem {
                Image(systemName: "doc.text")
                Text("复习")
            }
            MistakeListView().tabItem {
                Image(systemName: "book")
                Text("错题本")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
