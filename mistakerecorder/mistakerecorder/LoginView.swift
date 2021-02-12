//
//  LoginView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/21.
//

import SwiftUI

class LoginStatus: ObservableObject {
    @Published var loginSuccessfully: Bool
    @Published var wrongPasswordAlert: Bool
    @Published var inexistentUsernameAlert: Bool
    
    init(loginSuccessfully: Bool, wrongPasswordAlert: Bool, inexistentUsernameAlert: Bool) {
        self.loginSuccessfully = false
        self.wrongPasswordAlert = false
        self.inexistentUsernameAlert = false
    }
}

struct LoginView: View, DataDelegate {
    @StateObject private var user = User(_id: "", username: "", nickname: "", realname: "", idcard: "", emailaddress: "", password: "", avatar: "")
    @State private var registerButtonPressed = false
    @State private var forgetPasswordButtonPressed = false
    @StateObject private var loginStatus = LoginStatus(
        loginSuccessfully: false,
        wrongPasswordAlert: false,
        inexistentUsernameAlert: false)

    func fetch(newData: String) {
        var fetchedUser: User
        do {
            fetchedUser = try JSONDecoder().decode(
                User.self,
                from: newData.data(using: .utf8)!)
            user.username = fetchedUser.username
            user.nickname = fetchedUser.nickname
            user.realname = fetchedUser.realname
            user.idcard = fetchedUser.idcard
            user.emailaddress = fetchedUser.emailaddress
            user.password = fetchedUser.password
            user.avatar = fetchedUser.avatar
            user.mistakeList = fetchedUser.mistakeList
        } catch {
            print("解码失败！")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                            Text("账号：")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                            TextField(
                                "",
                                text: self.$user.username)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.system(size: 16))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        })
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                            Text("密码：")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                            SecureField(
                                "",
                                text: self.$user.password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.system(size: 16))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        })
                    }).padding(.trailing)
                    ZStack {
                        Button(action: {
                            NetworkAPIFunctions.functions.delegate = self
                            NetworkAPIFunctions.functions.login(user: user, loginStatus: loginStatus)
                        }, label: {
                            Text("登录")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .frame(width: 50, height: 80)
                                .background(Color.blue)
                                .cornerRadius(13)
                        })
                        .alert(isPresented: $loginStatus.wrongPasswordAlert, content: {
                            return Alert(title: Text("提示"),
                                         message: Text("账号与密码不匹配！"),
                                         dismissButton: .default(Text("确认")) {
                                            loginStatus.wrongPasswordAlert = false
                                         })
                        })
                        .alert(isPresented: $loginStatus.inexistentUsernameAlert, content: {
                            return Alert(title: Text("提示"),
                                         message: Text("账号不存在！"),
                                         dismissButton: .default(Text("确认")) {
                                            loginStatus.inexistentUsernameAlert = false
                                         })
                        })
                        NavigationLink(
                            destination: TabBar(user: user),
                            isActive: $loginStatus.loginSuccessfully) {
                            EmptyView()
                        }
                        .navigationBarTitle("", displayMode: .inline)
                    }
                }).padding()
                HStack {
                    ZStack {
                        Button(action: {
                            registerButtonPressed = true
                        }, label: {
                            Text("注册")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .frame(width: 100, height: 26)
                                .background(Color.green)
                                .cornerRadius(13)
                        })
                        NavigationLink(
                            destination: RegisterView(),
                            isActive: $registerButtonPressed) {
                            EmptyView()
                        }
                        .navigationBarTitle("", displayMode: .inline)
                    }
                    Rectangle()
                        .frame(width: 20, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    ZStack {
                        Button(action: {
                            forgetPasswordButtonPressed = true
                        }, label: {
                            Text("忘记密码")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .frame(width: 100, height: 26)
                                .background(Color.green)
                                .cornerRadius(13)
                        })
                        NavigationLink(
                            destination: ForgetPasswordView(),
                            isActive: $forgetPasswordButtonPressed) {
                            EmptyView()
                        }
                        .navigationBarTitle("", displayMode: .inline)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
