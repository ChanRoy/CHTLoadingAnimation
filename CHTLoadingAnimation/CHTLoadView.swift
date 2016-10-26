//
//  CHTLoadView.swift
//  CHTLoadingAnimation
//
//  Created by cht on 16/10/26.
//  Copyright © 2016年 cht. All rights reserved.
//

import UIKit

class CHTLoadView: UIView,CAAnimationDelegate {
    
    var circle1Color = UIColor.init(red: 206/255.0, green: 7/255.0, blue: 85/255.0, alpha: 1)
    var circle2Color = UIColor.init(red: 206/255.0, green: 7/255.0, blue: 85/255.0, alpha: 0.6)
    var circle3Color = UIColor.init(red: 206/255.0, green: 7/255.0, blue: 85/255.0, alpha: 0.3)
    
    let animTime = 1.5
    let animRepertCount:Float = 50
    
    var circle1: UIView!
    var circle2: UIView!
    var circle3: UIView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let circle1 = UIView.init()
        circle1.frame.size.width = 10
        circle1.frame.size.height = 10
        circle1.layer.cornerRadius = 10/2
        circle1.backgroundColor = circle1Color
        self.circle1 = circle1
        
        let circle2 = UIView.init()
        circle2.frame.size.width = 10
        circle2.frame.size.height = 10
        circle2.layer.cornerRadius = 10/2
        circle2.backgroundColor = circle2Color
        self.circle2 = circle2
        
        let circle3 = UIView.init()
        circle3.frame.size.width = 10
        circle3.frame.size.height = 10
        circle3.layer.cornerRadius = 10/2
        circle3.backgroundColor = circle3Color
        self.circle3 = circle3
        
        self.addSubview(circle1)
        self.addSubview(circle2)
        self.addSubview(circle3)
        
        circle2.center.x = self.center.x
        circle2.center.y = self.center.y
        
        circle1.center.x = circle2.center.x - 20
        circle1.center.y = circle2.center.y
        
        circle3.center.x = circle2.center.x + 20
        circle3.center.y = circle2.center.y
        
        startAnim()
    }
    
    func startAnim(){
        
        let pathCenter1 = CGPoint.init(x: circle1.center.x + 10, y: circle2.center.y)
        let pathCenter2 = CGPoint.init(x: circle2.center.x + 10, y: circle2.center.y)
        
        //circle1
        let path1 = UIBezierPath.init()
        path1.addArc(withCenter: pathCenter1, radius: 10, startAngle: -CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        let path1_1 = UIBezierPath.init()
        path1_1.addArc(withCenter: pathCenter2, radius: 10, startAngle: -CGFloat(M_PI), endAngle: 0, clockwise: false)
        path1.append(path1_1)
        
        viewMovePathAnim(view: circle1, path: path1, time: animTime)
        viewColorAnim(view: circle1, fromColor: circle1Color, toColor: circle3Color, time: animTime)
        
        //circle2
        let path2 = UIBezierPath.init()
        path2.addArc(withCenter: pathCenter1, radius: 10, startAngle: 0, endAngle: -CGFloat(M_PI), clockwise: true)
        viewMovePathAnim(view: circle2, path: path2, time: animTime)
        viewColorAnim(view: circle2, fromColor: circle2Color, toColor: circle1Color, time: animTime)
        
        //circle3
        let path3 = UIBezierPath.init()
        path3.addArc(withCenter: pathCenter2, radius: 10, startAngle: 0, endAngle: -CGFloat(M_PI), clockwise: false)
        viewMovePathAnim(view: circle3, path: path3, time: animTime)
        viewColorAnim(view: circle3, fromColor: circle3Color, toColor: circle2Color, time: animTime)
    }
    
    func viewMovePathAnim(view: UIView, path: UIBezierPath, time: Double){
        
        let anim = CAKeyframeAnimation.init(keyPath: "position")
        anim.path = path.cgPath
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        anim.calculationMode = kCAAnimationCubic
        anim.repeatCount = animRepertCount
        
        anim.duration = animTime
        anim.delegate = self;
        anim.autoreverses = false
        
        anim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(anim, forKey: "animation")
    }
    
    func viewColorAnim(view: UIView, fromColor: UIColor, toColor: UIColor, time: Double){
        
        let colorAnim = CABasicAnimation.init(keyPath: "backgroundColor")
        colorAnim.toValue = toColor.cgColor
        colorAnim.fromValue = fromColor.cgColor
        colorAnim.duration = time
        colorAnim.autoreverses = false
        colorAnim.fillMode = kCAFillModeForwards
        colorAnim.isRemovedOnCompletion = false
        colorAnim.repeatCount = animRepertCount
        
        view.layer.add(colorAnim, forKey: "backgroundColor")
        
    }
    
    class func showLoadingIn(view:UIView) -> CHTLoadView{
        
        let loadingView = CHTLoadView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        view.addSubview(loadingView)
        
        return loadingView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
