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
        // 更新对应边角的x坐标
        let originalX = self.topLeftCorner.x
        self.topLeftCorner.x = min(max(location.x, self.cornerLong / 2 - self.cornerShort), self.topRightCorner.x - self.cornerLong)
        // 更新方框的宽和x坐标
        let originalRectWidth = self.rect.size.width
        if self.topLeftCorner.x > originalX { // 从左向右移动
            self.rect.size.width -= self.topLeftCorner.x - originalX
            self.rect.origin.x += originalRectWidth / 2 - self.rect.size.width / 2
        } else { // 从右向左移动
            self.rect.size.width += originalX - self.topLeftCorner.x
            self.rect.origin.x -= self.rect.size.width / 2 - originalRectWidth / 2
        }
        self.bottomLeftCorner.x = self.topLeftCorner.x
        
        // 更新对应边角的y坐标
        let originalY = self.topLeftCorner.y
        self.topLeftCorner.y = min(max(location.y, self.cornerLong / 2 - self.cornerShort), self.bottomLeftCorner.y - self.cornerLong)
        // 更新方框的高和y坐标
        let originalRectHeight = self.rect.size.height
        if self.topLeftCorner.y > originalY { // 从上向下移动
            self.rect.size.height -= self.topLeftCorner.y - originalY
            self.rect.origin.y += originalRectHeight / 2 - self.rect.size.height / 2
        } else { // 从下向上移动
            self.rect.size.height += originalY - self.topLeftCorner.y
            self.rect.origin.y -= self.rect.size.height / 2 - originalRectHeight / 2
        }
        self.topRightCorner.y = self.topLeftCorner.y
    }
    
    func topRightCornerChange(location: CGPoint) {
        // 更新对应边角x坐标
        let originalX = self.topRightCorner.x
        self.topRightCorner.x = min(max(location.x, self.topLeftCorner.x + self.cornerLong), self.parentProxy.size.width - (self.cornerLong / 2 - self.cornerShort))
        // 更新方框的宽和x坐标
        let originalRectWidth = self.rect.size.width
        if self.topRightCorner.x > originalX { // 从左向右移动
            self.rect.size.width += self.topRightCorner.x - originalX
            self.rect.origin.x += self.rect.size.width / 2 - originalRectWidth / 2
        } else { // 从右向左移动
            self.rect.size.width -= originalX - self.topRightCorner.x
            self.rect.origin.x -= originalRectWidth / 2 - self.rect.size.width / 2
        }
        self.bottomRightCorner.x = self.topRightCorner.x
        
        // 更新对应边角的y坐标
        let originalY = self.topRightCorner.y
        self.topRightCorner.y = min(max(location.y, self.cornerLong / 2 - self.cornerShort), self.bottomRightCorner.y - self.cornerLong)
        // 更新方框的高和y坐标
        let originalRectHeight = self.rect.size.height
        if self.topRightCorner.y > originalY { // 从上向下移动
            self.rect.size.height -= self.topRightCorner.y - originalY
            self.rect.origin.y += originalRectHeight / 2 - self.rect.size.height / 2
        } else { // 从下向上移动
            self.rect.size.height += originalY - self.topRightCorner.y
            self.rect.origin.y -= self.rect.size.height / 2 - originalRectHeight / 2
        }
        self.topLeftCorner.y = self.topRightCorner.y
    }
}
