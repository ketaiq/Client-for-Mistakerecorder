//
//  RegisterView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/22.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var user = User(_id: "", username: "", nickname: "", realname: "", idcard: "", emailaddress: "", password: "", avatar: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")
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
    @State var wrongFormatAlert = false
    @State var repeatPasswordDifferentAlert = false
    @State var inputInvalidAlert = false
    @State var confirmAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            RegisterTextField(textType: "昵称", textContent: $nickname, textWarningOpacity: $nicknameWarningOpacity, formatRequirement: "可由1到32个汉字、大小写字母和数字组成")
            RegisterTextField(textType: "真实姓名", textContent: $realname, textWarningOpacity: $realnameWarningOpacity, formatRequirement: "可由2到5个汉字或1到32位大小写字母组成")
            RegisterTextField(textType: "身份证号", textContent: $id, textWarningOpacity: $idWarningOpacity, formatRequirement: "第二代18位身份证号")
            RegisterTextField(textType: "邮箱", textContent: $emailaddress, textWarningOpacity: $emailaddressWarningOpacity, formatRequirement: "正常邮箱格式")
            RegisterTextField(textType: "密码", textContent: $password, textWarningOpacity: $passwordWarningOpacity, formatRequirement: "可由字母和数字组成，至少8位密码，最多32位")
            RegisterTextField(textType: "再次输入密码", textContent: $repeatPassword, textWarningOpacity: $repeatPasswordWarningOpacity, formatRequirement: "与上述密码一致")
            Button(action: {
                if !confirmTextTypeMatch(textType: "昵称", textContent: nickname) || !confirmTextTypeMatch(textType: "真实姓名", textContent: realname) ||
                    !confirmTextTypeMatch(textType: "身份证号", textContent: id) ||
                    !confirmTextTypeMatch(textType: "邮箱", textContent: emailaddress) ||
                    !confirmTextTypeMatch(textType: "密码", textContent: password) {
                    wrongFormatAlert = true
                } else {
                    wrongFormatAlert = false
                }
                if password != repeatPassword {
                    repeatPasswordDifferentAlert = true
                } else {
                    repeatPasswordDifferentAlert = false
                }
                if repeatPasswordDifferentAlert || wrongFormatAlert {
                    inputInvalidAlert = true
                } else {
                    inputInvalidAlert = false
                    user.nickname = nickname
                    user.realname = realname
                    user.idcard = id
                    user.emailaddress = emailaddress
                    user.password = password
                    NetworkAPIFunctions.functions.register(user: user)
                    confirmAlert = true
                }
            }, label: {
                Text("确认")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(13)
            })
            .alert(isPresented: $inputInvalidAlert, content: {
                var alertMessage: String = ""
                if wrongFormatAlert {
                    alertMessage = "输入格式无效！请按正确格式输入！"
                }
                else if repeatPasswordDifferentAlert {
                    alertMessage = "再次输入的密码与设置的密码不一致！"
                }
                return Alert(title: Text("警告"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("确认")))
            })
            .alert(isPresented: $confirmAlert, content: {
                return Alert(title: Text("欢迎！"),
                    message: Text("新账号已创建成功，账号为\(user.username)，请牢记！"),
                    dismissButton: .default(Text("确认")) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                )
            })
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
