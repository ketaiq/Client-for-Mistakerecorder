//
//  CropperView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/18.
//

import SwiftUI

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
