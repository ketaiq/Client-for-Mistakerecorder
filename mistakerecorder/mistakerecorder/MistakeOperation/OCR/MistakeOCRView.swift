//
//  MistakeOCRView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/13.
//

import SwiftUI

struct MistakeOCRView: View {
    @ObservedObject var text: ObservableString // 识别得到的文字
    @Binding var showMistakeOCRView: Bool
    @State private var image = UIImage()
    @State private var showPhotoLibrary = false
    @State private var captureButtonPressed = false
    
    var body: some View {
        ZStack {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                CustomImagePicker(selectedImage: self.$image, captureButtonPressed: self.$captureButtonPressed)
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
                    Button(action: {}) {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    }
                    .hidden()
                    Spacer()
                    Button(action: {
                        self.captureButtonPressed = true
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
                ImageEditView(text: text, image: self.$image, showMistakeOCRView: $showMistakeOCRView)
                    .zIndex(1.0)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MistakeOCRView_Previews: PreviewProvider {
    @State static var showMistakeOCRView = true
    @State static var text = ObservableString("测试文字")
    
    static var previews: some View {
        MistakeOCRView(text: text, showMistakeOCRView: $showMistakeOCRView)
    }
}
