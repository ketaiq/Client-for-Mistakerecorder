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
        self.loginSuccessfully = loginSuccessfully
        self.wrongPasswordAlert = wrongPasswordAlert
        self.inexistentUsernameAlert = inexistentUsernameAlert
    }
}

struct LoginView: View {
    @StateObject private var user = User(username: "", nickname: "", realname: "", idcard: "", emailaddress: "", password: "", avatar: "")
    
    var body: some View {
        NavigationView {
            VStack {
                RegisterButtonSubview()
                Spacer()
                AppNameSubview()
                InputTextSubview(user: user)
                Spacer()
                HStack {
                    ForgetPasswordButtonSubview()
                    Spacer()
                    LoginButtonSubview(user: user)
                }
                Spacer()
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

struct RegisterButtonSubview: View {
    @State private var registerButtonPressed = false
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Button(action: {
                    registerButtonPressed = true
                }, label: {
                    Text("注册")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 70, height: 50)
                        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                        .padding()
                })
                NavigationLink(
                    destination: RegisterView(),
                    isActive: $registerButtonPressed) {
                    EmptyView()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}

struct AppNameSubview: View {
    var body: some View {
        HStack {
            Text("错题拍拍")
                .font(.system(size: 55, weight: .bold))
                .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
            Image(systemName: "doc.text.magnifyingglass")
                .font(Font.system(size: 100))
                .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
        }
    }
}

struct LoginButtonSubview: View, DataDelegate {
    @ObservedObject var user: User
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
        ZStack {
            Button(action: {
                NetworkAPIFunctions.functions.delegate = self
                NetworkAPIFunctions.functions.login(user: user, loginStatus: loginStatus)
            }, label: {
                Text("登录")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
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
    }
}

struct ForgetPasswordButtonSubview: View {
    @State private var forgetPasswordButtonPressed = false
    
    var body: some View {
        ZStack {
            Button(action: {
                forgetPasswordButtonPressed = true
            }, label: {
                Text("忘记密码")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    .frame(width: 100, height: 50)
                    .padding(.horizontal)
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

struct InputTextSubview: View {
    @ObservedObject var user: User
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            HStack {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                    .font(.system(size: 30))
                    .frame(width: 44, height: 44)
                TextField(
                    "账号",
                    text: self.$user.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 20))
            }
            Divider()
                .padding(.horizontal)
                .offset(x: 30)
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                    .font(.system(size: 30))
                    .frame(width: 44, height: 44)
                SecureField(
                    "密码",
                    text: self.$user.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 20))
            }
        })
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
        .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 5)
        .padding(.horizontal)
    }
}
