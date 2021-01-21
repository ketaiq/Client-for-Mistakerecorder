//
//  LoginView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/21.
//

import SwiftUI

struct LoginView: View {
@State private var username = ""
@State private var password = ""
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    Text("账号：")
                        .font(.system(size: 16))
                    Text("密码：")
                        .font(.system(size: 16))
                })
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    TextField(
                        "",
                        text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .border(Color.black)
                    SecureField(
                        "",
                        text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .border(Color.black)
                })
            }.padding()
            
            HStack {
                Button(action: {
                    print("Click register button")
                }, label: {
                    Text("注册")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 100, height: 26)
                        .background(Color.green)
                        .cornerRadius(13)
                        
                })
                
                Button(action: {
                    print("Click login button")
                }, label: {
                    Text("登录")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 100, height: 26)
                        .background(Color.blue)
                        .cornerRadius(13)
                })
            }.padding(.bottom, 20)
            VStack(alignment: .trailing) {
                
                Button(action: {
                    print("Click find password button")
                }, label: {
                    Text("找回密码")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 26)
                })
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
