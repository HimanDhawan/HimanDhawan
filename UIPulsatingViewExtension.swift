//
//  UIPulsatingViewExtension.swift
//  Practice
//
//  Created by Himan Dhawan on 19/09/21.
//

import Foundation
import UIKit

extension UIView {
    
    /**
        The function is used to remove the pulse which is created for the "self".
     
     It iterates through all the layers and remove the layer which is "CircularShape" (Tag for circular views).
     
     */
    
    func removePulse() {
        
        self.layer.sublayers?.forEach({ layer in
            
            if let shape = layer.value(forKey: "Shape") as? String, shape == "CircularShape" {
                UIView.animate(withDuration: 0.3) {
                    layer.isHidden = true
                } completion: { _ in
                    layer.removeFromSuperlayer()
                }
            }
            
            layer.removeAllAnimations()
            
        })
        
    }
    
    /**
        Create pulse for specific line width.
     */
    
    func createPulse(lineWidth : CGFloat) {
        var isAlreadyPulsating = false
        
        self.layer.sublayers?.forEach({ layer in
            if let shape = layer.value(forKey: "Shape") as? String, shape == "CircularShape" {
                isAlreadyPulsating = true
            }
        })
        
        if isAlreadyPulsating {
            return
        }
        
        var pulseArray = [CAShapeLayer]()
        
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: self.frame.width, startAngle: 0, endAngle: 2 * .pi , clockwise: true)
            let pulsatingLayer = CAShapeLayer()
            pulsatingLayer.setValue("CircularShape", forKey: "Shape")
            pulsatingLayer.isHidden = true
            pulsatingLayer.path = circularPath.cgPath
            pulsatingLayer.lineWidth = lineWidth
            pulsatingLayer.fillColor = UIColor.clear.cgColor
            pulsatingLayer.lineCap = .round
            pulsatingLayer.position = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.width / 2.0)
            self.layer.addSublayer(pulsatingLayer)
            pulseArray.append(pulsatingLayer)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.animatePulsatingLayerAt(pulseArray: pulseArray, index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                self.animatePulsatingLayerAt(pulseArray: pulseArray, index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.animatePulsatingLayerAt(pulseArray: pulseArray, index: 2)
                })
            })
        })
    }
    
    /**
        Create pulse and line width set to default : 5.
     */
    
    func createPulse() {
        self.createPulse(lineWidth: 5)
    }
    
    /**
        Animate the layers added in "createPulse" pulse function.
     */
    func animatePulsatingLayerAt(pulseArray : [CAShapeLayer], index:Int) {
        if pulseArray.count == 0 {
            return
        }
        
        pulseArray[index].strokeColor = UIColor.white.cgColor
        pulseArray[index].isHidden = false
        
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.5
        scaleAnimation.toValue = 0.7
        
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.0
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.duration = 2
        groupAnimation.repeatCount = .infinity
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        //adding groupanimation to the layer
        pulseArray[index].add(groupAnimation, forKey: "groupanimation")
        
    }
    
}
