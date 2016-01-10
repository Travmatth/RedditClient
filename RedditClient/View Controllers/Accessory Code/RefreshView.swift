//
//  RefreshView.swift
//  RedditClient
//
//  Created by Travis Matthews on 1/8/16.
//  Copyright © 2016 Travis Matthews. All rights reserved.
//

import UIKit

class RefreshView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var label0: UILabel?
    var label1: UILabel?
    var label2: UILabel?
    var label3: UILabel?
    var label4: UILabel?
    var label5: UILabel?
    var label6: UILabel?
    var label7: UILabel?
    var label8: UILabel?
    var label9: UILabel?
    var label10: UILabel?
    var label11: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init with coder not implemented")
    }
    
    override func layoutSubviews() {
        print("RefreshView.layoutSubview()")
        super.layoutSubviews()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label0 = UILabel()
        label0?.text = "R"
        label0?.tag = 0
        self.addSubview(label0!)
        
        label1 = UILabel()
        label1?.text = "E"
        label1?.tag = 1
        self.addSubview(label1!)
        
        label2 = UILabel()
        label2?.text = "D"
        label2?.tag = 2
        self.addSubview(label2!)
        
        label3 = UILabel()
        label3?.text = "D"
        label3?.tag = 3
        self.addSubview(label3!)
        
        label4 = UILabel()
        label4?.text = "I"
        label4?.tag = 4
        self.addSubview(label4!)
        
        label5 = UILabel()
        label5?.text = "T"
        label5?.tag = 5
        self.addSubview(label5!)
        
        label6 = UILabel()
        label6?.text = "C"
        label6?.tag = 6
        self.addSubview(label6!)
        
        label7 = UILabel()
        label7?.text = "L"
        label7?.tag = 7
        self.addSubview(label7!)
        
        label8 = UILabel()
        label8?.text = "I"
        label8?.tag = 8
        self.addSubview(label8!)
        
        label9 = UILabel()
        label9?.text = "E"
        label9?.tag = 9
        self.addSubview(label9!)
        
        label10 = UILabel()
        label10?.text = "N"
        label10?.tag = 10
        self.addSubview(label10!)
        
        label11 = UILabel()
        label11?.text = "T"
        label11?.tag = 11
        self.addSubview(label11!)
        
        let views = [
            "l0": label0!,
            "l1": label1!,
            "l2": label2!,
            "l3": label3!,
            "l4": label4!,
            "l5": label5!,
            "l6": label6!,
            "l7": label7!,
            "l8": label8!,
            "l9": label9!,
            "l10": label10!,
            "l11": label11!
                    ]
    
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[l0][l1][l2][l3][l4][l5][l6][l7][l8][l9][l10][l11]-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[l0]-|", options: [], metrics: nil, views: views))
    }
}
