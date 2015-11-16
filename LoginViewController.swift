//
//  LoginViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/13/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    var loginController: SFSafariViewController?
    var loginPrompt: UIButton!
    var stackView: UIStackView!
    var skipLoginPrompt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSLog("loginController Called")
        
        stackView = UIStackView(frame: self.view.bounds)
        
        stackView.axis = .Vertical
        stackView.alignment = .Center
        stackView.distribution = .FillEqually
        
        loginPrompt = UIButton()
        loginPrompt.addTarget(self, action: "launchLoginController", forControlEvents: UIControlEvents.TouchUpInside)
        loginPrompt.setTitle("Login", forState: .Normal)
        
        skipLoginPrompt = UIButton()
        skipLoginPrompt.addTarget(self, action: "skipLoginController", forControlEvents: UIControlEvents.TouchUpInside)
        skipLoginPrompt.setTitle("Skip", forState: .Normal)
        
        stackView.addArrangedSubview(loginPrompt)
        stackView.addArrangedSubview(skipLoginPrompt)
        
        view.addSubview(stackView)
    }

    func launchLoginController() {

        let url: NSURL = NSURL(string: "https://ssl.reddit.com/api/v1/authorize.compact?client_id=eDGbSVLzgyozTA&response_type=code&state=TEST&redirect_uri=travMatth://RedditClient&duration=permanent&scope=read")!
        
        loginController = SFSafariViewController(URL: url)
        
        self.presentViewController(loginController!, animated: true, completion: nil)
        NSLog("safari exited")
        
    }
    
    func skipLoginController() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.loadMainTabBarContoller()
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
