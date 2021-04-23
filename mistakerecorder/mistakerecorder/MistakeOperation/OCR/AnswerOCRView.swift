//
//  AnswerOCRView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/21.
//

import SwiftUI

struct AnswerOCRView: View {
    @ObservedObject var mistake: Mistake
    @ObservedObject var updateText: ObservableBool
    @Binding var showMistakeOCRView: Bool
    let questionItemIndex: Int
    
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
                AnswerImageEditView(mistake: self.mistake, updateText: self.updateText, questionItemIndex: self.questionItemIndex, image: self.$image, showMistakeOCRView: $showMistakeOCRView)
                    .zIndex(1.0)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AnswerOCRView_Previews: PreviewProvider {
    @StateObject static var mistakePinYinXieCi = Mistake(subject: "语文", category: MistakeCategory.PinYinXieCi.toString(), questionDescription: MistakeCategory.PinYinXieCi.generateDescription(),
            questionItems: [
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "快乐*", rightAnswer: "乐"),
                QuestionItem(question: "放松*", rightAnswer: "松"),
                QuestionItem(question: "高兴*", rightAnswer: "兴"),
                QuestionItem(question: "快乐*", rightAnswer: "乐"),
                QuestionItem(question: "放松*", rightAnswer: "松")
            ])
    @StateObject static var updateText = ObservableBool(false)
    @State static var showMistakeOCRView = false
    static var previews: some View {
        AnswerOCRView(mistake: mistakePinYinXieCi, updateText: updateText, showMistakeOCRView: $showMistakeOCRView, questionItemIndex: 0)
    }
}
