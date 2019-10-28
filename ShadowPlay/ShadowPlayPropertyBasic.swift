//
//  ShadowPlayPropertyBasic.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/26.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit



public struct ShadowPlayPropertyBasic: ShadowPlayContainer {    
    public let instance: ShadowPlayableView
    public var animation: CABasicAnimation = CABasicAnimation()

    public init(instance: ShadowPlayableView, keyPath: String) {
        self.instance = instance
        self.animation.keyPath = keyPath
    }
}



public protocol AnimationPropertyBasicConvenience {
    func value(from: Any?, to: Any?, by: Any?) -> Self
}

public extension AnimationPropertyBasicConvenience where Self: ShadowPlayAnimationContainer {
    private var basicAnimation: CABasicAnimation {
        return self.animation as! CABasicAnimation
    }
    
    func value(from: Any? = nil, to: Any? = nil, by: Any? = nil) -> Self {
        self.basicAnimation.fromValue = from
        self.basicAnimation.toValue = to
        self.basicAnimation.byValue = by
        return self
    }
}

extension ShadowPlayPropertyBasic: AnimationPropertyBasicConvenience {}
