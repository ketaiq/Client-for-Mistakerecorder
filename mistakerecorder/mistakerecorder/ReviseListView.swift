//
//  ReviseView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct ReviseListView: View {
    
    @ObservedObject var store = MistakeStore()
    
    var body: some View {
        NavigationView {
            List(store.mistakeList) { mistake in
                NavigationLink(destination: ReviseItemView(mistake: mistake)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(mistake.subject)
                            .font(.system(size: 25, weight: .bold))
                        Text(mistake.questionDescription)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 16))
                        Text(mistake.category)
                            .font(.system(size: 16))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle(Text("所有待复习错题"))
        }
    }
}

struct ReviseListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviseListView()
    }
}
