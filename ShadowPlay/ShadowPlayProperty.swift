//
//  ShadowPlayProperty.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/26.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//
import UIKit


public struct ShadowPlayProperty: ShadowPlayInstanceContainer  {
    public let instance: ShadowPlayableView
    internal let keyPath: String!

    public init(instance: ShadowPlayableView, property: String) {
        self.instance = instance
        self.keyPath = property
    }


    public var basic: ShadowPlayPropertyBasic {
        return ShadowPlayPropertyBasic(instance: instance, keyPath: keyPath)
    }

    
    public var spring: ShadowPlayPropertySpring {
        return ShadowPlayPropertySpring(instance: instance, keypath: keyPath)
    }

    public var keyframe: ShadowPlayPropertyKeyframe {
        return ShadowPlayPropertyKeyframe(instance: instance, keypath: keyPath)
    }
}



public protocol AnimationPropertyConvenience {
    func calculation(isAdd: Bool, isCum: Bool, valueFunction: CAValueFunction?) -> Self
}

public extension AnimationPropertyConvenience where Self: ShadowPlayAnimationContainer {
    private var propertyAnimation: CAPropertyAnimation {
        return self.animation as! CAPropertyAnimation
    }

    func calculation(isAdd: Bool = false, isCum: Bool = false, valueFunction: CAValueFunction? = nil) -> Self {
        self.propertyAnimation.isAdditive = isAdd
        self.propertyAnimation.isCumulative = isCum
        self.propertyAnimation.valueFunction = valueFunction
        return self
    }
}

extension ShadowPlayPropertyBasic: AnimationPropertyConvenience {}
extension ShadowPlayPropertySpring: AnimationPropertyConvenience {}
extension ShadowPlayPropertyKeyframe: AnimationPropertyConvenience {}
