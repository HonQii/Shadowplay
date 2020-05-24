//
//  AnimationCallbacks.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/27.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit

public typealias AnimationCallbackStart = (CAAnimation)->Void
public typealias AnimationCallbackStop = (CAAnimation, Bool)->Void

public enum AnimationCallback {
    case start(_ closure: AnimationCallbackStart? = nil)
    case stop(_ closure: AnimationCallbackStop? = nil)
    
    
    internal var startClosure: AnimationCallbackStart? {
        switch self {
        case .start(let closure):
            return closure
        default:
            return nil
        }
    }
    
    internal var stopClosure: AnimationCallbackStop? {
        switch self {
        case .stop(let closure):
            return closure
        default:
            return nil
        }
    }
}

public typealias AnimationCallbacks = Array<AnimationCallback>

