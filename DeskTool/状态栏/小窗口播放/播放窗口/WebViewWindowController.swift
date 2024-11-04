//
//  WebViewWindowController.swift
//  DeskTool
//
//  Created by unitree on 2024/3/7.
//

import Cocoa
import WebKit

//MARK: ------------ WindowController ------------
class WebViewWindowController: BaseWC {

    var contentVC:WebVC!
    
    @IBOutlet weak var web: WKWebView!

    convenience init(url: URL!) {
        self.init(windowNibName: "WebViewWindowController")
        self.contentVC = WebVC(url:url)
        self.contentViewController = contentVC
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.level = .popUpMenu
    }

}
