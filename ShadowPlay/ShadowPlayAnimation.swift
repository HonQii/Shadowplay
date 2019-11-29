//
//  ShadowPlayAnimation.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/27.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit

private class AnimationDelegateProxy: NSObject, CAAnimationDelegate {
    var didStartClosure: ((_ animation: CAAnimation) -> Void)?
    var didStopClosure: ((_ animation: CAAnimation, _ finished: Bool) -> Void)?
    
    func animationDidStart(_ anim: CAAnimation) {
        if let start = didStartClosure {
            start(anim)
        }
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let stop = didStopClosure {
            stop(anim, flag)
        }
    }
}

public protocol AnimationConvenience {
    func onCompletion(isRemoved: Bool) -> Self
    func timingFunction(_ function: CAMediaTimingFunction) -> Self
    func didStart(_ closure: @escaping (_ animation: CAAnimation) -> Void) -> Self
    func didStop(_ closure:  @escaping (_ animation: CAAnimation, _ finished: Bool) -> Void) -> Self
}

var kAnimationProxyKey = "kAnimationProxyKey"

public extension AnimationConvenience where Self: ShadowPlayContainer  {
    private var animationProxy: AnimationDelegateProxy {
        if let obj = objc_getAssociatedObject(self.instance, &kAnimationProxyKey) as? AnimationDelegateProxy {
            return obj
        }
        let obj = AnimationDelegateProxy()
        objc_setAssociatedObject(self.instance, &kAnimationProxyKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return obj
    }
    
    func onCompletion(isRemoved: Bool) -> Self {
        animation.isRemovedOnCompletion = isRemoved
        return self
    }
    
    func timingFunction(_ function: CAMediaTimingFunction) -> Self {
        animation.timingFunction = function
        return self
    }
    
    func didStart(_ closure: @escaping (_ animation: CAAnimation) -> Void) -> Self {
        if animation.delegate == nil {
            animation.delegate = animationProxy
        }
        animationProxy.didStartClosure = closure
        return self
    }

    func didStop(_ closure: @escaping (_ animation: CAAnimation, _ finished: Bool) -> Void) -> Self {
        if animation.delegate == nil {
            animation.delegate = animationProxy
        }
        animationProxy.didStopClosure = closure
        return self
    }
}


extension ShadowPlayPropertyBasic: AnimationConvenience {}
extension ShadowPlayPropertySpring: AnimationConvenience {}
extension ShadowPlayPropertyKeyframe: AnimationConvenience {}
extension ShadowPlayTransition: AnimationConvenience {}
