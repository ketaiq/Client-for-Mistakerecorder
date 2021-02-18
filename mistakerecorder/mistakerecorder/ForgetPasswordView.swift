//
//  ForgetPasswordView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

class ForgetPasswordStatus: ObservableObject {
    @Published var findPasswordSuccessfully: Bool
    @Published var invalidInfoAlert: Bool
    
    init(findPasswordSuccessfully: Bool, invalidInfoAlert: Bool) {
        self.findPasswordSuccessfully = findPasswordSuccessfully
        self.invalidInfoAlert = invalidInfoAlert
    }
}

struct ForgetPasswordView: View {
    @StateObject private var user = User(username: "", nickname: "", realname: "", idcard: "", emailaddress: "", password: "", avatar: "")
    @StateObject private var forgetPasswordStatus = ForgetPasswordStatus(findPasswordSuccessfully: false, invalidInfoAlert: false)
    @State private var username = ""
    @State private var realname = ""
    @State private var id = ""
    @State private var emailaddress = ""
    @State private var newPassword = ""
    @State private var repeatNewPassword = ""
    @State private var usernameWarningOpacity: Double = 0
    @State private var realnameWarningOpacity: Double = 0
    @State private var idWarningOpacity: Double = 0
    @State private var emailaddressWarningOpacity: Double = 0
    @State private var passwordWarningOpacity: Double = 0
    @State private var repeatPasswordWarningOpacity: Double = 0
    @State private var wrongFormatAlert = false
    @State private var repeatPasswordDifferentAlert = false
    @State private var inputInvalidAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            RegisterTextField(textType: "账号", textContent: $username, textWarningOpacity: $usernameWarningOpacity, formatRequirement: "注册后得到的8位数字")
            RegisterTextField(textType: "真实姓名", textContent: $realname, textWarningOpacity: $realnameWarningOpacity, formatRequirement: "可由2到5个汉字或1到32位大小写字母组成")
            RegisterTextField(textType: "身份证号", textContent: $id, textWarningOpacity: $idWarningOpacity, formatRequirement: "第二代18位身份证号")
            RegisterTextField(textType: "邮箱", textContent: $emailaddress, textWarningOpacity: $emailaddressWarningOpacity, formatRequirement: "正常邮箱格式")
            RegisterTextField(textType: "新密码", textContent: $newPassword, textWarningOpacity: $passwordWarningOpacity, formatRequirement: "可由字母和数字组成，至少8位密码，最多32位")
            RegisterTextField(textType: "再次输入新密码", textContent: $repeatNewPassword, textWarningOpacity: $repeatPasswordWarningOpacity, formatRequirement: "与上述密码一致")
            Button(action: {
                if !confirmTextTypeMatch(textType: "真实姓名", textContent: realname) ||
                    !confirmTextTypeMatch(textType: "身份证号", textContent: id) ||
                    !confirmTextTypeMatch(textType: "邮箱", textContent: emailaddress) ||
                    !confirmTextTypeMatch(textType: "新密码", textContent: newPassword) {
                    wrongFormatAlert = true
                } else {
                    wrongFormatAlert = false
                }
                if newPassword != repeatNewPassword {
                    repeatPasswordDifferentAlert = true
                } else {
                    repeatPasswordDifferentAlert = false
                }
                if repeatPasswordDifferentAlert || wrongFormatAlert {
                    inputInvalidAlert = true
                } else {
                    inputInvalidAlert = false
                    user.username = username
                    user.realname = realname
                    user.idcard = id
                    user.emailaddress = emailaddress
                    user.password = newPassword
                    NetworkAPIFunctions.functions.forgetPassword(user: user, forgetPasswordStatus: forgetPasswordStatus)
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
            .alert(isPresented: $forgetPasswordStatus.invalidInfoAlert, content: {
                return Alert(title: Text("提示"),
                             message: Text("提供的信息无效！"),
                             dismissButton: .default(Text("确认")) {
                                forgetPasswordStatus.invalidInfoAlert = false
                             })
            })
            .alert(isPresented: $forgetPasswordStatus.findPasswordSuccessfully, content: {
                return Alert(title: Text("欢迎！"),
                             message: Text("账号已找回，新密码为\(user.password)，请牢记！"),
                             dismissButton: .default(Text("确认")) {
                                self.presentationMode.wrappedValue.dismiss()
                             })
            })
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
