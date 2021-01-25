//
//  LoginView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/21.
//

import SwiftUI

struct LoginView: View {
    @State private var loginButtonPressed = false
    @State private var registerButtonPressed = false
    @State private var forgetPasswordButtonPressed = false
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                            Text("账号：")
                                .font(.system(size: 16))
                            TextField(
                                "",
                                text: $username)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .border(Color.black)
                        })
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                            Text("密码：")
                                .font(.system(size: 16))
                            SecureField(
                                "",
                                text: $password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .border(Color.black)
                        })
                    }).padding(.trailing)
                    
                    ZStack {
                        Button(action: {
                            loginButtonPressed = true
                        }, label: {
                            Text("登录")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .cornerRadius(13)
                        })
                        NavigationLink(
                            destination: HomeView()
                                .navigationBarHidden(true)
                                .navigationBarTitle(""),
                            isActive: $loginButtonPressed) {
                            EmptyView()
                        }
                        .navigationBarHidden(true)
                        .navigationBarTitle("")
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
                    }
                    
                    
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
                    }
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 252 / 255, green: 230 / 255, blue: 201 / 255))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
