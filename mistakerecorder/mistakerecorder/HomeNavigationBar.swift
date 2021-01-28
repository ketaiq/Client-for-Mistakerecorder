//
//  HomeNavigationBar.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import SwiftUI

struct HomeNavigationBar: View {
    @State private var photographButtonPressed = false
    @State private var reviseButtonPressed = false
    @State private var mistakeButtonPressed = false
    var body: some View {
        HStack(alignment: .bottom, spacing: 5, content: {
            Spacer()
            ZStack {
                Button(action: {
                    reviseButtonPressed = true
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
                .sheet(isPresented: $reviseButtonPressed, content: {
                    ReviseListView()
                })
            }
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
                    destination: PhotographView(),
                    isActive: $photographButtonPressed) {
                    EmptyView()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
            Spacer()
            ZStack {
                Button(action: {
                    mistakeButtonPressed = true
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
                }).sheet(isPresented: $mistakeButtonPressed, content: {
                    MistakeListView()
                })
            }
            
            Spacer()
        })
    }
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar()
    }
}
