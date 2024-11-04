//
//  MyHostingView.swift
//  DeskTool
//
//  Created by unitree on 2024/3/22.
//

import Cocoa
import SwiftUI

class MyHostingView<Content>: NSHostingView<Content> where Content : View{
    
    override var acceptsFirstResponder: Bool{ return true }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    
   
    
}
