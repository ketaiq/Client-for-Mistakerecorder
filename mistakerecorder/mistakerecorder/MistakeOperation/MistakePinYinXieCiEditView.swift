//
//  MistakePinYinXieCiEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/28.
//

import SwiftUI

struct MistakePinYinXieCiEditView: View {
    @ObservedObject var mistake: Mistake
    @Binding var editStatus: Bool
    @State private var text = ""
    @StateObject private var pin_yin_xie_ci_collection = PinYinXieCiCollection()
    @State private var committed = false
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    func save() {
        if self.pin_yin_xie_ci_collection.objects.count > 0 {
            mistake.questionItems.append(
                QuestionItem(question: self.pin_yin_xie_ci_collection.objects.last!.getQuestion(),
                             rightAnswer: self.pin_yin_xie_ci_collection.objects.last!.getRightAnswer())
            )
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("编辑\(MistakeCategory.PinYinXieCi.toString())的题目和答案")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {
                    self.editStatus = false
                }, label: {
                    Text("完成")
                        .bold()
                        .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                        .padding(.horizontal, 20)
                        .padding(10)
                        .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                        .cornerRadius(10)
                        .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                        .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                })
            }
            .padding(.horizontal)
            .padding(.top)
            
            ZStack {
                TextField("请在此输入一个词语...", text: self.$text, onCommit: {
                    self.pin_yin_xie_ci_collection.objects.append(PinYinXieCi(self.text))
                    self.committed = true
                })
                .font(.system(size: 20))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .foregroundColor(Color.black)
                .background(Color.orange)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0.0, y: 5.0)
                .padding()
                .scaleEffect(self.committed ? 0.5 : 1)
                .opacity(self.committed ? 0 : 1)
                .animation(.easeInOut)
                
                VStack {
                    HStack {
                        Text("点击圆圈标记要转换为拼音的字：")
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            if self.pin_yin_xie_ci_collection.objects.count > 0 {
                                ForEach(self.pin_yin_xie_ci_collection.objects.last!.items.indices, id: \.self) { index in
                                    PinYinXieCiSelectionSubview(item: self.pin_yin_xie_ci_collection.objects.last!.items[index])
                                }
                            } else {
                                Text("<空>")
                            }
                            
                        }
                    }
                    Button(action: {
                        self.save()
                        self.text = ""
                        self.committed = false
                    }, label: {
                        Text("保存")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 40)
                            .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    })
                }
                .padding()
                .scaleEffect(self.committed ? 1 : 0.5)
                .opacity(self.committed ? 1 : 0)
                .animation(.easeInOut)
            }
            
            LazyVGrid(columns: columns) {
                Text("题目")
                    .font(.system(size: 20))
                    .bold()
                Text("答案")
                    .font(.system(size: 20))
                    .bold()
            }
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.pin_yin_xie_ci_collection.objects.indices, id: \.self) { objectIndex in
                        let object = self.pin_yin_xie_ci_collection.objects[objectIndex]
                        HStack(spacing: 0) {
                            ForEach(object.items.indices, id: \.self) { itemIndex in
                                let item = object.items[itemIndex]
                                if item.selected {
                                    VStack {
                                        Text(item.pin_yin)
                                        Text("(     )").font(.system(size: 20))
                                    }
                                } else {
                                    VStack {
                                        Text(item.pin_yin).hidden()
                                        Text(item.word).font(.system(size: 20))
                                    }
                                }
                            }
                        }
                        HStack(spacing: 0) {
                            ForEach(object.items.indices, id: \.self) { itemIndex in
                                let item = object.items[itemIndex]
                                VStack {
                                    Text(item.pin_yin).hidden()
                                    Text(item.word).font(.system(size: 20))
                                }
                            }
                        }
                    }
                }
            }
            
            
            Spacer()
        }
    }
}

struct MistakePinYinXieCiEditView_Previews: PreviewProvider {
    @StateObject static var mistake = Mistake(subject: "语文", category: "错题类型一", questionDescription: "题干描述一", questionItems: [QuestionItem(question: "高兴*", rightAnswer: "兴"), QuestionItem(question: "题目二", rightAnswer: "答案二"), QuestionItem(question: "题目三", rightAnswer: "答案三")])
    @State static var editStatus = false

    static var previews: some View {
        MistakePinYinXieCiEditView(mistake: mistake, editStatus: $editStatus)
    }
}

struct PinYinXieCiSelectionSubview: View {
    @ObservedObject var item: PinYinXieCiItem
    
    var body: some View {
        VStack {
            Text(item.selected ? item.pin_yin : item.word)
                .font(.system(size: 20))
                .frame(height: 30)
            Image(systemName: item.selected ? "circle.fill" : "circle")
                .font(.system(size: 25))
                .foregroundColor(item.selected ? .green : .gray)
                .onTapGesture {
                    item.selected.toggle()
                }
        }
    }
}
