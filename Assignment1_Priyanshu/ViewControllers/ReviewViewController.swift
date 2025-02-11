//
//  ReviewViewController.swift
//  Assignment1_Priyanshu
//
//  Created by Priyanshu Kaushik on 2025-02-07.
//

import UIKit
import WebKit

class ReviewViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var reviewweb: WKWebView!
    @IBOutlet var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting url - creating request for the url - Load and set navigation delegate
        let urlAdd = URL(string : "https://www.pizzapizza.ca/store/3/delivery")!;
        
        let url = URLRequest(url : urlAdd);
        
        reviewweb.load(url);
        
        reviewweb.navigationDelegate = self;
        
        // Do any additional setup after loading the view.
    }
    
    
    //handling loading icon
    func webView(_ reviewweb: WKWebView, didStartProvisionalNavigation navigate : WKNavigation!) {
        loading.isHidden = false;
        loading.startAnimating();
    }
    
    //handling when load is done
    
    func webView(_ reviewweb: WKWebView, didFinish navigate : WKNavigation!){
        loading.isHidden = true;
        loading.stopAnimating();
    }
    

}
