//
//  ViewController.swift
//  FBShimmerSwift
//
//  Created by Robin Malhotra on 19/08/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import UIKit


class ViewController: UIViewController, CAAnimationDelegate {
	@IBOutlet weak var label: UILabel!

	let grad = CAGradientLayer()
	override func viewDidLoad() {
		super.viewDidLoad()
		let redView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
		
//		grad.startPoint = CGPoint(x: 0, y: 0.5)
//		grad.endPoint = CGPoint(x: 1, y: 0.5)
//		grad.frame = redView.frame
//		redView.center = view.center
//		grad.colors = [UIColor(red:0.5, green:0.5, blue:0.5, alpha:1.00).cgColor, UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.00).cgColor,UIColor(red:0.5, green:0.5, blue:0.5, alpha:1.00).cgColor]
//		redView.layer.insertSublayer(grad, at: 0)
		
		let purpleView = UIView(frame: redView.frame)
		purpleView.backgroundColor = UIColor.purple
		view.addSubview(purpleView)
		view.addSubview(redView)
//		performAnimations()
		// Do any additional setup after loading the view, typically from a nib.
		redView.backgroundColor = UIColor.red
		Animate.shimmer(view: redView)
		
		
	}
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		performAnimations()
	}

	func performAnimations() {
		let lastColor = grad.colors?.removeLast()
		var newColors = grad.colors
		newColors!.insert(lastColor!, at: 0)
		grad.colors = newColors
		let animation = CABasicAnimation(keyPath: "colors")
		animation.toValue = newColors
		animation.duration = 1
		animation.fillMode = kCAFillModeForwards
		animation.delegate = self
		animation.isRemovedOnCompletion = false
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		grad.add(animation, forKey: "some")
		performAnim2()
	
		
	}
	
	func performAnim2() {
		let lastColor = grad.colors?.removeLast()
		var newColors = grad.colors
		newColors!.insert(lastColor!, at: 0)
		grad.colors = newColors
		let animation = CABasicAnimation(keyPath: "colors")
		animation.toValue = newColors
		animation.duration = 1
		animation.beginTime = CACurrentMediaTime() + 1
		animation.fillMode = kCAFillModeForwards
		animation.delegate = self
		animation.isRemovedOnCompletion = false
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		grad.add(animation, forKey: "some")
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


class Animate {
	
	/// Add a persistent shimmer animation. Usage: `Animate.shimmer(myView)`
	static func shimmer(view: UIView) {
		let gradient = CAGradientLayer()
		gradient.startPoint = CGPoint(x:0, y:0)
		gradient.endPoint = CGPoint(x:1, y:-0.02)
		gradient.frame = CGRect(x:0, y:0, width:view.bounds.size.width*3, height:view.bounds.size.height)
		
		let lowerAlpha: CGFloat = 0.1
		let solid = UIColor(white: 1, alpha: 1).cgColor
		let clear = UIColor(white: 1, alpha: lowerAlpha).cgColor
		gradient.colors     = [ solid, solid, clear, clear, solid, solid ]
		gradient.locations  = [ 0,     0.3,   0.45,  0.55,  0.7,   1     ]
		
		let theAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
		theAnimation.duration = 4
		theAnimation.repeatCount = Float.infinity
		theAnimation.autoreverses = false
		theAnimation.isRemovedOnCompletion = false
		theAnimation.fillMode = kCAFillModeForwards
		theAnimation.fromValue = -view.frame.size.width * 2
		theAnimation.toValue =  0
		gradient.add(theAnimation, forKey: "animateLayer")
		
		view.layer.mask = gradient
		
	}
}

