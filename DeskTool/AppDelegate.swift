//
//  AppDelegate.swift
//  DeskTool
//
//  Created by unitree on 2024/3/18.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var KeyMenu: NSMenuItem!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        SDCache.config()
        
        QuickKeyManager.config()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    
    @IBAction func quickKeyAction_1(_ m:NSMenuItem?){
        ToolFunc.openPath(.go2_Project)
    }
    
    @IBAction func quickKeyAction_2(_ m:NSMenuItem?){
        ToolFunc.openPath(.b2_Project)
    }
    
}
