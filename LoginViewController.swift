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

    // TODO: separate vars and methods into areas of responsibility & extensions
    var loginController: SFSafariViewController?
    var loginPrompt: UIButton!
    var stackView: UIStackView!
    var skipLoginPrompt: UIButton!
    var sessionManager: APIManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       sessionManager = APIManager()
        
        
        // Do any additional setup after loading the view.
        NSLog("loginController.viewDidLoad Called")
        
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

    // TODO: move to APIManager
    /*
        Step 1 of the OAuth Flow: Authorization
        Mark params for each step of flow and label; use enum for error handling? Result Monad to use as a flow??
        can default to general access token if flow fails for any reason
        better var names!
    */
    func startOAuthFlow() {
        loginController = sessionManager.startOAuthFlow()
        // should i grab login controller and parse output to customize experience?
        self.presentViewController(loginController!, animated: true, completion: nil)
        NSLog("safari exited")
        self.presentViewController(loginController!, animated: true, completion: nil)
        NSLog("safari exited")
    }
    
    func skipLoginController() {
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.loadRootTabBarContoller()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    deinit {
        NSLog("LoginViewController.deinit")
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
