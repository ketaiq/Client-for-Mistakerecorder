//
//  UserMenuView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/27.
//

import SwiftUI

struct UserMenuView: View {
    @ObservedObject var user: User
    @EnvironmentObject var loginStatus: LoginStatus
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Spacer()
                Text("\(user.nickname)")
                    .font(.title)
                Text("账号：\(user.username)")
                    .frame(width: 200, alignment: .leading)
                Text("真实姓名：\(user.realname)")
                    .frame(width: 200, alignment: .leading)
                HStack(spacing: 16) {
                    Image(systemName: "gear")
                        .font(.system(size: 20, weight: .light))
                        .imageScale(.large)
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    NavigationLink(
                        destination: EditUserInfoView(user: user),
                        label: {
                            Text("编辑资料")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                        })
                        .navigationTitle(Text("主页"))
                        .navigationBarHidden(true)
                }
                HStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.badge.minus")
                        .font(.system(size: 20, weight: .light))
                        .imageScale(.large)
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    Button(action: {
                        loginStatus.showTabView = false
                    }, label: {
                        Text("退出登录")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    })
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image(uiImage: UIImage(data: Data(base64Encoded: user.avatar)!)!)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -150))
        }
        .padding(.bottom, 30)
    }
}

struct UserMenuView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!.pngData()!.base64EncodedString())
    static var previews: some View {
        UserMenuView(user: user).environmentObject(LoginStatus())
    }
}
