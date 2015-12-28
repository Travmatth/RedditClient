//
//  ExternalPostTableViewCell.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/27/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class ExternalPostCell: UITableViewCell {

    var title: UILabel?
    var header: UIStackView?
    var subHeader: UIStackView?
    var footer: UIStackView?
    
    var headerLabels: [UILabel]?
    var subHeaderLabels: [UILabel]?
    var footerLabels: [UILabel]?
    
    var nsfw: Bool?
    var post: PostData?
    var selfTextHtml: String?

    var authorLabel: UILabel?
    var subredditLabel: UILabel?
    var domainLabel: UILabel?
    var karmaLabel: UILabel?
    var commentsLabel: UILabel?
    var linkFlairTextLabel: UILabel?
    
    var launchLinkButton: UIButton?
    var thumbnail: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        header = UIStackView()
        subHeader = UIStackView()
        footer = UIStackView()
        
        authorLabel = UILabel()
        subredditLabel = UILabel()
        domainLabel = UILabel()
        karmaLabel = UILabel()
        commentsLabel = UILabel()
        linkFlairTextLabel = UILabel()
        
        launchLinkButton = UIButton()
        thumbnail = UIImageView(image: UIImage(named: "circle-user-7"))
        thumbnail?.contentMode = .ScaleAspectFit
        
        /* Do I want to include these in the view, and if so how??
        createdUtc = UILabel()
        linkFlairCssClass = UILabel()
        authorFlairCssClass = UILabel()
         */
        
        headerLabels = [authorLabel!, subredditLabel!]
        subHeaderLabels = [domainLabel!, karmaLabel!]
        footerLabels = [commentsLabel!, linkFlairTextLabel!]
        
        title = UILabel()
        title?.numberOfLines = 0
        title?.lineBreakMode = .ByWordWrapping
        

        header?.translatesAutoresizingMaskIntoConstraints = false
        subHeader?.translatesAutoresizingMaskIntoConstraints = false
        title?.translatesAutoresizingMaskIntoConstraints = false
        footer?.translatesAutoresizingMaskIntoConstraints = false
        launchLinkButton?.translatesAutoresizingMaskIntoConstraints = false
        thumbnail?.translatesAutoresizingMaskIntoConstraints = false
        
        header?.axis = .Horizontal
        header?.alignment = .Top
        header?.distribution = .EqualCentering
        
        subHeader?.axis = .Horizontal
        subHeader?.alignment = .Top
        subHeader?.distribution = .EqualCentering
        
        footer?.axis = .Horizontal
        footer?.alignment = .Top
        footer?.distribution = .EqualCentering
        
        self.contentView.addSubview(header!)
        self.contentView.addSubview(subHeader!)
        self.contentView.addSubview(title!)
        self.contentView.addSubview(footer!)
        self.contentView.addSubview(launchLinkButton!)
        self.contentView.addSubview(thumbnail!)
        
        //MARK: AutoLayout Constraints
        let views: [String: UIView] = ["header": header!, "subHeader": subHeader!, "title": title!, "footer": footer!, "button": launchLinkButton!, "thumbnail": thumbnail!]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[header][subHeader]-[title]-[footer]|", options: [], metrics: nil, views: views)
        let buttonVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[button]|", options: [], metrics: nil, views: views)
        let thumbnailVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[thumbnail]|", options: [], metrics: nil, views: views)
        let headerConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[thumbnail][header][button]|", options: [], metrics: nil, views: views)
        let subHeaderConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[thumbnail][subHeader][button]|", options: [], metrics: nil, views: views)
        let titleConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[thumbnail][title][button]|", options: [], metrics: nil, views: views)
        let footerConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[thumbnail][footer][button]|", options: [], metrics: nil, views: views)

        allConstraints += verticalConstraint + buttonVerticalConstraint + thumbnailVerticalConstraint
        allConstraints += headerConstraint + subHeaderConstraint
        allConstraints += titleConstraint + footerConstraint
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    func configureExternalLinkPost(post: PostData, inViewController viewController: SubredditViewController, atIndexPath index: Int) -> ExternalPostCell {

        //Cell's owner should have access to these:
        self.post = post
        nsfw =  post.nsfw
        selfTextHtml = post.selfTextHtml
        
        //Configure title
        title?.text = post.title
        title?.setNeedsDisplay()

        //Configure header
        /* Need to instantiate labels for use in stack, will probaly have to do so manually
        https://stavash.wordpress.com/2012/12/14/advanced-issues-asynchronous-uitableviewcell-content-loading-done-right/
        */
        
        /*
        */
        
        authorLabel?.text = post.author
        subredditLabel?.text = post.subreddit
        domainLabel?.text = post.domain
        karmaLabel?.text = "\(post.ups) | \(post.downs)"
        commentsLabel?.text = "\(post.numComments) comments"
        linkFlairTextLabel?.text = post.linkFlairText
        
        launchLinkButton?.addTarget(viewController, action: "launchLink:", forControlEvents: .TouchUpInside)
        launchLinkButton?.setImage(UIImage(named: "connect-arrow-right-7"), forState: .Normal)
        launchLinkButton?.contentMode = .ScaleAspectFit
        launchLinkButton?.tag = index
        viewController.addButton(launchLinkButton!)
        
        //Configure header
        header?.addArrangedSubview(authorLabel!)
        header?.addArrangedSubview(subredditLabel!)
        
        //Configure subheader
        subHeader?.addArrangedSubview(karmaLabel!)
        subHeader?.addArrangedSubview(domainLabel!)

        //Configure footer
        footer?.addArrangedSubview(commentsLabel!)
        footer?.addArrangedSubview(linkFlairTextLabel!)
        
        return self
    }
}