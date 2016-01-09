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
    weak var session: Session!
    var loginPrompt: UIButton!
    var stackView: UIStackView!
    var skipLoginPrompt: UIButton!
    var loginController: SFSafariViewController?
    
    func startOAuthFlow() {
        let loginController = session.startOAuthFlow()
            // should i grab login controller and parse output to customize experience?
            // Would need to switch SFSafariView -> WKWebView
        self.presentViewController(loginController, animated: true, completion: nil)
    }
    
    func skipLoginController() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.loadRootTabBarContoller()
        
    }
    
    // MARK: iOS ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stackView = UIStackView(frame: self.view.bounds)

        stackView.axis = .Vertical
        stackView.alignment = .Center
        stackView.distribution = .FillEqually
        
        loginPrompt = UIButton()
        loginPrompt.addTarget(self, action: "startOAuthFlow", forControlEvents: UIControlEvents.TouchUpInside)
        loginPrompt.setTitle("Login", forState: .Normal)
        
        skipLoginPrompt = UIButton()
        skipLoginPrompt.addTarget(self, action: "skipLoginController", forControlEvents: UIControlEvents.TouchUpInside)
        skipLoginPrompt.setTitle("Skip", forState: .Normal)
        
        stackView.addArrangedSubview(loginPrompt)
        stackView.addArrangedSubview(skipLoginPrompt)
        
        view.addSubview(stackView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSLog("LoginViewController.deinit")
    }
}
