//
//  ReviseView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct ReviseListView: View {
    @ObservedObject var revisingMistakeStore: RevisingMistakeStore
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(revisingMistakeStore.list) { revisingMistake in
                    NavigationLink(destination: ReviseItemView(mistake: revisingMistake.mistake)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(revisingMistake.mistake.subject)
                                .font(.system(size: 25, weight: .bold))
                            Text(revisingMistake.mistake.questionDescription)
                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 16))
                            Text(revisingMistake.mistake.category)
                                .font(.system(size: 16))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        .padding(.vertical)
                    }
                }
                .onDelete(perform: { indexSet in
                    self.revisingMistakeStore.list.remove(at: indexSet.first!)
                })
                .onMove(perform: { (source: IndexSet, destination: Int) in
                    self.revisingMistakeStore.list.move(fromOffsets: source, toOffset: destination)
                })
            }
            .environment(
                \.editMode,
                .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .navigationTitle(Text("所有待复习错题"))
            .navigationBarItems(
                trailing: Button(action: {
                    self.isEditing.toggle()
                }, label: {
                    Text(self.isEditing ? "完成" : "编辑")
                }))
        }
    }
}

struct ReviseListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviseListView(revisingMistakeStore: RevisingMistakeStore())
    }
}
