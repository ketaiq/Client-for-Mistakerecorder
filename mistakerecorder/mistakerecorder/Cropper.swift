//
//  Cropper.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/16.
//

import Foundation
import SwiftUI

class Cropper: ObservableObject {
    let cornerLong: CGFloat = 30
    let cornerShort: CGFloat = 5
    @Published var parentProxy: GeometryProxy
    @Published var rect: CGRect
    @Published var topLeftCorner: CGPoint
    @Published var topRightCorner: CGPoint
    @Published var bottomLeftCorner: CGPoint
    @Published var bottomRightCorner: CGPoint
    
    init(parentProxy: GeometryProxy) {
        self.parentProxy = parentProxy
        self.rect = CGRect(x: parentProxy.size.width / 2,
                           y: parentProxy.size.height / 2,
                           width: parentProxy.size.width,
                           height: parentProxy.size.height)
        self.topLeftCorner = CGPoint(x: self.cornerLong / 2 - self.cornerShort,
                                     y: self.cornerLong / 2 - self.cornerShort)
        self.topRightCorner = CGPoint(x: parentProxy.size.width - (self.cornerLong / 2 - self.cornerShort),
                                      y: self.cornerLong / 2 - self.cornerShort)
        self.bottomLeftCorner = CGPoint(x: self.cornerLong / 2 - self.cornerShort,
                                        y: parentProxy.size.height - (self.cornerLong / 2 - self.cornerShort))
        self.bottomRightCorner = CGPoint(x: parentProxy.size.width - (self.cornerLong / 2 - self.cornerShort),
                                         y: parentProxy.size.height - (self.cornerLong / 2 - self.cornerShort))
    }
    
    func topLeftCornerChange(location: CGPoint) {
        if location.x > (self.cornerLong / 2 - self.cornerShort) {
            // 更新对应边角的x坐标
            let originalX = self.topLeftCorner.x
            self.topLeftCorner.x = min(location.x, self.topRightCorner.x - self.cornerLong)
            // 更新方框的宽和x坐标
            let originalRectWidth = self.rect.size.width
            if self.topLeftCorner.x > originalX { // 从左向右移动
                self.rect.size.width -= self.topLeftCorner.x - originalX
                self.rect.origin.x += originalRectWidth / 2 - self.rect.size.width / 2
            } else { // 从右向左移动
                
            }
        } else {
            self.topLeftCorner.x = self.cornerLong / 2 - self.cornerShort
        }
        self.bottomLeftCorner.x = self.topLeftCorner.x
        
//        if location.y > (self.cornerLong / 2 - self.cornerShort) {
//            let originalY = self.topLeftCorner.y
//            self.topLeftCorner.y = min(location.y, self.bottomLeftCorner.y - self.cornerLong)
//        } else {
//            self.topLeftCorner.y = self.cornerLong / 2 - self.cornerShort
//        }
//        self.topRightCorner.y = self.topLeftCorner.y
    }
}
