//
//  AnimationEngine.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/25.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit

open class AnimationEngine: NSObject {
    private lazy var animationNodes = AnimationNodes()
    private var currentIndex: Int = 0
    
    let animator: CALayer
    
    public init(with layer: CALayer) {
        animator = layer
    }
    
    public convenience init(with view: UIView) {
        self.init(with: view.layer)
    }
    
    @discardableResult
    public func series(_ animator: AnimationNode) -> AnimationEngine {
        animationNodes.append(animator)
        return self
    }
    
    @discardableResult
    public func concurrent(_ animators: AnimationNodes, options: AnimationOptions = [], callbacks: AnimationCallbacks = []) -> AnimationEngine {
        let group = AnimationNode.group(animators, options: options, callbacks: callbacks)
        animationNodes.append(group)
        return self
    }
    
    public func run() {
        let animation = convertNodeToAnimation(node: animationNodes[currentIndex])
        animation.delegate = self
        animator.add(animation, forKey: nil)
    }
    
    public func runToNext() {
        currentIndex += 1
        run()
    }
}

extension AnimationEngine: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        animationNodes[currentIndex].closures.forEach{ $0.startClosure?(anim) }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationNodes[currentIndex].closures.forEach{ $0.stopClosure?(anim, flag) }
        runToNext()
    }
}


extension AnimationEngine {
    func convertNodeToAnimation(node: AnimationNode) -> CAAnimation {
        guard case let .animation(prepareNode, options: opt, callbacks: _) = node.toAnimation else {
            fatalError("Animation Node Wried error")
        }
        
        var animation: CAAnimation!
        
        switch prepareNode {
        case .moveX(let x):
            animation = convertNodeToAnimation(node: .moveOrigin(CGPoint(x: x, y: 0)))
        case .moveY(let y):
            animation = convertNodeToAnimation(node: .moveOrigin(CGPoint(x: 0, y: y)))
        case .moveOrigin(let point):
            let key = "transform.translation"
            let current = animator.value(forKeyPath: key) as? CGSize ?? .zero
            let currentPoint = CGPoint(x: current.width, y: current.height)
            animation = convertNodeToAnimation(node: .basic(key: key, from: currentPoint, to: point + currentPoint))
        case .moveAnchor(let point):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.anchorPoint), from: animator.anchorPoint, to: point.normalized))
        case .moveZ(let z):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.anchorPointZ), from: animator.anchorPointZ, to: z))
        case .rotateZDegree(let degree):
            animation = convertNodeToAnimation(node: .rotateZRadian(degree.toRadian))
        case .rotateZRadian(let radian):
            let key = Rotate.z.keyPath
            let current = animation.value(forKeyPath: key) as? CGFloat ?? 0
            animation = convertNodeToAnimation(node: .basic(key: key, from: current, to: current + radian))
        case .rotateYDegree(let degree):
            animation = convertNodeToAnimation(node: .rotateYDegree(degree.toRadian))
        case .rotateYRadian(let radian):
            let key = Rotate.y.keyPath
            let current = animation.value(forKeyPath: key) as? CGFloat ?? 0
            animation = convertNodeToAnimation(node: .basic(key: key, from: current, to: current + radian))
        case .rotateXDegree(let degree):
            animation = convertNodeToAnimation(node: .rotateXRadian(degree.toRadian))
        case .rotateXRadian(let radian):
            let key = Rotate.x.keyPath
            let current = animation.value(forKeyPath: key) as? CGFloat ?? 0
            animation = convertNodeToAnimation(node: .basic(key: key, from: current, to: current + radian))
        case .scaleX(let scale):
            let key = Scale.x.keyPath
            let current = animator.value(forKeyPath: key) as? CGFloat ?? 1
            animation = convertNodeToAnimation(node: .basic(key: key, from: current, to: current + scale))
        case .scaleY(let scale):
            let key = Scale.y.keyPath
            let current = animator.value(forKeyPath: key) as? CGFloat ?? 1
            animation = convertNodeToAnimation(node: .basic(key: key, from: current, to: current + scale))
        case .scaleSize(let scale):
            let key = Scale.all.keyPath
            let current = animator.value(forKeyPath: key) as? CGFloat ?? 1
            animation = convertNodeToAnimation(node: .basic(key: key, from: current, to: current + scale))
        case .borderWidth(let width):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.borderWidth), from: animator.borderWidth, to: width))
        case .borderColor(let color):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.borderColor), from: animator.borderColor, to: color.cgColor))
        case .cornerRadius(let radius):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.cornerRadius), from: animator.cornerRadius, to: radius))
        case .maskToBounds(let clip):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.masksToBounds), from: animator.masksToBounds, to: clip))
        case .shadowOffset(let offset):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.shadowOffset), from: animator.shadowOffset, to: offset))
        case .shadowOpacity(let opacity):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.shadowOpacity), from: animator.shadowOpacity, to: opacity))
        case .shadowRadius(let radius):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.shadowRadius), from: animator.shadowRadius, to: radius))
        case .shadowColor(let color):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.shadowColor), from: animator.shadowColor, to: color))
        case .shadowPath(let path):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.shadowPath), from: animator.shadowPath, to: path))
        case .hidden(let isHide):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.isHidden), from: animator.isHidden, to: isHide))
        case .opacity(let val):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.opacity), from: animator.opacity, to: val))
        case .zPosition(let val):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.zPosition), from: animator.zPosition, to: val))
        case .backgroundColor(let color):
            animation = convertNodeToAnimation(node: .basic(key: #keyPath(CALayer.backgroundColor), from: animator.backgroundColor, to: color.cgColor))
        case .basic(key: let key, from: let from, to: let to, by: let by, extras: _):
            let basic = CABasicAnimation(keyPath: key)
            basic.fromValue = from
            basic.toValue = to
            basic.byValue = by
            animation = basic
        case .spring(key: let key, from: let from, to: let to, by: let by, extras: _):
            let spring = CASpringAnimation(keyPath: key)
            spring.fromValue = from
            spring.toValue = to
            spring.byValue = by
            animation = spring
        case .keyframe(key: let key, values: let vals, keyTimes: let times, path: let path, extras: _):
            let keyframe = CAKeyframeAnimation(keyPath: key)
            keyframe.values = vals
            keyframe.keyTimes = times
            keyframe.path = path
            animation = keyframe
        case .transition(type: let type, subtype: let subtype, start: let start, end: let end, extras: _):
            let transition = CATransition()
            transition.type = type
            transition.subtype = subtype
            if let start = start { transition.startProgress = start }
            if let end = end { transition.endProgress = end }
            animation = transition
        case .group(let nodes, options: _, callbacks: _):
            let group = CAAnimationGroup()
            group.animations = nodes.map{ convertNodeToAnimation(node: $0) }
            animation = group
        case .animation(_, options: _, callbacks: _):
            fatalError("Animation Node Wried error")
        }
        
        opt.forEach{ $0.inject(to: animation) }
        return animation
    }
    
    
    enum Rotate: String {
        case x
        case y
        case z
        
        var keyPath: String { return "transform.rotation.\(rawValue)" }
    }

    enum Scale: String {
        case x = "x"
        case y = "y"
        case all = ""
        
        var keyPath: String {
            let val = rawValue
            return val.isEmpty ? "transform.scale" : "transform.scale.\(val)"
        }
    }
}



