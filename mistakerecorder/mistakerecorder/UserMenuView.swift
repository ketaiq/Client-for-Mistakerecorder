//
//  UserMenuView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/27.
//

import SwiftUI

struct UserMenuView: View {
    @EnvironmentObject var loginStatus: LoginStatus
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Text("邱珂泰 - 37% 已完成复习")
                    .font(.caption)
                Color.white
                    .frame(width: 38, height: 6)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    .offset(x: -20, y: 0)
                    .frame(width: 130, height: 6)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1))
                    .cornerRadius(12)
                HStack(spacing: 16) {
                    Image(systemName: "gear")
                        .font(.system(size: 20, weight: .light))
                        .imageScale(.large)
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    Text("账户")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .frame(width: 120, alignment: .leading)
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
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .frame(width: 120, alignment: .leading)
                            .foregroundColor(.black)
                    })
                    
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image("ac84bcb7d0a20cf4800d77cc74094b36acaf990f")
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
    static var previews: some View {
        UserMenuView().environmentObject(LoginStatus())
    }
}
