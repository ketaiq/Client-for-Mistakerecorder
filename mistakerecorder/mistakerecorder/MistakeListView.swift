//
//  MistakeCollectionView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct MistakeListView: View {
    @ObservedObject var mistakeStore: MistakeStore
    @State private var isEditing = false
    
    func addMistake() {
        mistakeStore.list.append(
            Mistake(
                subject: "学科",
                category: "题目类型",
                questionDescription: "题干描述。",
                questionItems: [
                    QuestionItem(question: "题目项1题目", rightAnswer: "题目项1答案"),
                    QuestionItem(question: "题目项2题目", rightAnswer: "题目项2答案"),
                    QuestionItem(question: "题目项3题目", rightAnswer: "题目项3答案"),
                    QuestionItem(question: "题目项4题目", rightAnswer: "题目项4答案")]))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mistakeStore.list) { mistake in
                    NavigationLink(destination: MistakeItemView(mistake: mistake)) {
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
                .onDelete(perform: { indexSet in
                    self.mistakeStore.list.remove(at: indexSet.first!)
                })
                .onMove(perform: { (source: IndexSet, destination: Int) in
                    self.mistakeStore.list.move(fromOffsets: source, toOffset: destination)
                })
            }
            .environment(
                \.editMode,
                .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .navigationTitle(Text("错题本"))
            .navigationBarItems(
                leading: Button(action: addMistake) {
                    Text("添加")
                },
                trailing: Button(action: {
                    self.isEditing.toggle()
                }, label: {
                    Text(self.isEditing ? "完成" : "编辑")
                }))
            
        }
    }
}

struct MistakeListView_Previews: PreviewProvider {
    static var previews: some View {
        MistakeListView(mistakeStore: MistakeStore())
    }
}
