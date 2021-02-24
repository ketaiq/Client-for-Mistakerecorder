//
//  LoginView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/21.
//

import SwiftUI

class LoginStatus: ObservableObject {
    @Published var showTabView: Bool
    @Published var wrongPasswordAlert: Bool
    @Published var inexistentUsernameAlert: Bool
    @Published var isLoading: Bool
    @Published var isWelcoming: Bool
    
    init() {
        self.showTabView = false
        self.wrongPasswordAlert = false
        self.inexistentUsernameAlert = false
        self.isLoading = false
        self.isWelcoming = false
    }
}

struct LoginView: View {
    @EnvironmentObject var loginStatus: LoginStatus
    @ObservedObject var user: User
    
    var body: some View {
        ZStack {
            VStack {
                RegisterButtonSubview()
                Spacer()
                AppNameSubview()
                InputTextSubview(user: self.user)
                Spacer()
                HStack {
                    ForgetPasswordButtonSubview()
                    Spacer()
                    LoginButtonSubview(user: self.user, loginStatus: self.loginStatus)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .navigationBarHidden(true)
            .animation(.easeInOut)
            .onTapGesture {
                hideKeyboard()
            }
            
            if loginStatus.isLoading {
                LoadView()
            }
            
            if loginStatus.isWelcoming {
                WelcomeView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "", nickname: "", realname: "", idcard: "", emailaddress: "", password: "", avatar: "")
    static var previews: some View {
        LoginView(user: user).environmentObject(LoginStatus())
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
                        .background(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
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
    @ObservedObject var loginStatus: LoginStatus
    
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
    
    func login() {
        loginStatus.isLoading = true
        NetworkAPIFunctions.functions.delegate = self
        NetworkAPIFunctions.functions.login(user: user, loginStatus: loginStatus)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            loginStatus.isWelcoming = false
            loginStatus.showTabView = true
        }
    }
    
    var body: some View {
        Button(action: {
            hideKeyboard()
            login()
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
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 5)
        .padding(.horizontal)
    }
}
