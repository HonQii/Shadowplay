//
//  ShadowPlayTiming.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/27.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit


public protocol AnimationTimingConvenience {
    func start(time: CFTimeInterval, offset: CFTimeInterval) -> Self
    func `repeat`(count: Float, duration: CFTimeInterval) -> Self
    func duration(time: CFTimeInterval) -> Self
    func speed(value: Float) -> Self
    func playback(reverse: Bool, fill: CAMediaTimingFillMode) -> Self
}

public extension AnimationTimingConvenience where Self: ShadowPlayAnimationContainer {
    func start(time: CFTimeInterval = 0, offset: CFTimeInterval = 0) -> Self {
        animation.beginTime = time
        animation.timeOffset = offset
        return self
    }
    
    func `repeat`(count: Float = 0, duration: CFTimeInterval = 0) -> Self {
        animation.repeatCount = count
        animation.repeatDuration = duration
        return self
    }
    
    func duration(time: CFTimeInterval) -> Self {
        animation.duration = time
        return self
    }
    
    func speed(value: Float) -> Self {
        animation.speed = value
        return self
    }
    
    
    func playback(reverse: Bool = false, fill: CAMediaTimingFillMode = .removed) -> Self {
        animation.autoreverses = reverse
        animation.fillMode = fill
        return self
    }
}


extension ShadowPlayPropertyBasic: AnimationTimingConvenience {}
extension ShadowPlayPropertySpring: AnimationTimingConvenience {}
extension ShadowPlayPropertyKeyframe: AnimationTimingConvenience {}
extension ShadowPlayTransition: AnimationTimingConvenience {}
