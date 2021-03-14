//
//  PhotographView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import UIKit
import SwiftUI

struct PhotographView: View {
    @State private var showingPhotoLibrary = false
    @State private var showingCamera = false
    @State private var showingSheet = false
    @State private var image = UIImage()
    
    var body: some View {
        NavigationView {
            VStack  {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                    ZStack {
                        Button(action: {
                            showingCamera = true
                        }, label: {
                            HStack {
                                Image(systemName: "camera")
                                    .font(.system(size: 20))
                                
                                Text("拍照")
                                    .font(.headline)
                                    .font(.system(size: 16))
                            }
                            .frame(width: 100, height: 50, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        })
                        NavigationLink(
                            destination: ImagePicker(sourceType: .camera, selectedImage: self.$image)
                                .navigationBarHidden(true)
                                .navigationBarTitle("", displayMode: .inline),
                            isActive: $showingCamera) {
                            EmptyView()
                        }
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                    }
                    Spacer()
                    Button(action: {
                        showingPhotoLibrary = true
                    }, label: {
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                            
                            Text("照片图库")
                                .font(.headline)
                                .font(.system(size: 16))
                        }
                        .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    })
                })
                .padding()
            }
            .sheet(isPresented: $showingPhotoLibrary, content: {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            })
        }
        
    }
}

struct PhotographView_Previews: PreviewProvider {
    static var previews: some View {
        PhotographView()
    }
}
