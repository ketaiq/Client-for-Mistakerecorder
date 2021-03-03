//
//  MistakeCollectionView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct MistakeListView: View {
    @ObservedObject var user: User
    @State private var isEditing = false
    @State private var addButtonPressed = false
    
    func addMistake() {
        let mistake = Mistake(
            subject: "学科",
            category: "题目类型",
            questionDescription: "题干描述。",
            questionItems: [
                QuestionItem(
                    question: "题目项题目",
                    rightAnswer: "题目项答案")
            ])
        user.mistakeList.append(mistake)
        NetworkAPIFunctions.functions.updateMistakeList(user: user)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(user.mistakeList) { mistake in
                    NavigationLink(destination: MistakeItemView(user: user, mistake: mistake)) {
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
                .onMove(perform: { indices, newOffset in
                    user.mistakeList.move(fromOffsets: indices, toOffset: newOffset)
                    NetworkAPIFunctions.functions.updateMistakeList(user: user)
                })
                .onDelete(perform: { indexSet in
                    user.mistakeList.remove(at: indexSet.first!)
                    NetworkAPIFunctions.functions.updateMistakeList(user: user)
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
                        destination: MistakeItemView(user: user, mistake: user.mistakeList[user.mistakeList.count - 1]),
                        isActive: self.$addButtonPressed) {
                        EmptyView()
                    }
                },
                trailing: Button(action: {
                    self.isEditing.toggle()
                }, label: {
                    Text(self.isEditing ? "完成" : "编辑")
                })
            )
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
    }
}

struct MistakeListView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!.pngData()!.base64EncodedString())
    static var previews: some View {
        MistakeListView(user: user)
    }
}
