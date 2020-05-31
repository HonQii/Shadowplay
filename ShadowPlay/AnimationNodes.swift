//
//  AnimationNodes.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/26.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//
import UIKit


public indirect enum AnimationNode {
    case moveX(CGFloat)
    case moveY(CGFloat)
    case moveOrigin(CGPoint)
    case moveAnchor(CGPoint)
    case moveZ(CGFloat)

    case rotateXRadian(CGFloat)
    case rotateXDegree(CGFloat)
    case rotateYRadian(CGFloat)
    case rotateYDegree(CGFloat)
    case rotateZRadian(CGFloat)
    case rotateZDegree(CGFloat)
    
    case scaleSize(CGFloat)
    case scaleX(CGFloat)
    case scaleY(CGFloat)
    
    case borderColor(UIColor)
    case borderWidth(CGFloat)
    case cornerRadius(CGFloat)
    case maskToBounds(Bool)
    
    case shadowColor(UIColor)
    case shadowOpacity(Float)
    case shadowRadius(CGFloat)
    case shadowPath(CGPath)
    case shadowOffset(CGSize)
    
    case hidden(Bool)
    case opacity(Float)
    case zPosition(CGFloat)
    
    case backgroundColor(UIColor)
    
    case basic(key: String, from: Any? = nil, to: Any? = nil, by: Any? = nil, extras: AnimationOptions = [])
    case spring(key: String, from: Any? = nil, to: Any? = nil, by: Any? = nil, extras: AnimationOptions = [])
    case keyframe(key: String, values: [Any]? = nil, keyTimes: [NSNumber]? = nil, path: CGPath? = nil, extras: AnimationOptions = [])
    case transition(type: CATransitionType, subtype: CATransitionSubtype? = nil, start: Float? = nil, end: Float? = nil, extras: AnimationOptions = [])
    
    case group(_ animations: AnimationNodes, options: AnimationOptions = [], callbacks: AnimationCallbacks = [])
    case animation(_ animation: AnimationNode, options: AnimationOptions = [], callbacks: AnimationCallbacks = [])
    
    
    public func options(_ vals: AnimationOption...) -> AnimationNode {
        return options(vals)
    }
    
    public func options(_ vals: AnimationOptions) -> AnimationNode {
        switch self {
        case .animation(let ani, options: let opt, callbacks: let call):
            var tmp = Array(opt)
            tmp.append(contentsOf: vals)
            return .animation(ani, options: tmp, callbacks: call)
        default:
            return toAnimation.options(vals)
        }
    }
    
    
    public func callbacks(_ vals: AnimationCallback...) -> AnimationNode {
        return callbacks(vals)
    }
    
    public func callbacks(_ vals: AnimationCallbacks) -> AnimationNode {
        switch self {
        case .animation(let ani, options: let opt, callbacks: let call):
            var tmp = Array(call)
            tmp.append(contentsOf: vals)
            return .animation(ani, options: opt, callbacks: tmp)
        default:
            return toAnimation.callbacks(vals)
        }
    }
    
    
    internal var toAnimation: AnimationNode {
        switch self {
        case .basic(key: let key, from: let from, to: let to, by: let by, extras: let opt):
            return .animation(.basic(key: key, from: from, to: to, by: by, extras: []), options: opt)
        case .spring(key: let key, from: let from, to: let to, by: let by, extras: let opt):
            return .animation(.spring(key: key, from: from, to: to, by: by, extras: []), options: opt)
        case .keyframe(key: let key, values: let vals, keyTimes: let times, path: let path, extras: let opt):
            return .animation(.keyframe(key: key, values: vals, keyTimes: times, path: path, extras: []), options: opt)
        case .transition(type: let type, subtype: let subtype, start: let start, end: let end, extras: let opt):
            return .animation(.transition(type: type, subtype: subtype, start: start, end: end, extras: []), options: opt)
        case .group(let nodes, options: let opt, callbacks: let callbacks):
            return .animation(.group(nodes, options: [], callbacks: []), options: opt, callbacks: callbacks)
        case .animation(_, options: _, callbacks: _):
            return self
        default:
            return .animation(self)
        }
    }
    
    internal var closures: AnimationCallbacks {
        switch self {
        case .animation(_, options: _, callbacks: let calls):
            return calls
        default:
            return toAnimation.closures
        }
    }
}

public typealias AnimationNodes = Array<AnimationNode>
