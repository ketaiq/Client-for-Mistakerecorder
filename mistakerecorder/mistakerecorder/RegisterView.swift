//
//  RegisterView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/22.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var user = User(username: "", nickname: "", realname: "", idcard: "", emailaddress: "", password: "", avatar: UIImage(systemName: "person.circle")!.pngData()!.base64EncodedString())
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
    @State var wrongFormatAlert = false
    @State var repeatPasswordDifferentAlert = false
    @State var confirmAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            RegisterTextField(textType: "昵称", textContent: $nickname, textWarningOpacity: $nicknameWarningOpacity, formatRequirement: "可由1到32个汉字、大小写字母和数字组成")
            RegisterTextField(textType: "真实姓名", textContent: $realname, textWarningOpacity: $realnameWarningOpacity, formatRequirement: "可由2到5个汉字或1到32位大小写字母及空格组成")
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
                }
                if password != repeatPassword {
                    repeatPasswordDifferentAlert = true
                }
                if !repeatPasswordDifferentAlert && !wrongFormatAlert {
                    user.nickname = nickname
                    user.realname = realname
                    user.idcard = id
                    user.emailaddress = emailaddress
                    user.password = password
                    NetworkAPIFunctions.functions.register(user: user)
                    confirmAlert = true
                }
                if wrongFormatAlert || repeatPasswordDifferentAlert || confirmAlert {
                    showAlert = true
                }
            }, label: {
                Text("确认")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
            })
            .padding(.horizontal)
            .alert(isPresented: $showAlert, content: {
                if wrongFormatAlert {
                    return Alert(title: Text("警告"),
                                 message: Text("输入格式无效！请按正确格式输入！"),
                                 dismissButton: .default(Text("确认")) {
                                    wrongFormatAlert = false
                                 })
                } else if repeatPasswordDifferentAlert {
                    return Alert(title: Text("警告"),
                                 message: Text("再次输入的密码与设置的密码不一致！"),
                                 dismissButton: .default(Text("确认")) {
                                    repeatPasswordDifferentAlert = false
                                 })
                } else if confirmAlert {
                    return Alert(title: Text("欢迎！"),
                                 message: Text("新账号已创建成功，账号为\(user.username)，请牢记！"),
                                 dismissButton: .default(Text("确认")) {
                                    confirmAlert = false
                                    self.presentationMode.wrappedValue.dismiss()
                                 })
                } else {
                    return Alert(title: Text("警告！"),
                                 message: Text("未知错误！"),
                                 dismissButton: .default(Text("确认"))
                    )
                }
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
