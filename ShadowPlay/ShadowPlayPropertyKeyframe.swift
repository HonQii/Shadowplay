//
//  ShadowPlayPropertyKeyframe.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/26.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit



public struct ShadowPlayPropertyKeyframe: ShadowPlayContainer {
    public let instance: ShadowPlayableView
    public var animation: CAKeyframeAnimation = CAKeyframeAnimation()

    public init(instance: ShadowPlayableView, keypath: String) {
        self.instance = instance
        self.animation.keyPath = keypath
    }
}



public protocol AnimationPropertyKeyframeConvenience {
    func values(_ values: [Any]) -> Self
    func path(_ path: CGPath) -> Self
    func timing(times: [NSNumber]?, functions: [CAMediaTimingFunction]?, calcMode: CAAnimationCalculationMode) -> Self
    func rotation(mode: CAAnimationRotationMode) -> Self
    func cubic(tensions: [NSNumber]?, continuities: [NSNumber]?, biases: [NSNumber]?) -> Self
}

public extension AnimationPropertyKeyframeConvenience where Self: ShadowPlayAnimationContainer {
    private var keyframeAnimation: CAKeyframeAnimation {
        return animation as! CAKeyframeAnimation
    }
    
    func values(_ values: [Any]) -> Self {
        keyframeAnimation.values = values
        return self
    }
    
    func path(_ path: CGPath) -> Self {
        keyframeAnimation.path = path
        return self
    }
    
    func timing(times: [NSNumber]? = nil, functions: [CAMediaTimingFunction]? = nil, calcMode: CAAnimationCalculationMode = .linear) -> Self {
        keyframeAnimation.keyTimes = times
        keyframeAnimation.timingFunctions = functions
        keyframeAnimation.calculationMode = calcMode
        return self
    }
    
    func rotation(mode: CAAnimationRotationMode) -> Self {
        keyframeAnimation.rotationMode = mode
        return self
    }
    
    func cubic(tensions: [NSNumber]? = nil, continuities: [NSNumber]? = nil, biases: [NSNumber]? = nil) -> Self {
        keyframeAnimation.tensionValues = tensions
        keyframeAnimation.continuityValues = continuities
        keyframeAnimation.biasValues = biases
        return self
    }
}

extension ShadowPlayPropertyKeyframe: AnimationPropertyKeyframeConvenience {}
