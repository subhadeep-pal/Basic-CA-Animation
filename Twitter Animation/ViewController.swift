//
//  ViewController.swift
//  Twitter Animation
//
//  Created by 01HW934413 on 19/04/17.
//  Copyright © 2017 01HW934413. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlay: UIView!

    
    var mask: CALayer!
    var animation : CABasicAnimation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        animateLaunch(image: #imageLiteral(resourceName: "twitter_logo_white"), bgColor: UIColor.blue)
    }
    
    func animateLaunch(image: UIImage, bgColor: UIColor){
        self.view.backgroundColor = bgColor
        
        mask = CALayer()
        mask.contents = image.cgImage
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: mainView.frame.width / 2, y: mainView.frame.height / 2)
        
        mainView.layer.mask = mask
        
        animateDecreaseSize()
    }
    
    
    func animateDecreaseSize(){
        
        let decreaseSize = CABasicAnimation(keyPath: "bounds")
        decreaseSize.delegate = self
        decreaseSize.duration = 0.3
        
        decreaseSize.fromValue = NSValue(cgRect: mask.bounds)
        decreaseSize.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        decreaseSize.fillMode = kCAFillModeForwards
        decreaseSize.isRemovedOnCompletion = false
        
        mask.add(decreaseSize, forKey: "bounds")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animateIncreaseSize()
    }
    
    func animateIncreaseSize(){
        let increaseSize = CABasicAnimation(keyPath: "bounds")
        
        increaseSize.duration = 0.75
        increaseSize.fromValue = NSValue(cgRect: mask.bounds)
        increaseSize.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 4000, height: 4000))
        
        increaseSize.fillMode = kCAFillModeForwards
        increaseSize.isRemovedOnCompletion = false
        
        mask.add(increaseSize, forKey: "bounds")
        
        
        UIView.animate(withDuration: 0.75 , animations: {
            () -> Void in
            self.overlay.alpha = 0
        })
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.overlay.alpha = 1.0
        animateLaunch(image: #imageLiteral(resourceName: "twitter_logo_white"), bgColor: UIColor.blue)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

