//
//  TabBar.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

struct TabBar: View {
    @StateObject var mistakeStore = MistakeStore()
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
            MistakeListView(mistakeStore: mistakeStore).tabItem {
                Image(systemName: (selected == 3 ? "book.fill" : "book"))
                Text("错题本")
            }
            .tag(3)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
