//
//  ShadowPlayAnimation.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/27.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit

public protocol AnimationConvenience {
    func onCompletion(isRemoved: Bool) -> Self
    func timingFunction(_ function: CAMediaTimingFunction) -> Self
//    func didStart(_ closure: (_ animation: CAAnimation) -> Void) -> Self
//    func didStop(_ closure: (_ animation: CAAnimation, _ finished: Bool) -> Void) -> Self
}


public extension AnimationConvenience where Self: ShadowPlayContainer  {
    func onCompletion(isRemoved: Bool) -> Self {
        animation.isRemovedOnCompletion = isRemoved
        return self
    }
    
    func timingFunction(_ function: CAMediaTimingFunction) -> Self {
        animation.timingFunction = function
        return self
    }
    
//    func didStart(_ closure: @escaping (_ animation: CAAnimation) -> Void) -> Self {
//        if animation.delegate == nil {
//            animation.delegate = instance
//        }
//        delegateProxy.didStartClosure = closure
//        return self
//    }
//
//    func didStop(_ closure: @escaping (_ animation: CAAnimation, _ finished: Bool) -> Void) -> Self {
//        if animation.delegate == nil {
//            animation.delegate = delegateProxy
//        }
//        delegateProxy.didStopClosure = closure
//        return self
//    }
}


extension ShadowPlayPropertyBasic: AnimationConvenience {}
extension ShadowPlayPropertySpring: AnimationConvenience {}
extension ShadowPlayPropertyKeyframe: AnimationConvenience {}
extension ShadowPlayTransition: AnimationConvenience {}


public class AnimationDelegateProxy: NSObject, CAAnimationDelegate {
    var didStartClosure: ((_ animation: CAAnimation) -> Void)?
    var didStopClosure: ((_ animation: CAAnimation, _ finished: Bool) -> Void)?
    
    public func animationDidStart(_ anim: CAAnimation) {
        if let start = didStartClosure {
            start(anim)
        }
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let stop = didStopClosure {
            stop(anim, flag)
        }
    }
}
