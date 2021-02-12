//
//  MistakeCollectionView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct MistakeListView: View {
    @Binding var mistakeList: [Mistake]
    @State private var isEditing = false
    @State private var addButtonPressed = false
    
    func addMistake() {
        let mistake = Mistake(
            _id: "",
            subject: "学科",
            category: "题目类型",
            questionDescription: "题干描述。",
            questionItems: [
                QuestionItem(
                    _id: "",
                    question: "题目项1题目",
                    rightAnswer: "题目项1答案"),
                QuestionItem(
                    _id: "",
                    question: "题目项2题目",
                    rightAnswer: "题目项2答案"),
                QuestionItem(
                    _id: "",
                    question: "题目项3题目",
                    rightAnswer: "题目项3答案"),
                QuestionItem(
                    _id: "",
                    question: "题目项4题目",
                    rightAnswer: "题目项4答案")])
        mistakeList.append(mistake)
        NetworkAPIFunctions.functions.createMistake(mistake: mistake)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mistakeList) { mistake in
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
                    NetworkAPIFunctions.functions.deleteMistake(mistake: mistakeList[indexSet.first!])
                    mistakeList.remove(at: indexSet.first!)
                })
            }
            .environment(
                \.editMode,
                .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .onAppear(perform: {
                self.isEditing.toggle() // 强制刷新List中的数据
                self.isEditing.toggle()
            })
            .navigationTitle(Text("错题本"))
            .navigationBarItems(
                leading: ZStack {
                    Button(action: {
                        addMistake()
                        self.addButtonPressed.toggle()
                    }, label: {
                        Text("添加")
                    })
                    NavigationLink(
                        destination: MistakeItemView(mistake: mistakeList[mistakeList.count - 1]),
                        isActive: self.$addButtonPressed) {
                        EmptyView()
                    }
                },
                trailing: HStack {
                    Button(action: {
                        self.isEditing.toggle()
                    }, label: {
                        Text(self.isEditing ? "完成" : "编辑")
                    })
                    Button(action: {
                        
                        
                    }, label: {
                        Text("同步")
                    })
                }
            )
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
    }
}

struct MistakeListView_Previews: PreviewProvider {
    @State static var mistakeList = [mistakeExample1, mistakeExample2, mistakeExample3, mistakeExample4]
    static var previews: some View {
        MistakeListView(mistakeList: $mistakeList)
    }
}
