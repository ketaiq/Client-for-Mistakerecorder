//
//  MistakeOCRView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/13.
//

import SwiftUI

struct MistakeOCRView: View {
    @Binding var text: String // 识别得到的文字
    @State private var image = UIImage()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showPhotoLibrary = false
    
    var body: some View {
        ZStack {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                ImagePicker(sourceType: .camera, selectedImage: self.$image)
            }
            HStack {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: 1)
                    .frame(maxHeight: .infinity)
                    .offset(x: screen.width / 2 - screen.width * 2 / 3)
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: 1)
                    .frame(maxHeight: .infinity)
                    .offset(x: screen.width / 2 - screen.width * 1 / 3)
            }
            VStack {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .offset(y: screen.height / 2 - screen.height * 2 / 3)
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .offset(y: screen.height / 2 - screen.height * 1 / 3)
            }
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    }
                    .hidden()
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "camera.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                        
                    }
                    Spacer()
                    Button(action: {
                        self.showPhotoLibrary = true
                    }) {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    }
                    .sheet(isPresented: self.$showPhotoLibrary) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                }
                .padding()
            }
            if self.image != UIImage() {
                ImageEditView(image: self.$image)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MistakeOCRView_Previews: PreviewProvider {
    @State static var text = "测试文字"
    
    static var previews: some View {
        MistakeOCRView(text: $text)
    }
}
