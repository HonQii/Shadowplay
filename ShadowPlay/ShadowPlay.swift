//
//  ShadowPlay.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/26.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit

public protocol ShadowPlayable {
    associatedtype WrapperType
    var sp: WrapperType { get }
}

public extension ShadowPlayable where Self: UIView {
    var sp: AnimationEngine { return AnimationEngine(with: self) }
}

public extension ShadowPlayable where Self: CALayer {
    var sp: AnimationEngine { return AnimationEngine(with: self) }
}

extension UIView: ShadowPlayable {}
extension CALayer: ShadowPlayable {}
