//
//  SelfPostCell.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/25/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

enum PostCategory: String {
    case Link = "Link"
    case Video = "rich:video"
    case Image = "image"
}
/*

*/

class SelfPostCell: UITableViewCell {
    
    var title: UILabel?
    var header: UIStackView?
    var subHeader: UIStackView?
    var footer: UIStackView?
    
    var headerLabels: [UILabel?]?
    var subHeaderLabels: [UILabel?]?
    var footerLabels: [UILabel?]?
    
    var nsfw: Bool?
    var post: PostData?
    var selfTextHtml: String?

    var authorLabel: UILabel?
    var subredditLabel: UILabel?
    var domainLabel: UILabel?
    var karmaLabel: UILabel?
    var commentsLabel: UILabel?
    var linkFlairTextLabel: UILabel?
    
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
        
        /* How will i implement these??
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
        
        //MARK: AutoLayout Constraints
        let views: [String: UIView] = ["header": header!, "subHeader": subHeader!, "title": title!, "footer": footer!]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[header][subHeader]-[title]-[footer]|", options: [], metrics: nil, views: views)
        let headerConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[header]-|", options: [], metrics: nil, views: views)
        let subHeaderConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[subHeader]-|", options: [], metrics: nil, views: views)
        let titleConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[title]-|", options: [], metrics: nil, views: views)
        let footerConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[footer]-|", options: [], metrics: nil, views: views)

        allConstraints += verticalConstraint + headerConstraint + subHeaderConstraint + titleConstraint + footerConstraint
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    func configureSelfPostFromPost(post: PostData) -> SelfPostCell {

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
        commentsLabel?.text = "\(post.numComments)"
        linkFlairTextLabel?.text = post.linkFlairText
        
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

class SubredditPostManager {
    class func createCellForSubredditListing(subredditViewController: SubredditViewController, fromPost post: PostData, atIndexPath index: Int) -> UITableViewCell {
        if post.domain.hasPrefix("self.") {
            if let cell = subredditViewController.dequeueCell("SelfPostCell") as? SelfPostCell {
                return cell.configureSelfPostFromPost(post)
            }
            else {
                return UITableViewCell()
            }
        }
        else { // Heuristic; self posts do not have postHint
            if let cell = subredditViewController.dequeueCell("ExternalPostCell") as? ExternalPostCell {
                return cell.configureExternalLinkPost(post, inViewController: subredditViewController, atIndexPath: index)
            }
            else {
                return UITableViewCell()
            }
        }
    }
}