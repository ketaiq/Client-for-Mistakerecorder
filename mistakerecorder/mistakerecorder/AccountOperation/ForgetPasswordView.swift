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
    @State private var showAlert = false
    @State private var wrongFormatAlert = false
    @State private var repeatPasswordDifferentAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var textFieldOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                RegisterTextField(textType: "账号", textContent: $username, textWarningOpacity: $usernameWarningOpacity, formatRequirement: "注册后得到的8位数字", textFieldOffset: self.$textFieldOffset)
                RegisterTextField(textType: "真实姓名", textContent: $realname, textWarningOpacity: $realnameWarningOpacity, formatRequirement: "可由2到5个汉字或1到32位大小写字母组成", textFieldOffset: self.$textFieldOffset)
                RegisterTextField(textType: "身份证号", textContent: $id, textWarningOpacity: $idWarningOpacity, formatRequirement: "第二代18位身份证号", textFieldOffset: self.$textFieldOffset)
                RegisterTextField(textType: "邮箱", textContent: $emailaddress, textWarningOpacity: $emailaddressWarningOpacity, formatRequirement: "正常邮箱格式", textFieldOffset: self.$textFieldOffset)
                RegisterTextField(textType: "新密码", textContent: $newPassword, textWarningOpacity: $passwordWarningOpacity, formatRequirement: "可由字母和数字组成，至少8位密码，最多32位", textFieldOffset: self.$textFieldOffset)
                RegisterTextField(textType: "再次输入新密码", textContent: $repeatNewPassword, textWarningOpacity: $repeatPasswordWarningOpacity, formatRequirement: "与上述密码一致", textFieldOffset: self.$textFieldOffset)
            }
            .offset(y: self.textFieldOffset)
            .animation(.easeInOut(duration: 0.3))
            
            Spacer()
            Button(action: {
                if !confirmTextTypeMatch(textType: "真实姓名", textContent: realname) ||
                    !confirmTextTypeMatch(textType: "身份证号", textContent: id) ||
                    !confirmTextTypeMatch(textType: "邮箱", textContent: emailaddress) ||
                    !confirmTextTypeMatch(textType: "新密码", textContent: newPassword) {
                    wrongFormatAlert = true
                }
                if newPassword != repeatNewPassword {
                    repeatPasswordDifferentAlert = true
                }
                if !repeatPasswordDifferentAlert && !wrongFormatAlert {
                    user.username = username
                    user.realname = realname
                    user.idcard = id
                    user.emailaddress = emailaddress
                    user.password = newPassword
                    NetworkAPIFunctions.functions.forgetPassword(user: user, forgetPasswordStatus: forgetPasswordStatus)
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
            .alert(isPresented: $showAlert, content: {
                if wrongFormatAlert {
                    return Alert(title: Text("警告"),
                                 message: Text("输入格式无效！请按正确格式输入！"),
                                 dismissButton: .default(Text("确认")) {
                                    wrongFormatAlert = false
                                    showAlert = false
                                 })
                } else if repeatPasswordDifferentAlert {
                    return Alert(title: Text("警告"),
                                 message: Text("再次输入的密码与设置的密码不一致！"),
                                 dismissButton: .default(Text("确认")) {
                                    repeatPasswordDifferentAlert = false
                                    showAlert = false
                                 })
                } else if forgetPasswordStatus.invalidInfoAlert {
                    return Alert(title: Text("警告"),
                                 message: Text("提供的信息无效！"),
                                 dismissButton: .default(Text("确认")) {
                                    forgetPasswordStatus.invalidInfoAlert = false
                                    showAlert = false
                                 })
                } else if forgetPasswordStatus.findPasswordSuccessfully {
                    return Alert(title: Text("欢迎！"),
                                 message: Text("账号已找回，新密码为\(user.password)，请牢记！"),
                                 dismissButton: .default(Text("确认")) {
                                    forgetPasswordStatus.findPasswordSuccessfully = false
                                    showAlert = false
                                    self.presentationMode.wrappedValue.dismiss()
                                 })
                } else {
                    return Alert(title: Text("警告！"),
                                 message: Text("未知错误！"),
                                 dismissButton: .default(Text("确认")) {
                                    showAlert = false
                                 })
                }
            })
        }
        .padding(.vertical)
        .background(Color.white)
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
