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
    let demo = UIView(frame: .init(x: 100, y: 200, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demo.backgroundColor = .red
        view.addSubview(demo)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        demo.sp.concurrent([
//            AnimationNode.scaleSize(0.3).options(.duration(0.3), .removeOnCompletion(false), .fillMode(.forwards), .autoReverses(false)),
//            AnimationNode.moveX(200).options(.duration(0.3), .removeOnCompletion(false), .fillMode(.forwards), .autoReverses(false)),
//            AnimationNode.moveY(400).options(.duration(0.3), .removeOnCompletion(false), .fillMode(.forwards), .autoReverses(false)),
//            AnimationNode.backgroundColor(UIColor.cyan).options(.duration(0.3), .removeOnCompletion(false), .fillMode(.forwards), .autoReverses(false))
//        ], options: [.duration(0.3), .removeOnCompletion(false), .fillMode(.forwards), .autoReverses(false)]).run()
        
//        demo.sp.series().series().run()
        
        demo.sp.concurrent([
            AnimationNode.scaleSize(0.3).options(.duration(0.3), .removeOnCompletion(false), .fillMode(.forwards), .autoReverses(false)),
            AnimationNode.moveY(350).options(AnimationOption.duration(0.3), .removeOnCompletion(false), .autoReverses(false), .fillMode(.forwards))
            ]).run()
    }
}

