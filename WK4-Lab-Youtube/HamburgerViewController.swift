//
//  HamburgerViewController.swift
//  WK4-Lab-Youtube
//
//  Created by Anjani Bhargava on 2/24/16.
//  Copyright © 2016 Anjani Bhargava. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    
    var initialFeedCenter: CGPoint!
    var currentFeedCenter: CGPoint!
    var isMenuOpen: Bool!
    
    @IBOutlet weak var hamburgerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController")
        menuView.addSubview(menuViewController.view)
        
        let feedViewController = storyboard.instantiateViewControllerWithIdentifier("FeedViewController")
        feedView.addSubview(feedViewController.view)
        initialFeedCenter = feedView.center
        
        isMenuOpen = false
        
        
        setAnchorPoint(CGPoint(x: 1.0, y: 0.5), forView: feedView)

        // Do any additional setup after loading the view.
    }

    
    @IBAction func didTapHamburger(sender: UIButton) {
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / 500.0;
        transform = CATransform3DRotate(transform, CGFloat(45 * M_PI / 180), 0, 1, 0)
        
        feedView.layer.transform = transform

        let animation = CABasicAnimation(keyPath: "transform")
        animation.toValue = NSValue(CATransform3D:transform)
        animation.duration = 3
        
        feedView.layer.addAnimation(animation, forKey: "transform")
    }
    
 /*   @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
    
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            if isMenuOpen == false {
                feedView.center.x = initialFeedCenter.x + translation.x
                menuView.transform = CGAffineTransformMakeScale(0.9 + translation.x/270/10, 0.9 + translation.x/270/10)
            } else {
                feedView.center.x = initialFeedCenter.x + 275 + translation.x
                menuView.transform = CGAffineTransformMakeScale(1 + translation.x/270/10, 1 + translation.x/270/10)
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            menuView.transform = CGAffineTransformMakeScale(1, 1)
            if velocity.x > 0 {
                feedView.center.x = initialFeedCenter.x + 275
                isMenuOpen = true
            } else {
                feedView.center.x = initialFeedCenter.x
                isMenuOpen = false
            }
            
        }

    }*/
    
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
