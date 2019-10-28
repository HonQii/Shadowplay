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
        demo.sp.transition.duration(time: 2).type(.fade).subtype(.fromTop).value { (v: Any) in
            let vv = v as! UIView
            vv.backgroundColor = .yellow
        }.run()
        
//        demo.sp.property("position").basic.value(to: CGPoint(x: 400, y: 400)).playback(reverse: false, fill: .backwards).duration(time: 5).run()
        
        
    }
}

