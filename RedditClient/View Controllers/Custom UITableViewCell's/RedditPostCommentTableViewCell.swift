//
//  RedditPostCommentTableViewCell.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class RedditPostCommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func test(value: String) {
        
        let stackView = UIStackView(frame: CGRect(x: 10, y: 0, width: 320, height: 44))
        stackView.axis = .Horizontal
        stackView.alignment = .Center
        stackView.distribution = .FillEqually
        
        let downImage = UIImage(named: "connect-arrow-down-7")
        let upImage = UIImage(named: "connect-arrow-up-7")
        let outImage = UIImage(named: "box-outgoing-7")
        let replyImage = UIImage(named: "message-7")
        
        let downArrow = UIImageView(image: downImage)
        downArrow.contentMode = .ScaleAspectFit
        
        let upArrow = UIImageView(image: upImage)
        upArrow.contentMode = .ScaleAspectFit
        
        let outArrow = UIImageView(image: outImage)
        outArrow.contentMode = .ScaleAspectFit
        
        let replyButton = UIImageView(image: replyImage)
        replyButton.contentMode = .ScaleAspectFit
        
        stackView.addArrangedSubview(downArrow)
        stackView.addArrangedSubview(upArrow)
        stackView.addArrangedSubview(outArrow)
        stackView.addArrangedSubview(replyButton)
        
        self.addSubview(stackView)
    }

        
    
    
    
}
