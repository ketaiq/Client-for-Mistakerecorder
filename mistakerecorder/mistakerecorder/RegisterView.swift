//
//  RegisterView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/22.
//

import SwiftUI

struct RegisterView: View {
    
    @State var nickname = ""
    @State var realname = ""
    @State var id = ""
    @State var emailaddress = ""
    @State var password = ""
    @State var repeatPassword = ""
    @State var nicknameWarningOpacity: Double = 0
    @State var realnameWarningOpacity: Double = 0
    @State var idWarningOpacity: Double = 0
    @State var emailaddressWarningOpacity: Double = 0
    @State var passwordWarningOpacity: Double = 0
    @State var repeatPasswordWarningOpacity: Double = 0
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                
                RegisterTextField(textType: "昵称", textContent: $nickname, textWarningOpacity: $nicknameWarningOpacity, formatRequirement: "可由1到32个汉字、大小写字母和数字组成")
                RegisterTextField(textType: "真实姓名", textContent: $realname, textWarningOpacity: $realnameWarningOpacity, formatRequirement: "可由2到5个汉字或1到32位大小写字母组成")
                RegisterTextField(textType: "身份证号", textContent: $id, textWarningOpacity: $idWarningOpacity, formatRequirement: "第二代18位身份证号")
                RegisterTextField(textType: "邮箱", textContent: $emailaddress, textWarningOpacity: $emailaddressWarningOpacity, formatRequirement: "正常邮箱格式")
                RegisterTextField(textType: "密码", textContent: $password, textWarningOpacity: $passwordWarningOpacity, formatRequirement: "至少一个字母和一个数字，至少8位密码，最多32位")
                RegisterTextField(textType: "再次输入密码", textContent: $repeatPassword, textWarningOpacity: $repeatPasswordWarningOpacity, formatRequirement: "与上述密码一致")
                
                Rectangle()
                    .opacity(0)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    if password != repeatPassword {
                        showAlert = true
                    }
                }, label: {
                    Text("确认")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(13)
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("警告"),
                          message: Text("再次输入的密码与设置的密码不一致！"),
                          dismissButton: .default(Text("确认")))
                })
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 252 / 255, green: 230 / 255, blue: 201 / 255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
