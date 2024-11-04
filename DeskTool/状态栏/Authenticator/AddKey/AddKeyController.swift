//
//  AddKeyController.swift
//  DeskTool
//
//  Created by unitree on 2024/6/20.
//

import Cocoa

class AddKeyController: BaseWC {
    
    static var share:AddKeyController!
    
    @IBOutlet weak var nameTF:NSTextField!
    
    @IBOutlet weak var keyTF:NSTextField!

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = NSWindow.Level.floating
        window?.isMovableByWindowBackground = true
        window?.acceptsMouseMovedEvents = true
    }
    
    @IBAction func confirmAction(_ btn:NSButton!){
        self.hide()
        AddKeyController.share = nil
        let name  = nameTF.stringValue
        let key  = keyTF.stringValue
        if name.count == 0 || key.count == 0 { return }
        
        let model = AuthenticatorUrlModel(mark: name, name: "", secret: key)
        model.insert()
    }
    
    @IBAction func cancelAction(_ btn:NSButton!){
        self.hide()
        AddKeyController.share = nil
    }
    
    static func showWC(){
        if AddKeyController.share == nil{
            AddKeyController.share = AddKeyController.init(nil)
        }else{
            AddKeyController.share.nameTF.stringValue = ""
            AddKeyController.share.keyTF.stringValue = ""            
        }
        let w:CGFloat = 385
        let h:CGFloat = 185
        let x = NSScreen.main!.visibleFrame.maxX - w - 150
        let y = NSScreen.main!.visibleFrame.maxY - h
        AddKeyController.share.show(.init(x: x, y: y, width: w, height: h))
    }
    
}
