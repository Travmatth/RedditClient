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
    var prompt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSLog("loginController Called")
        let prompt = UIButton(frame: self.view.frame)
        prompt.addTarget(self, action: "launchLoginController", forControlEvents: UIControlEvents.TouchUpInside)
        prompt.setTitle("Press", forState: .Normal)
        
        view.addSubview(prompt)
    }

    func launchLoginController() {

        let url: NSURL = NSURL(string: "https://ssl.reddit.com/api/v1/authorize.compact?client_id=eDGbSVLzgyozTA&response_type=code&state=TEST&redirect_uri=travMatth://RedditClient&duration=permanent&scope=read")!
        
        loginController = SFSafariViewController(URL: url)
        
        self.presentViewController(loginController!, animated: true, completion: nil)
        NSLog("safari exited")
        
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
