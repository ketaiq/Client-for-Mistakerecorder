//
//  MistakeCollectionView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct MistakeListView: View {
    @ObservedObject var store = MistakeStore()
    
    func addMistake() {
        store.mistakeList.append(
            Mistake(
                subject: "语文",
                category: "反义词",
                questionDescription: "写出下列词语的反义词。",
                questionItems: [
                    QuestionItem(question: "认真", rightAnswer: "马虎"),
                    QuestionItem(question: "长", rightAnswer: "短"),
                    QuestionItem(question: "高兴", rightAnswer: "难过"),
                    QuestionItem(question: "早", rightAnswer: "晚")]))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.mistakeList) { mistake in
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
                    self.store.mistakeList.remove(at: indexSet.first!)
                })
                .onMove(perform: { (source: IndexSet, destination: Int) in
                    self.store.mistakeList.move(fromOffsets: source, toOffset: destination)
                })
            }
            .navigationTitle(Text("错题本"))
            .navigationBarItems(
                leading: Button(action: addMistake) {
                    Text("添加")
                },
                trailing: Button(action: {}, label: {
                    ZStack {
                        Text("编辑")
                        EditButton().opacity(0.08)
                    }
                })
            )
        }
    }
}

struct MistakeListView_Previews: PreviewProvider {
    static var previews: some View {
        MistakeListView()
    }
}

struct Mistake: Identifiable { // 错题
    var id = UUID() // 自动生成的ID
    var subject: String // 错题所属学科：语文、数学、英语等
    var category: String // 错题类型：近义词、反义词等
    var questionDescription: String // 题干描述："写出下列词语的反义词。"
    var questionItems: [QuestionItem] // 题目项数组
}

struct QuestionItem: Identifiable { // 题目项
    var id = UUID() // 自动生成的ID
    var question: String // 题目
    var rightAnswer: String // 正确答案
}
