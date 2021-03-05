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
    @State private var generatePaperButtonPressed = false
    
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
                    HStack {
                        NavigationLink(destination: MistakeItemView(user: user, mistake: mistake)) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(mistake.subject)
                                    .font(.system(size: 25, weight: .bold))
                                Text(mistake.questionDescription)
                                    .lineLimit(2)
                                    .font(.system(size: 16))
                                Text(mistake.category)
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(5)
                            }
                            .padding(.vertical)
                        }
                        
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
            .navigationBarItems(leading:
                ZStack {
                    Button(action: {
                        addMistake()
                        self.addButtonPressed.toggle()
                    }, label: {
                        Text("添加")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 30)
                            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    })
                    NavigationLink(
                        destination: MistakeItemView(user: user, mistake: user.mistakeList[user.mistakeList.count - 1]),
                        isActive: self.$addButtonPressed) {
                        EmptyView()
                    }
                }, trailing:
                HStack(spacing: 20) {
                    Button(action: {
                        self.generatePaperButtonPressed = true
                    }, label: {
                        Text("组卷")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 30)
                            .background(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    })
                    .sheet(isPresented: self.$generatePaperButtonPressed) {
                        GeneratePaperView(user: user)
                    }
                    Divider()
                    Button(action: {
                        self.isEditing.toggle()
                    }, label: {
                        Text(self.isEditing ? "完成" : "编辑")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 30)
                            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    })
                }
            )
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
    }
}

struct MistakeListView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: "")
    static var previews: some View {
        MistakeListView(user: user)
    }
}
