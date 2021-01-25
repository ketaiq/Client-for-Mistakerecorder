//
//  HomeNavigationBar.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

struct HomeNavigationBar: View {
    @State private var photographButtonPressed = false
    var body: some View {
        HStack(alignment: .bottom, spacing: 5, content: {
            Button(action: {
                
            }, label: {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.orange)
                    Text("首页")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                })
            })
            Spacer()
            Button(action: {
                
            }, label: {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
                    Image(systemName: "doc.text")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.orange)
                    Text("复习")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                })
            })
            Spacer()
            ZStack {
                Button(action: {
                    photographButtonPressed = true
                }, label: {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.orange)
                        Text("拍照")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    })
                })
                NavigationLink(
                    destination: testCameraView(),
                    isActive: $photographButtonPressed) {
                    EmptyView()
                }
            }
            
            Spacer()
            Button(action: {
                
            }, label: {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
                    Image(systemName: "book")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.orange)
                    Text("错题本")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                })
            })
            Spacer()
            Button(action: {
                
            }, label: {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.orange)
                    Text("我的")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                })
            })
        })
    }
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar()
    }
}
