//
//  ShadowPlayContainer.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/25.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit


public protocol ShadowPlayInstanceContainer {
    var instance: ShadowPlayableView { get }
}


public protocol ShadowPlayAnimationContainer {
    associatedtype AnimationType where AnimationType: CAAnimation
    var animation: AnimationType { get }
}

public protocol ShadowPlayContainer: ShadowPlayInstanceContainer, ShadowPlayAnimationContainer {
    func run(_ key: String?)
}
extension ShadowPlayContainer {
    public func run(_ key: String? = nil) {
        instance.add(animation, forKey: key)
    }
}


public struct ShadowPlay: ShadowPlayInstanceContainer {
    public let instance: ShadowPlayableView
    public init(instance: ShadowPlayableView) { self.instance = instance }
    
    public func property(_ keyPath: String) -> ShadowPlayProperty {
        return ShadowPlayProperty(instance: instance, property: keyPath)
    }
    
    public func group() {
        
    }
    
    public var transition: ShadowPlayTransition {
        return ShadowPlayTransition(instance: instance)
    }
}
