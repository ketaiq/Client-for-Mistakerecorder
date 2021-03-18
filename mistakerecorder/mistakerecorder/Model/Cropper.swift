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
    @Published var parentSize: CGSize
    @Published var rect: CGRect
    @Published var topLeftCorner: CGPoint
    @Published var topRightCorner: CGPoint
    @Published var bottomLeftCorner: CGPoint
    @Published var bottomRightCorner: CGPoint
    @Published var topRect: CGRect
    @Published var leftRect: CGRect
    @Published var bottomRect: CGRect
    @Published var rightRect: CGRect
    
    init(parentSize: CGSize) {
        self.parentSize = parentSize
        self.rect = CGRect(x: parentSize.width / 2,
                           y: parentSize.height / 2,
                           width: parentSize.width,
                           height: parentSize.height)
        self.topLeftCorner = CGPoint(x: self.cornerLong / 2 - self.cornerShort,
                                     y: self.cornerLong / 2 - self.cornerShort)
        self.topRightCorner = CGPoint(x: parentSize.width - (self.cornerLong / 2 - self.cornerShort),
                                      y: self.cornerLong / 2 - self.cornerShort)
        self.bottomLeftCorner = CGPoint(x: self.cornerLong / 2 - self.cornerShort,
                                        y: parentSize.height - (self.cornerLong / 2 - self.cornerShort))
        self.bottomRightCorner = CGPoint(x: parentSize.width - (self.cornerLong / 2 - self.cornerShort),
                                         y: parentSize.height - (self.cornerLong / 2 - self.cornerShort))
        self.topRect = CGRect.zero
        self.leftRect = CGRect.zero
        self.bottomRect = CGRect.zero
        self.rightRect = CGRect.zero
    }
    
    func update(parentSize: CGSize) {
        self.parentSize = parentSize
        self.rect = CGRect(x: parentSize.width / 2,
                           y: parentSize.height / 2,
                           width: parentSize.width,
                           height: parentSize.height)
        self.topLeftCorner = CGPoint(x: self.cornerLong / 2 - self.cornerShort,
                                     y: self.cornerLong / 2 - self.cornerShort)
        self.topRightCorner = CGPoint(x: parentSize.width - (self.cornerLong / 2 - self.cornerShort),
                                      y: self.cornerLong / 2 - self.cornerShort)
        self.bottomLeftCorner = CGPoint(x: self.cornerLong / 2 - self.cornerShort,
                                        y: parentSize.height - (self.cornerLong / 2 - self.cornerShort))
        self.bottomRightCorner = CGPoint(x: parentSize.width - (self.cornerLong / 2 - self.cornerShort),
                                         y: parentSize.height - (self.cornerLong / 2 - self.cornerShort))
        self.topRect = CGRect.zero
        self.leftRect = CGRect.zero
        self.bottomRect = CGRect.zero
        self.rightRect = CGRect.zero
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
        self.topRightCorner.x = min(max(location.x, self.topLeftCorner.x + self.cornerLong), self.parentSize.width - (self.cornerLong / 2 - self.cornerShort))
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
    
    func bottomLeftCornerChange(location: CGPoint) {
        // 更新对应边角x坐标
        let originalX = self.bottomLeftCorner.x
        self.bottomLeftCorner.x = min(max(location.x, self.cornerLong / 2 - self.cornerShort), self.bottomRightCorner.x - self.cornerLong)
        // 更新方框的宽和x坐标
        let originalRectWidth = self.rect.size.width
        if self.bottomLeftCorner.x > originalX { // 从左向右移动
            self.rect.size.width -= self.bottomLeftCorner.x - originalX
            self.rect.origin.x += originalRectWidth / 2 - self.rect.size.width / 2
        } else { // 从右向左移动
            self.rect.size.width += originalX - self.bottomLeftCorner.x
            self.rect.origin.x -= self.rect.size.width / 2 - originalRectWidth / 2
        }
        self.topLeftCorner.x = self.bottomLeftCorner.x
        
        // 更新对应边角的y坐标
        let originalY = self.bottomLeftCorner.y
        self.bottomLeftCorner.y = min(max(location.y, self.topLeftCorner.y + self.cornerLong), self.parentSize.height - (self.cornerLong / 2 - self.cornerShort))
        // 更新方框的高和y坐标
        let originalRectHeight = self.rect.size.height
        if self.bottomLeftCorner.y > originalY { // 从上向下移动
            self.rect.size.height += self.bottomLeftCorner.y - originalY
            self.rect.origin.y += self.rect.size.height / 2 - originalRectHeight / 2
        } else { // 从下向上移动
            self.rect.size.height -= originalY - self.bottomLeftCorner.y
            self.rect.origin.y -= originalRectHeight / 2 - self.rect.size.height / 2
        }
        self.bottomRightCorner.y = self.bottomLeftCorner.y
    }
    
    func bottomRightCornerChange(location: CGPoint) {
        // 更新对应边角x坐标
        let originalX = self.bottomRightCorner.x
        self.bottomRightCorner.x = min(max(location.x, self.bottomLeftCorner.x + self.cornerLong), self.parentSize.width - (self.cornerLong / 2 - self.cornerShort))
        // 更新方框的宽和x坐标
        let originalRectWidth = self.rect.size.width
        if self.bottomRightCorner.x > originalX { // 从左向右移动
            self.rect.size.width += self.bottomRightCorner.x - originalX
            self.rect.origin.x += self.rect.size.width / 2 - originalRectWidth / 2
        } else { // 从右向左移动
            self.rect.size.width -= originalX - self.bottomRightCorner.x
            self.rect.origin.x -= originalRectWidth / 2 - self.rect.size.width / 2
        }
        self.topRightCorner.x = self.bottomRightCorner.x
        
        // 更新对应边角的y坐标
        let originalY = self.bottomRightCorner.y
        self.bottomRightCorner.y = min(max(location.y, self.topRightCorner.y + self.cornerLong), self.parentSize.height - (self.cornerLong / 2 - self.cornerShort))
        // 更新方框的高和y坐标
        let originalRectHeight = self.rect.size.height
        if self.bottomRightCorner.y > originalY { // 从上向下移动
            self.rect.size.height += self.bottomRightCorner.y - originalY
            self.rect.origin.y += self.rect.size.height / 2 - originalRectHeight / 2
        } else { // 从下向上移动
            self.rect.size.height -= originalY - self.bottomRightCorner.y
            self.rect.origin.y -= originalRectHeight / 2 - self.rect.size.height / 2
        }
        self.bottomLeftCorner.y = self.bottomRightCorner.y
    }
    
    func surroundingRectChange() {
        self.topRect = CGRect(x: self.parentSize.width / 2,
                              y: (self.topLeftCorner.y - (self.cornerLong / 2 - self.cornerShort)) / 2,
                              width: self.parentSize.width,
                              height: self.topLeftCorner.y - (self.cornerLong / 2 - self.cornerShort))
        self.leftRect = CGRect(x: (self.topLeftCorner.x - (self.cornerLong / 2 - self.cornerShort)) / 2,
                               y: self.topLeftCorner.y + (self.bottomLeftCorner.y - self.topLeftCorner.y) / 2,
                               width: self.topLeftCorner.x - (self.cornerLong / 2 - self.cornerShort),
                               height: self.bottomLeftCorner.y - self.topLeftCorner.y + (self.cornerLong / 2 - self.cornerShort) + (self.cornerLong / 2 - self.cornerShort))
        self.bottomRect = CGRect(x: self.parentSize.width / 2,
                                 y: self.bottomLeftCorner.y + (self.cornerLong / 2 - self.cornerShort) + (self.parentSize.height - self.bottomLeftCorner.y - (self.cornerLong / 2 - self.cornerShort)) / 2,
                                 width: self.parentSize.width,
                                 height: self.parentSize.height - self.bottomLeftCorner.y - (self.cornerLong / 2 - self.cornerShort))
        self.rightRect = CGRect(x: self.topRightCorner.x + (self.cornerLong / 2 - self.cornerShort) + (self.parentSize.width - self.topRightCorner.x - (self.cornerLong / 2 - self.cornerShort)) / 2,
                                y: self.topRightCorner.y + (self.bottomRightCorner.y - self.topRightCorner.y) / 2,
                                width: self.parentSize.width - self.topRightCorner.x - (self.cornerLong / 2 - self.cornerShort),
                                height: self.bottomRightCorner.y - self.topRightCorner.y + (self.cornerLong / 2 - self.cornerShort) + (self.cornerLong / 2 - self.cornerShort))
    }
}
