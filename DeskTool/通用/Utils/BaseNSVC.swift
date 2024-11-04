//
//  BaseNSVC.swift
//  DeskTool
//
//  Created by unitree on 2024/3/22.
//

import Cocoa

class BaseNSVC: NSViewController {
    
    var window: NSWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        window = self.view.window
        window?.backgroundColor = .clear

    }
}
