//
//  EditUserInfoView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/27.
//

import SwiftUI

struct EditUserInfoView: View {
    @ObservedObject var user: User
    @State private var avatarEditStatus = false
    @State private var nicknameEditStatus = false
    @State private var nicknameWrongFormatAlert = false
    @State private var nickname = ""
    @State private var emailaddressEditStatus = false
    @State private var emailaddressWrongFormatAlert = false
    @State private var emailaddress = ""
    @State private var passwordEditStatus = false
    @State private var passwordWrongFormatAlert = false
    @State private var password = ""
    @State private var idcardInfoStatus = false
    @State private var realnameInfoStatus = false
    
    var body: some View {
        List {
            HStack {
                Text("头像")
                    .font(.system(size: 20))
                Spacer()
                Image(uiImage: UIImage(data: Data(base64Encoded: user.avatar)!)!)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            .onTapGesture {
                self.avatarEditStatus = true
            }
            .padding(.vertical)
            .sheet(isPresented: self.$avatarEditStatus, content: {
                EditAvatarView(user: user)
            })
            
            ZStack {
                HStack {
                    Text("昵称")
                        .font(.system(size: 20))
                    Spacer()
                    Text(user.nickname)
                        .font(.system(size: 20))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                }
                .onTapGesture {
                    self.nicknameEditStatus = true
                }
                .offset(x: self.nicknameEditStatus ? -500 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
                
                ZStack {
                    TextField("\(user.nickname)", text: self.$nickname)
                        .font(.system(size: 20))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    HStack {
                        Spacer()
                        Text("返回")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                self.nicknameEditStatus = false
                            }
                        Text("清空")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(.red))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                nickname = ""
                            }
                        Text("保存")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                self.nicknameWrongFormatAlert = !confirmTextTypeMatch(textType: "昵称", textContent: self.nickname)
                                if !self.nicknameWrongFormatAlert {
                                    user.nickname = nickname
                                    NetworkAPIFunctions.functions.updateNickname(user: user)
                                    self.nicknameEditStatus = false
                                }
                            }
                            .alert(isPresented: self.$nicknameWrongFormatAlert, content: {
                                return Alert(title: Text("警告！"),
                                    message: Text("输入格式无效！请按正确格式输入！昵称可由1到32个汉字、大小写字母和数字组成。"),
                                    dismissButton: .default(Text("确认")) {
                                        self.nicknameWrongFormatAlert = false
                                    }
                                )
                            })
                    }
                }
                .offset(x: self.nicknameEditStatus ? 0 : 500)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
            }
        
            ZStack {
                HStack {
                    Text("真实姓名")
                        .font(.system(size: 20))
                    Spacer()
                    Text(user.realname)
                        .font(.system(size: 20))
                    Image(systemName: "info.circle")
                        .font(.system(size: 20))
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                }
                .onTapGesture {
                    self.realnameInfoStatus = true
                }
                .offset(x: self.realnameInfoStatus ? -500 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
                
                HStack {
                    Text("真实姓名不可更改。")
                        .font(.system(size: 20))
                    Spacer()
                    Text("返回")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            self.realnameInfoStatus = false
                    }
                }
                .offset(x: self.realnameInfoStatus ? 0 : 500)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
            }
            
            ZStack {
                HStack {
                    Text("身份证号")
                        .font(.system(size: 20))
                    Spacer()
                    Text(user.idcard)
                        .font(.system(size: 20))
                    Image(systemName: "info.circle")
                        .font(.system(size: 20))
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                }
                .onTapGesture {
                    self.idcardInfoStatus = true
                }
                .offset(x: self.idcardInfoStatus ? -500 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
                
                HStack {
                    Text("身份证号不可更改。")
                        .font(.system(size: 20))
                    Spacer()
                    Text("返回")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            self.idcardInfoStatus = false
                    }
                }
                .offset(x: self.idcardInfoStatus ? 0 : 500)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
            }
            
            ZStack {
                HStack {
                    Text("邮箱")
                        .font(.system(size: 20))
                    Spacer()
                    Text(user.emailaddress)
                        .font(.system(size: 20))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                }
                .onTapGesture {
                    self.emailaddressEditStatus = true
                }
                .offset(x: self.emailaddressEditStatus ? -500 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
                
                ZStack {
                    TextField("\(user.emailaddress)", text: self.$emailaddress)
                        .font(.system(size: 20))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    HStack {
                        Spacer()
                        Text("返回")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                self.emailaddressEditStatus = false
                            }
                        Text("清空")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(.red))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                emailaddress = ""
                            }
                        Text("保存")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                self.emailaddressWrongFormatAlert = confirmTextTypeMatch(textType: "邮箱", textContent: self.emailaddress)
                                if !self.emailaddressWrongFormatAlert {
                                    user.emailaddress = emailaddress
                                    NetworkAPIFunctions.functions.updateEmailaddress(user: user)
                                    self.emailaddressEditStatus = false
                                }
                            }
                            .alert(isPresented: self.$emailaddressWrongFormatAlert, content: {
                                return Alert(title: Text("警告！"),
                                    message: Text("输入格式无效！请按正确邮箱格式输入！例如1234@qq.com。"),
                                    dismissButton: .default(Text("确认")) {
                                        self.emailaddressWrongFormatAlert = false
                                    }
                                )
                            })
                    }
                }
                .offset(x: self.emailaddressEditStatus ? 0 : 500)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
            }
            ZStack {
                HStack {
                    Text("密码")
                        .font(.system(size: 20))
                    Spacer()
                    Text("●●●●●●")
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                }
                .onTapGesture {
                    self.passwordEditStatus = true
                }
                .offset(x: self.passwordEditStatus ? -500 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
                
                ZStack {
                    TextField("\(user.password)", text: self.$password)
                        .font(.system(size: 20))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    HStack {
                        Spacer()
                        Text("返回")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                self.passwordEditStatus = false
                            }
                        Text("清空")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(.red))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                password = ""
                            }
                        Text("保存")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 30)
                            .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .onTapGesture {
                                self.passwordWrongFormatAlert = confirmTextTypeMatch(textType: "密码", textContent: self.password)
                                if !self.passwordWrongFormatAlert {
                                    user.password = password
                                    NetworkAPIFunctions.functions.updatePassword(user: user)
                                    self.passwordEditStatus = false
                                }
                            }
                            .alert(isPresented: self.$passwordWrongFormatAlert, content: {
                                return Alert(title: Text("警告！"),
                                    message: Text("输入格式无效！请按正确邮箱格式输入！密码可由字母和数字组成，至少8位密码，最多32位。"),
                                    dismissButton: .default(Text("确认")) {
                                        self.passwordWrongFormatAlert = false
                                    }
                                )
                            })
                    }
                }
                .offset(x: self.passwordEditStatus ? 0 : 500)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .padding(.vertical)
            }
        }
    }
}

struct EditUserInfoView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!.pngData()!.base64EncodedString())
    static var previews: some View {
        EditUserInfoView(user: user)
    }
}
