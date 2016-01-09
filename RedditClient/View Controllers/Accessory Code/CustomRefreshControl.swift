//
//  CustomRefreshControl.swift
//  RedditClient
//
//  Created by Travis Matthews on 1/8/16.
//  Copyright © 2016 Travis Matthews. All rights reserved.
//

import UIKit
import Foundation

protocol CustomRefreshControl: class {
    var isAnimating: Bool { get set }
    var currentColorIndex: Int { get set }
    var currentLabelIndex: Int { get set }
    var refreshView: RefreshView? { get set }
    var refreshViewLabels: [UILabel] { get set }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) -> Void
}

extension CustomRefreshControl where Self: UITableViewController {
    
    func animateRefreshStep1() {
        print("animateRefreshStep1 called")
        print("\(self.refreshView?.frame)")
        self.isAnimating = true
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: {() -> Void in
            self.refreshViewLabels[self.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.refreshViewLabels[self.currentLabelIndex].textColor = self.getNextColor()
            }, completion: { (finished) -> Void in
                self.currentLabelIndex += 1
                if self.currentLabelIndex < self.refreshViewLabels.count {
                    self.animateRefreshStep1()
                }
                else {
                    self.animateRefreshStep2()
                }
        })
    }
    
    func animateRefreshStep2() {
        print("animateRefreshStep2 called")
        UIView.animateWithDuration(0.35, delay: 0.0, options: .CurveLinear, animations: {
            for viewLabel in self.refreshViewLabels {
                viewLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }
        }, completion: { (finished) -> Void in
            UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
                for viewLabel in self.refreshViewLabels {
                    viewLabel.transform = CGAffineTransformIdentity
                }
            }, completion: { (finished) -> Void in
                if self.refreshControl?.refreshing == true {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                }
                else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    for index in 0..<self.refreshViewLabels.count {
                        self.refreshViewLabels[index].textColor = UIColor.blackColor()
                        self.refreshViewLabels[index].transform = CGAffineTransformIdentity
                    }
                }
            })
        })
    }
    
    func loadCustomRefreshContents() {
        print("loadCustomRefreshContents called")
        let refreshView = UIView()//RefreshView(frame: refreshControl!.bounds)
        print("refreshControl: \(refreshControl?.bounds)")
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        print("refreshView: \(refreshView.bounds)")
        //refreshView.translatesAutoresizingMaskIntoConstraints = false
        for index in 0 ..< refreshView.subviews.count {
            if let view: UILabel = refreshView.viewWithTag(index) as? UILabel {
                refreshViewLabels.append(view)
            }
        }
        refreshControl?.addSubview(refreshView)
    }
    
    func getNextColor() -> UIColor {
        print("getNextColor called")
        var colors: [UIColor] = [.magentaColor(), .brownColor(), .yellowColor(), .redColor(), .greenColor(), .blueColor(), .orangeColor()]
        
        if currentColorIndex == colors.count {
            currentColorIndex = 0
        }
        return colors[currentColorIndex]
    }
}