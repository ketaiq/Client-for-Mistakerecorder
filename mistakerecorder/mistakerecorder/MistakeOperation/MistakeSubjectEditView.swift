//
//  MistakeSubjectEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/27.
//

import SwiftUI

struct MistakeSubjectEditView: View {
    @Binding var show: Bool
    @Binding var subject: String
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("编辑学科")
                .font(.system(size: 22))
                .bold()
            
            TextField("\(subject)", text: self.$text)
                .font(.system(size: 20))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.vertical, 10)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
            
            HStack(spacing: 12) {
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("语文")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "语文"
                }
                
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("数学")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "数学"
                }
                
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("英语")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "英语"
                }
            }
            
            
            HStack(spacing: 12) {
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("物理")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "物理"
                }
                
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("化学")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "化学"
                }
                
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("生物")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "生物"
                }
            }
            
            HStack(spacing: 12) {
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("地理")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "地理"
                }
                
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("历史")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "历史"
                }
                
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    Text("政治")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                .cornerRadius(20)
                .onTapGesture {
                    self.text = "政治"
                }
            }
            
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
                    subject = self.text
                    self.show = false
                }, label: {
                    Text("保存")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 40)
                        .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                })
            }
        }
        .padding()
        .frame(width: 300, height: 400)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.3 : 0))
        .animation(.linear(duration: 0.5))
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct MistakeSubjectEditView_Previews: PreviewProvider {
    @State static var show = true
    @State static var subject = "语文"
    
    static var previews: some View {
        MistakeSubjectEditView(show: $show, subject: $subject)
    }
}
