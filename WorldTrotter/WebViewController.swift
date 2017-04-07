//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Iza on 24.08.2016.
//  
//

import UIKit

class WebViewController: UIViewController{
    
    
    @IBOutlet var WebView: UIWebView!
    
    override func viewDidLoad() {
        
        let url = URL(string: "http://www.9gag.com")
        let request = URLRequest(url: url!)
        
        WebView.loadRequest(request)
        
        
        super.viewDidLoad()
        
        print("Web wiev loaded its view")
         
        
    }
}
