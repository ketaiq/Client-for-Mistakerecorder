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
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.PinYinXieCi.toString())
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.ChengYuYiSi.toString())
                }
                HStack(spacing: 12) {
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.JinYiCi.toString())
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.FanYiCi.toString())
                }
                HStack(spacing: 12) {
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.MoXieGuShi.toString())
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.ZuCi.toString())
                }
                HStack(spacing: 12) {
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.DuoYinZi.toString())
                    MistakeEditSelectionSubview(text: self.$text, content: MistakeCategory.XiuGaiBingJu.toString())
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
                        
                        if self.text == MistakeCategory.PinYinXieCi.toString() {
                            questionDescription = MistakeCategory.PinYinXieCi.generateDescription()
                        } else if self.text == MistakeCategory.ChengYuYiSi.toString() {
                            questionDescription = MistakeCategory.ChengYuYiSi.generateDescription()
                        } else if self.text == MistakeCategory.JinYiCi.toString() {
                            questionDescription = MistakeCategory.JinYiCi.generateDescription()
                        } else if self.text == MistakeCategory.FanYiCi.toString() {
                            questionDescription = MistakeCategory.FanYiCi.generateDescription()
                        } else if self.text == MistakeCategory.MoXieGuShi.toString() {
                            questionDescription = MistakeCategory.MoXieGuShi.generateDescription()
                        } else if self.text == MistakeCategory.ZuCi.toString() {
                            questionDescription = MistakeCategory.ZuCi.generateDescription()
                        } else if self.text == MistakeCategory.DuoYinZi.toString() {
                            questionDescription = MistakeCategory.DuoYinZi.generateDescription()
                        } else if self.text == MistakeCategory.XiuGaiBingJu.toString() {
                            questionDescription = MistakeCategory.XiuGaiBingJu.generateDescription()
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
