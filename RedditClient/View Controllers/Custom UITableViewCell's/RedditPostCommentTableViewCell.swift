//
//  RedditPostCommentTableViewCell.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class RedditPostCommentTableViewCell: UITableViewCell {

    //MARK: Source of comment data
    var commentData: CommentData?
    
    var comment: UILabel?
    var upsLabel: UILabel?
    var userLabel: UILabel?
    var downsLabel: UILabel?
    
    var editViewCell: UIStackView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        //MARK: Adding comment details to cell
        comment = UILabel()
        upsLabel = UILabel()
        userLabel = UILabel()
        downsLabel = UILabel()
        
        comment?.numberOfLines = 0
        comment?.lineBreakMode = .ByWordWrapping
        
        contentView.addSubview(comment!)
        contentView.addSubview(upsLabel!)
        contentView.addSubview(userLabel!)
        contentView.addSubview(downsLabel!)
        
        comment?.translatesAutoresizingMaskIntoConstraints = false
        upsLabel?.translatesAutoresizingMaskIntoConstraints = false
        userLabel?.translatesAutoresizingMaskIntoConstraints = false
        downsLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: AutoLayout Constraints
        let views: [String: UIView] = ["comment": comment!, "userLabel": userLabel!, "upsLabel": upsLabel!,  "downsLabel": downsLabel!]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[userLabel]-[comment]|", options: [], metrics: nil, views: views)
        let commentDetailsHorizontalContraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[userLabel]-[upsLabel]-[downsLabel]-|", options: [], metrics: nil, views: views)
        let commentHorizontalContraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[comment]|", options: [], metrics: nil, views: views)
        
        allConstraints += verticalContraint + commentDetailsHorizontalContraint + commentHorizontalContraint
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configureCell(fromComment comment: CommentData?) {
        self.commentData = comment
        self.comment?.text = commentData?.body
        userLabel?.text = commentData?.author
        upsLabel?.text = "\(commentData?.ups ?? 0)"
        downsLabel?.text = "\(commentData?.downs ?? 0)"
        
        self.layoutIfNeeded()
    }
    
    var createEditStackView: UIStackView {

        let stackView = UIStackView(frame: CGRect(x: 10, y: 0, width: 320, height: 44))
        
        stackView.axis = .Horizontal
        stackView.alignment = .Center
        stackView.distribution = .FillEqually

        let upImage = UIImage(named: "connect-arrow-up-7")
        let outImage = UIImage(named: "box-outgoing-7")
        let downImage = UIImage(named: "connect-arrow-down-7")
        let replyImage = UIImage(named: "message-7")

        let upArrow = UIImageView(image: upImage)
        let outArrow = UIImageView(image: outImage)
        let downArrow = UIImageView(image: downImage)
        let replyButton = UIImageView(image: replyImage)
        
        upArrow.contentMode = .ScaleAspectFit
        outArrow.contentMode = .ScaleAspectFit
        downArrow.contentMode = .ScaleAspectFit
        replyButton.contentMode = .ScaleAspectFit

        stackView.addArrangedSubview(upArrow)
        stackView.addArrangedSubview(outArrow)
        stackView.addArrangedSubview(downArrow)
        stackView.addArrangedSubview(replyButton)

        return stackView
    }
}