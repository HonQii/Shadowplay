//
//  AnimationOptions.swift
//  ShadowPlay
//
//  Created by HonQi on 2019/10/27.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit


public enum AnimationOption {
    /// Timing
    case beginTime(_ time: CFTimeInterval)
    case timeOffset(_ offset: CFTimeInterval)
    case repeatCount(_ count: Float)
    case repeatDuration(_ duratio: CFTimeInterval)
    case duration(_ duration: CFTimeInterval)
    case speed(_ speed: Float)
    case autoReverses(_ reverse: Bool)
    case fillMode(_ mode: CAMediaTimingFillMode)
    
    
    /// Animation
    case removeOnCompletion(_ isRemove: Bool)
    case function(_ function: AnimationFunction)
    case timingFunction(_ function: CAMediaTimingFunction)
    
    /// Property
    case cumulative(_ isCum: Bool)
    case additive(_ isAdd: Bool)
    case valueFunction(_ function: CAValueFunction)
    
    /// Spring
    case damping(_ damp: CGFloat)
    case velocity(_ velocity: CGFloat)
    case mass(_ mass: CGFloat)
    case stiffness(_ val: CGFloat)
    
    /// Keyframe
    case calculationMode(_ mode: CAAnimationCalculationMode)
    case rotationMode(_ mode: CAAnimationRotationMode)
    case keyframeFunctions(_ functions: AnimationFunctions)
    case keyTimingFunctions(_ functions: [CAMediaTimingFunction])
    case tensionValues(_ values: [NSNumber])
    case continuityValues(_ values: [NSNumber])
    case biasValues(_ values: [NSNumber])
    
    
    @discardableResult
    func inject(to animator: CAAnimation) -> CAAnimation {
        switch self {
        /// Timing
        case .beginTime(let time):
            animator.beginTime = time
        case .timeOffset(let offset):
            animator.beginTime = offset
        case .repeatCount(let count):
            animator.repeatCount = count
        case .repeatDuration(let duration):
            animator.repeatDuration = duration
        case .duration(let duration):
            animator.duration = duration
        case .speed(let speed):
            animator.speed = speed
        case .autoReverses(let reverse):
            animator.autoreverses = reverse
        case .fillMode(let mode):
            animator.fillMode = mode
            
        /// Animation
        case .removeOnCompletion(let isRemove):
            animator.isRemovedOnCompletion = isRemove
        case .function(let function):
            animator.timingFunction = function.timingFunction
        case .timingFunction(let function):
            animator.timingFunction = function
            
        /// Property
        case .cumulative(let isCum):
            if let animator = animator as? CAPropertyAnimation {
                animator.isCumulative = isCum
            }
        case .additive(let isAdd):
            if let animator = animator as? CAPropertyAnimation {
                animator.isAdditive = isAdd
            }
        case .valueFunction(let function):
            if let animator = animator as? CAPropertyAnimation {
                animator.valueFunction = function
            }
            
        /// Spring
        case .damping(let damp):
            if let animator = animator as? CASpringAnimation {
                animator.damping = damp
            }
        case .velocity(let velo):
            if let animator = animator as? CASpringAnimation {
                animator.initialVelocity = velo
            }
        case .mass(let mass):
            if let animator = animator as? CASpringAnimation {
                animator.mass = mass
            }
        case .stiffness(let stiff):
            if let animator = animator as? CASpringAnimation {
                animator.stiffness = stiff
            }
        
            
        /// Keyframe
        case .calculationMode(let mode):
            if let animator = animator as? CAKeyframeAnimation {
                animator.calculationMode = mode
            }
        case .rotationMode(let mode):
            if let animator = animator as? CAKeyframeAnimation {
                animator.rotationMode = mode
            }
        case .keyframeFunctions(let functions):
            if let animator = animator as? CAKeyframeAnimation {
                animator.timingFunctions = functions.compactMap{ $0.timingFunction }
            }
        case .keyTimingFunctions(let functions):
            if let animator = animator as? CAKeyframeAnimation {
                animator.timingFunctions = functions
            }
        case .tensionValues(let values):
            if let animator = animator as? CAKeyframeAnimation {
                animator.tensionValues = values
            }
        case .continuityValues(let values):
            if let animator = animator as? CAKeyframeAnimation {
                animator.continuityValues = values
            }
        case .biasValues(let values):
            if let animator = animator as? CAKeyframeAnimation {
                animator.biasValues = values
            }
        }
        return animator
    }
}

public typealias AnimationOptions = Array<AnimationOption>
