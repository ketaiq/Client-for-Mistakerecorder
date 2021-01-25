//
//  PhotographView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/25.
//

import UIKit
import SwiftUI

struct PhotographView: View {
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    var body: some View {
        ZStack  {
            Image(uiImage: self.image)
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                Spacer()
                Button(action: {
                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }, label: {
                    HStack {
                        Image(systemName: "camera")
                            .font(.system(size: 20))
                        
                        Text("拍照")
                            .font(.headline)
                            .font(.system(size: 16))
                    }
                    .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                })
                
                Button(action: {
                    self.isShowPhotoLibrary = true
                }, label: {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                        
                        Text("照片图库")
                            .font(.headline)
                            .font(.system(size: 16))
                    }
                    .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                })
            })
            .padding()
            
            
        }
        .sheet(isPresented: $isShowPhotoLibrary, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        })
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}



struct PhotographView_Previews: PreviewProvider {
    static var previews: some View {
        PhotographView()
    }
}
