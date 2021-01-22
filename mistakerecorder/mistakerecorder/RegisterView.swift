//
//  RegisterView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/22.
//

import SwiftUI

struct RegisterView: View {
    @State private var nickname = ""
    @State private var realname = ""
    @State private var id = ""
    @State private var emailaddress = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Text("昵称：")
                    .font(.system(size: 16))
                TextField(
                    "请输入昵称",
                    text: $nickname)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color.black)
                    
            })
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Text("真实姓名：")
                    .font(.system(size: 16))
                TextField(
                    "请输入真实姓名",
                    text: $realname)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color.black)
            })
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Text("身份证号：")
                    .font(.system(size: 16))
                TextField(
                    "请输入身份证号",
                    text: $id)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color.black)
            })
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Text("邮箱：")
                    .font(.system(size: 16))
                TextField(
                    "请输入邮箱",
                    text: $emailaddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color.black)
                    .textContentType(.emailAddress)
            })
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Text("密码：")
                    .font(.system(size: 16))
                SecureField(
                    "请输入密码",
                    text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color.black)
            })
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Text("再次输入密码：")
                    .font(.system(size: 16))
                SecureField(
                    "请再次输入密码",
                    text: $repeatPassword)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color.black)
            })
            
            Rectangle()
                .opacity(0)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                
            }, label: {
                Text("确认")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(13)
            })
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 252 / 255, green: 230 / 255, blue: 201 / 255))
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
