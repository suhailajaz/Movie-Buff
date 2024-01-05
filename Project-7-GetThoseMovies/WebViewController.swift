//
//  WebViewController.swift
//  Project-7-GetThoseMovies
//
//  Created by suhail on 20/09/23.
//

import UIKit
import WebKit
class WebViewController: UIViewController{

    var webView: WKWebView!
    var site: String?
    var movieName = ""
    override func loadView() {
        webView = WKWebView()
        view = webView
       
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = movieName
        guard let site = site else { return }
        guard  let url = URL(string: "https://www.imdb.com/title/" + site) else { return }
        DispatchQueue.main.async{
            self.webView.load(URLRequest(url: url))
        }
   
  
    }
    

  
}
