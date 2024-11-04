//
//  WebVC.swift
//  DeskTool
//
//  Created by unitree on 2024/3/7.
//

import Cocoa
import WebKit

class WebVC: NSViewController, WKNavigationDelegate{

    var url:URL!
    
    @IBOutlet weak var web: WKWebView!
    
    convenience init(url: URL!) {
        self.init(nibName: "WebVC", bundle: nil)
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url{
            let req = URLRequest(url: url)
            web.load(req)
            web.alphaValue = 0
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        view.window?.title = webView.title ?? ""
        let url = webView.url?.absoluteString ?? ""
        if url.contains("bilibili"){
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                webView.evaluateJavaScript(JSFullSCManager.bilibili)
                self.web.alphaValue = 1
//            }
        }
    }
}
