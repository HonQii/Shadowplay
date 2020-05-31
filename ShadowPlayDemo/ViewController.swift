//
//  ViewController.swift
//  ShadowPlayDemo
//
//  Created by HonQi on 2019/10/27.
//  Copyright © 2019 HonQi Indie. All rights reserved.
//

import UIKit
import ShadowPlay

class ViewController: UIViewController {
    var animationLayer: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        drawAnimationLayer(CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200))

        let beginTime: Double = 0.5
        let strokeStartDuration: Double = 1.2
        let strokeEndDuration: Double = 0.7
        
        animationLayer?.sp.concurrent([
            .basic(key: "transform.rotation" ,by: Float.pi * 2, extras: [.timingFunction(CAMediaTimingFunction(name: .linear))]),
            .basic(key: "strokeEnd", from: 0, to: 1, extras: [.duration(strokeEndDuration), .timingFunction(CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1))]),
            .basic(key: "strokeStart", from: 0, to: 1, extras: [.duration(strokeStartDuration), .beginTime(beginTime), .timingFunction(CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1.0))])
            ], options: [
            .duration(strokeStartDuration + beginTime),
            .repeatCount(.infinity),
            .removeOnCompletion(false),
            .fillMode(.forwards)
        ]).run()
    }
    
    func drawAnimationLayer(_ rect: CGRect) {
        let size = rect.size
        
        let shape = CAShapeLayer()
        let path = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                                radius: size.width / 2,
                                startAngle: -(.pi / 2),
                                endAngle: .pi + .pi / 2,
                                clockwise: true)
        shape.fillColor = nil
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 5
        shape.lineCap = .round
        shape.backgroundColor = nil
        shape.path = path.cgPath
        shape.frame = rect
        view.layer.addSublayer(shape)
        animationLayer = shape
    }
}

