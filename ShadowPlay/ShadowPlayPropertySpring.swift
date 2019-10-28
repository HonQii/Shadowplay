//
//  ShadowPlayPropertySpring.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/26.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit


public struct ShadowPlayPropertySpring: ShadowPlayContainer {
    public let instance: ShadowPlayableView
    public var animation: CASpringAnimation = CASpringAnimation()

    public init(instance: ShadowPlayableView, keypath: String) {
        self.instance = instance
        self.animation.keyPath = keypath
    }
}




public protocol AnimationPropertySpringConvenience: AnimationPropertyBasicConvenience {
    func physical(velocity: CGFloat, damping: CGFloat, mass: CGFloat, stiffness: CGFloat) -> Self
}

public extension AnimationPropertySpringConvenience where Self: ShadowPlayAnimationContainer {
    private var springAnimation: CASpringAnimation {
        return animation as! CASpringAnimation
    }
    
    func physical(velocity: CGFloat = 0, damping: CGFloat = 10, mass: CGFloat = 0, stiffness: CGFloat = 100) -> Self {
        springAnimation.initialVelocity = velocity
        springAnimation.damping = damping
        springAnimation.mass = mass
        springAnimation.stiffness = stiffness
        return self
    }
}

extension ShadowPlayPropertySpring: AnimationPropertySpringConvenience {}



