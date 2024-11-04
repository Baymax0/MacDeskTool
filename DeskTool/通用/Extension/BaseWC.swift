//
//  NSWindowController+.swift
//  DeskTool
//
//  Created by unitree on 2024/6/18.
//

import Foundation
import Cocoa

class BaseWC:NSWindowController{
    
    var isShowed:Bool = false
    
    public func show(_ frame:CGRect? = nil) {
        if let rect = frame{
            self.window?.setFrame(rect, display: true)
        }
        if isShowed == false{
            isShowed = true
            showWindow(nil)
            self.window?.makeKey()
        }
    }
    
    public func hide() {
        if isShowed == true{
            isShowed = false
            window?.close()
            close()
        }
    }
    
    public convenience init(_ quicNibName:Any?){
        let nibName = String(describing: Self.self)
        self.init(windowNibName: nibName)
    }
    
    
}
