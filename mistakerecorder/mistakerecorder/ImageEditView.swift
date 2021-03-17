//
//  ImageEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/14.
//

import SwiftUI

struct ImageEditView: View {
    @Binding var image: UIImage
    @StateObject private var cropper = Cropper(parentSize: CGSize.zero)
    @State var croppedImage = UIImage()
    @State var showCroppedImage = false
    
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
                        let cgImage = image.cgImage!
                        let scaler = CGFloat(cgImage.width) / self.cropper.parentSize.width
                        let x = (self.cropper.rect.origin.x - self.cropper.rect.width / 2) * scaler
                        let y = (self.cropper.rect.origin.y - self.cropper.rect.height / 2) * scaler
                        let width = self.cropper.rect.width * scaler
                        let height = self.cropper.rect.height * scaler
                        let croppedCGImage = cgImage.cropping(to: CGRect(x: x, y: y, width: width, height: height))!
                        self.croppedImage = UIImage(cgImage: croppedCGImage)
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
                        Image(uiImage: self.croppedImage)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .padding()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CropperView: View {
    @ObservedObject var cropper: Cropper
    
    var body: some View {
        ZStack {
            Group {
                Rectangle()
                    .frame(width: cropper.topRect.width, height: cropper.topRect.height)
                    .position(x: cropper.topRect.origin.x, y: cropper.topRect.origin.y)
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3))
                Rectangle()
                    .frame(width: cropper.leftRect.width, height: cropper.leftRect.height)
                    .position(x: cropper.leftRect.origin.x, y: cropper.leftRect.origin.y)
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3))
                Rectangle()
                    .frame(width: cropper.bottomRect.width, height: cropper.bottomRect.height)
                    .position(x: cropper.bottomRect.origin.x, y: cropper.bottomRect.origin.y)
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3))
                Rectangle()
                    .frame(width: cropper.rightRect.width, height: cropper.rightRect.height)
                    .position(x: cropper.rightRect.origin.x, y: cropper.rightRect.origin.y)
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3))
            }
            Rectangle()
                .frame(width: min(cropper.parentSize.width, cropper.rect.width),
                       height: min(cropper.parentSize.height, cropper.rect.height))
                .foregroundColor(Color.white.opacity(0.05))
                .border(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), width: 3)
                .position(x: cropper.rect.origin.x, y: cropper.rect.origin.y)
                .overlay(
                    ZStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Rectangle()
                                    .frame(width: cropper.cornerLong, height: cropper.cornerShort)
                                Rectangle()
                                    .frame(width: cropper.cornerShort,
                                           height: cropper.cornerLong - cropper.cornerShort)
                            }
                            .position(x: cropper.topLeftCorner.x,
                                      y: cropper.topLeftCorner.y)
                            .gesture(DragGesture().onChanged { value in
                                cropper.topLeftCornerChange(location: value.location)
                                cropper.surroundingRectChange()
                            })
                        }
                        HStack {
                            VStack(alignment: .trailing, spacing: 0) {
                                Rectangle()
                                    .frame(width: cropper.cornerLong, height: cropper.cornerShort)
                                Rectangle()
                                    .frame(width: cropper.cornerShort,
                                           height: cropper.cornerLong - cropper.cornerShort)
                            }
                            .position(x: cropper.topRightCorner.x,
                                      y: cropper.topRightCorner.y)
                            .gesture(DragGesture().onChanged { value in
                                cropper.topRightCornerChange(location: value.location)
                                cropper.surroundingRectChange()
                            })
                        }
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Rectangle()
                                    .frame(width: cropper.cornerShort,
                                           height: cropper.cornerLong - cropper.cornerShort)
                                Rectangle()
                                    .frame(width: cropper.cornerLong, height: cropper.cornerShort)
                            }
                            .position(x: cropper.bottomLeftCorner.x,
                                      y: cropper.bottomLeftCorner.y)
                            .gesture(DragGesture().onChanged { value in
                                cropper.bottomLeftCornerChange(location: value.location)
                                cropper.surroundingRectChange()
                            })
                        }
                        HStack {
                            VStack(alignment: .trailing, spacing: 0) {
                                Rectangle()
                                    .frame(width: cropper.cornerShort,
                                           height: cropper.cornerLong - cropper.cornerShort)
                                Rectangle()
                                    .frame(width: cropper.cornerLong, height: cropper.cornerShort)
                            }
                            .position(x: cropper.bottomRightCorner.x,
                                      y: cropper.bottomRightCorner.y)
                            .gesture(DragGesture().onChanged { value in
                                cropper.bottomRightCornerChange(location: value.location)
                                cropper.surroundingRectChange()
                            })
                        }
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                )
            
        }
    }
}

struct ImageEditView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "ac84bcb7d0a20cf4800d77cc74094b36acaf990f")!
    static var previews: some View {
        ImageEditView(image: $image)
    }
}
