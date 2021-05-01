//
//  EditAvatarView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/28.
//

import SwiftUI

struct EditAvatarView: View {
    @ObservedObject var user: User
    @State private var avatar = UIImage()
    @State private var newAvatarEmptyAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("原头像：")
                        .font(.title2)
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        if self.avatar.pngData() == nil {
                            self.newAvatarEmptyAlert = true
                        } else {
                            user.avatar = self.avatar.pngData()!.base64EncodedString()
                            NetworkAPIFunctions.functions.updateAvatar(user: user)
                        }
                    }, label: {
                        Text("替换")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    })
                    .alert(isPresented: self.$newAvatarEmptyAlert, content: {
                        return Alert(title: Text("警告"),
                                     message: Text("新头像不能为空！"),
                                     dismissButton: .default(Text("确认")) {
                                        self.newAvatarEmptyAlert = false
                                     })
                    })
                }
                .padding(.horizontal)
                Image(uiImage: UIImage(data: Data(base64Encoded: user.avatar)!) ?? UIImage(systemName: "person.circle")!)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                HStack {
                    Text("新头像：")
                        .font(.title2)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal)
                Image(uiImage: self.avatar)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                Spacer()
                HStack(spacing: 50) {
                    NavigationLink(
                        destination: ImagePicker(sourceType: .camera, selectedImage: self.$avatar),
                        label: {
                            HStack {
                                Image(systemName: "camera")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                Text("拍照")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                            .padding()
                    })
                    NavigationLink(
                        destination: ImagePicker(sourceType: .photoLibrary, selectedImage: self.$avatar)
                            .navigationBarTitle("", displayMode: .inline),
                        label: {
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                Text("照片图库")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                            .padding()
                    })
                }
            }
            .navigationTitle("选择头像")
        }
    }
}

struct EditAvatarView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(systemName: "person.circle")!.pngData()!.base64EncodedString())
    static var previews: some View {
        EditAvatarView(user: user)
    }
}
