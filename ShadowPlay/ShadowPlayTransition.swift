//
//  ShadowPlayTransition.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/27.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit



public struct ShadowPlayTransition: ShadowPlayContainer {
    public var instance: ShadowPlayableView
    public let animation = CATransition()
}




public protocol AnimationTransitionConvenience {
    func progress(start: Float, end: Float) -> Self
    func type(_ type: CATransitionType) -> Self
    func subtype(_ type: CATransitionSubtype) -> Self
    func value(_ closure: (_ view: ShadowPlayableView)->Void) -> Self
}

extension AnimationTransitionConvenience where Self: ShadowPlayAnimationContainer {
    private var transitionAnimation: CATransition {
        return animation as! CATransition
    }
    
    public func progress(start: Float = 0, end: Float = 1) -> Self {
        transitionAnimation.startProgress = start
        transitionAnimation.endProgress = end
        return self
    }
    
    public func type(_ type: CATransitionType) -> Self {
        transitionAnimation.type = type
        return self
    }
    
    public func subtype(_ type: CATransitionSubtype) -> Self {
        transitionAnimation.subtype = type
        return self
    }
}

extension AnimationTransitionConvenience where Self: ShadowPlayInstanceContainer {
    public func value(_ closure: (_ view: ShadowPlayableView)->Void) -> Self {
        closure(instance)
        return self
    }
}


extension ShadowPlayTransition: AnimationTransitionConvenience {}
