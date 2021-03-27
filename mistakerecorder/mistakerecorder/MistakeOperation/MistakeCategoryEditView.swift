//
//  MistakeCategoryEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/27.
//

import SwiftUI

struct MistakeCategoryEditView: View {
    @Binding var show: Bool
    @Binding var category: String
    @Binding var questionDescription: String
    @State private var text = ""
    @State private var emptyAlert = false
    
    var body: some View {
        VStack {
            Text("编辑题型")
                .font(.system(size: 22))
                .bold()
                .padding(.top)
            
            TextField("\(category)", text: self.$text)
                .font(.system(size: 20))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.vertical, 10)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 12) {
                    MistakeEditSelectionSubview(text: self.$text, content: "拼音写词")
                    MistakeEditSelectionSubview(text: self.$text, content: "成语意思")
                }
                HStack(spacing: 12) {
                    MistakeEditSelectionSubview(text: self.$text, content: "近义词")
                    MistakeEditSelectionSubview(text: self.$text, content: "反义词")
                }
                HStack(spacing: 12) {
                    MistakeEditSelectionSubview(text: self.$text, content: "默写古诗")
                    MistakeEditSelectionSubview(text: self.$text, content: "组词")
                }
                HStack(spacing: 12) {
                    MistakeEditSelectionSubview(text: self.$text, content: "多音字")
                    MistakeEditSelectionSubview(text: self.$text, content: "修改病句")
                }
            }
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    show = false
                }, label: {
                    Text("取消")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 40)
                        .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                })
                Button(action: {
                    if self.text == "" {
                        self.emptyAlert = true
                    } else {
                        category = self.text
                        
                        if self.text == "拼音写词" {
                            questionDescription = "认真拼读音节，写出下列词语。"
                        } else if self.text == "成语意思" {
                            questionDescription = "根据意思写成语。"
                        } else if self.text == "近义词" {
                            questionDescription = "请写出下列词语的近义词。"
                        } else if self.text == "反义词" {
                            questionDescription = "请写出下列词语的反义词。"
                        } else if self.text == "默写古诗" {
                            questionDescription = "默写所学的古诗。"
                        } else if self.text == "组词" {
                            questionDescription = "比较字形，然后组词。"
                        } else if self.text == "多音字" {
                            questionDescription = "给带点字选择正确的读音。"
                        } else if self.text == "修改病句" {
                            questionDescription = "修改下列病句。"
                        }
                        
                        self.show = false
                    }
                }, label: {
                    Text("保存")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 40)
                        .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                })
                .alert(isPresented: self.$emptyAlert) {
                    return Alert(title: Text("警告"),
                                 message: Text("题型不能为空！"),
                                 dismissButton: .default(Text("确认"))
                    )
                }
            }
            
        }
        .padding()
        .frame(width: 300, height: 420)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.3 : 0))
        .opacity(show ? 1 : 0)
        .animation(.linear(duration: 0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MistakeCategoryEditView_Previews: PreviewProvider {
    @State static var show = true
    @State static var category = "近义词"
    @State static var questionDescription = "请写出下列词语的近义词。"
    
    static var previews: some View {
        MistakeCategoryEditView(show: $show, category: $category, questionDescription: $questionDescription)
    }
}
