//
//  Extensions.swift
//  ShadowPlay
//
//  Created by HonQi on 2020/5/24.
//  Copyright © 2020 HonQi Indie. All rights reserved.
//

import UIKit


internal extension FloatingPoint {
    var toRadian: Self { return self * .pi / 180 }
    var toDegree: Self { return self * 180 / .pi }
}


internal extension CGPoint {
    var length: CGFloat {
        return sqrt(x * x + y * y)
    }
    
    /// scale CGPoint to 0 ~ 1.0
    var normalized: CGPoint {
        let len = self.length
        return len > 0 ? self / len : .zero
    }
    
    static func / (lhs: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / scalar, y: lhs.y / scalar)
    }
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
