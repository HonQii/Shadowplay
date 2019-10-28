//
//  ShadowPlay.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/26.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit

public protocol ShadowPlayableView {
    func add(_ anim: CAAnimation, forKey key: String?)
}

extension UIView: ShadowPlayableView {
    public func add(_ anim: CAAnimation, forKey key: String?) {
        self.layer.add(anim, forKey: key)
    }
}
extension CALayer: ShadowPlayableView {}




public protocol ShadowPlayable {
    associatedtype WrapperType
    var sp: WrapperType { get }
    static var sp: WrapperType.Type { get }
}

public extension ShadowPlayable where Self: ShadowPlayableView {
    var sp: ShadowPlay { return ShadowPlay(instance: self) }
    static var sp: ShadowPlay.Type { return ShadowPlay.self }
}

extension UIView: ShadowPlayable {}
extension CALayer: ShadowPlayable {}














struct AnimationConfig {
    
}









