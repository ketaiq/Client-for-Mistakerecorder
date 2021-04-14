//
//  ImageOCRView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/3.
//

import SwiftUI

struct ImageOCRView: View {
    @ObservedObject var text: ObservableString // 识别得到的文字
    @Binding var croppedImage: UIImage
    @Binding var showMistakeOCRView: Bool
    @Binding var showCroppedImage: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showCroppedImage = false
                    self.showMistakeOCRView = false
                }, label: {
                    Text("完成")
                        .bold()
                        .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                        .padding(.horizontal, 10)
                        .padding(10)
                        .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                        .cornerRadius(10)
                        .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                        .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                })
            }
            .padding()
            Image(uiImage: self.croppedImage)
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            Text("识别结果：\(self.text.content)")
                .font(.system(size: 20))
                .padding()
            Spacer()
        }
    }
}

struct ImageOCRView_Previews: PreviewProvider {
    @StateObject static var text = ObservableString("曾经沧海难为水，除却巫山不是云。")
    @State static var croppedImage = UIImage(named: "测试手写汉字")!
    @State static var showMistakeOCRView = false
    @State static var showCroppedImage = false
    
    static var previews: some View {
        ImageOCRView(text: text, croppedImage: $croppedImage, showMistakeOCRView: $showMistakeOCRView, showCroppedImage: $showCroppedImage)
    }
}
