//
//  ImageEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/14.
//

import SwiftUI

struct ImageEditView: View {
    @ObservedObject var text: ObservableString // 识别得到的文字
    @Binding var image: UIImage
    @Binding var showMistakeOCRView: Bool
    @StateObject private var cropper = Cropper(parentSize: CGSize.zero)
    @State private var croppedImage = UIImage()
    @State private var showCroppedImage = false
    
    // 逆时针旋转90度
    private func rotate90degrees(_ editImage: UIImage) -> UIImage {
        let ciimage = CIImage(image: editImage)
        let filter = CIFilter(name: "CIAffineTransform")!
        filter.setValue(ciimage, forKey: kCIInputImageKey)
        filter.setDefaults()

        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, .pi / 2, 0, 0, 1)
        let affineTransform = CATransform3DGetAffineTransform(transform)
        filter.setValue(NSValue(cgAffineTransform: affineTransform), forKey: "inputTransform")

        let context = CIContext(options: [CIContextOption.useSoftwareRenderer: true])
        let outputImage = filter.outputImage!
        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: cgImage)
    }
    
    // 裁剪图片
    private func cropImage() {
        var editImage = self.image
        editImage = self.rotate90degrees(editImage)
        editImage = self.rotate90degrees(editImage)
        editImage = self.rotate90degrees(editImage)
        let cgImage = editImage.cgImage!
        let scaler = CGFloat(cgImage.width) / self.cropper.parentSize.width
        let x = (self.cropper.rect.origin.x - self.cropper.rect.width / 2) * scaler
        let y = (self.cropper.rect.origin.y - self.cropper.rect.height / 2) * scaler
        let width = self.cropper.rect.width * scaler
        let height = self.cropper.rect.height * scaler
        let croppedCGImage = cgImage.cropping(to: CGRect(x: x, y: y, width: width, height: height))!
        self.croppedImage = UIImage(cgImage: croppedCGImage)
    }
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Spacer()
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .overlay(GeometryReader { parentProxy in
                        CropperView(cropper: self.cropper).onAppear {
                            self.cropper.update(parentSize: parentProxy.size)
                        }.onChange(of: parentProxy.size) { value in
                            self.cropper.update(parentSize: parentProxy.size)
                        }
                    })
                    .padding(30)
                Spacer()
                HStack {
                    Button(action: {
                        self.image = UIImage()
                    }, label: {
                        Text("返回")
                            .foregroundColor(.white)
                            .padding(10)
                            .padding(.horizontal, 10)
                            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .cornerRadius(10)
                    })
                    Spacer()
                    Button(action: {
                        self.image = self.rotate90degrees(self.image)
                    }, label: {
                        Image(systemName: "rotate.left.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    })
                    Spacer()
                    Button(action: {
                        self.cropImage()
                        NetworkAPIFunctions.functions.baiduOCR(ocr_result: self.text, croppedImage: self.croppedImage)
                        self.showCroppedImage = true
                    }, label: {
                        Text("完成")
                            .foregroundColor(.white)
                            .padding(10)
                            .padding(.horizontal, 10)
                            .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                            .cornerRadius(10)
                    })
                    .sheet(isPresented: self.$showCroppedImage) {
                        ImageOCRView(text: self.text, croppedImage: self.$croppedImage, showMistakeOCRView: self.$showMistakeOCRView, showCroppedImage: self.$showCroppedImage)
                    }
                }
                .padding()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageEditView_Previews: PreviewProvider {
    @State static var text = ObservableString("测试文字")
    @State static var image = UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!
    @State static var showMistakeOCRView = true
    
    static var previews: some View {
        ImageEditView(text: text, image: $image, showMistakeOCRView: $showMistakeOCRView)
    }
}
