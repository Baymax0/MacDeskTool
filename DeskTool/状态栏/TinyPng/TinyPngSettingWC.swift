//
//  TinyPngSettingWC.swift
//  DeskTool
//
//  Created by unitree on 2024/6/5.
//

import Cocoa

class TinyPngSettingWC: BaseWC {
    
    @IBOutlet weak var btn1: NSButton!
    @IBOutlet weak var btn2: NSButton!

    @IBOutlet weak var keyTF: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = NSWindow.Level.floating
        window?.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        let loca = AppCache.share.tinyPngSaveLocation
        if loca == ""{
            btn1.state = .on
            btn2.state = .off
        }else{
            btn1.state = .off
            btn2.state = .on
        }
        let key = AppCache.share.tinyPngKey
        print(key)
        keyTF.stringValue = key
    }
    
    @IBAction func chooseLocationAction(_ sender: NSButton) {
        if sender.tag == 0{
            btn2.state = .off
            AppCache.share.tinyPngSaveLocation = ""
        }else{
            btn1.state = .off
            let downURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
            AppCache.share.tinyPngSaveLocation = downURL.absoluteString
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        AppCache.share.tinyPngKey = keyTF.stringValue
        keyTF.isEditable = false
        AppCache.share.update()
        self.close()
    }
    
    
}
