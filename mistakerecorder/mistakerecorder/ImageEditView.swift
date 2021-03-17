//
//  ImageEditView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/14.
//

import SwiftUI

struct ImageEditView: View {
    @Binding var image: UIImage
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .overlay(GeometryReader { parentProxy in
                    CropperView(cropper: Cropper(parentProxy: parentProxy))
                })
                .padding(30)
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CropperView: View {
    @ObservedObject var cropper: Cropper
    
    var body: some View {
        ZStack {
            Text("x = \(cropper.rect.origin.x)\ny = \(cropper.rect.origin.y)\nwidth = \(cropper.rect.width)")
                .offset(y: 300)
            Rectangle()
                .frame(width: min(cropper.parentProxy.size.width, cropper.rect.width),
                       height: min(cropper.parentProxy.size.height, cropper.rect.height))
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
                                if value.location.x > (cropper.cornerLong / 2 - cropper.cornerShort) {
                                    cropper.bottomLeftCorner.x = min(value.location.x, cropper.bottomRightCorner.x - cropper.cornerLong)
                                    cropper.topLeftCorner.x = cropper.bottomLeftCorner.x
                                }
                                if value.location.y > cropper.cornerLong / 2 {
                                    cropper.bottomLeftCorner.y = min(max(value.location.y, cropper.topLeftCorner.y + cropper.cornerLong), cropper.parentProxy.size.height - (cropper.cornerLong / 2 - cropper.cornerShort))
                                    cropper.bottomRightCorner.y = cropper.bottomLeftCorner.y
                                }
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
                                if value.location.x > cropper.cornerLong / 2 {
                                    cropper.bottomRightCorner.x = min(max(value.location.x, cropper.bottomLeftCorner.x + cropper.cornerLong), cropper.parentProxy.size.width - (cropper.cornerLong / 2 - cropper.cornerShort))
                                    cropper.topRightCorner.x = cropper.bottomRightCorner.x
                                }
                                if value.location.y > cropper.cornerLong / 2 {
                                    cropper.bottomRightCorner.y = min(max(value.location.y, cropper.topRightCorner.y + cropper.cornerLong), cropper.parentProxy.size.height - (cropper.cornerLong / 2 - cropper.cornerShort))
                                    cropper.bottomLeftCorner.y = cropper.bottomRightCorner.y
                                }
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
