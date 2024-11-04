//
//  StatusItemController.swift
//  DeskTool
//
//  Created by unitree on 2024/3/7.
//

import Cocoa

class StatusItemController: NSObject {
    
    static var share:StatusItemController!
    
    var statusItem: NSStatusItem!
    
    var leftMouseDraggedMonitor:EventMonitor!
    
    var trayVC:TrayWindowController!
    
    var tinyVC:TinyPngWC!
    
    var trayRect:CGRect?
    // menu
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var timerMenuItem: NSMenuItem!
    @IBOutlet weak var keysDeleteMenu: NSMenu!
    
    var authItemArr: [NSMenuItem] = []
    var modelArr:[AuthenticatorUrlModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        StatusItemController.share = self
        // 设置导航栏图标，必须被全局持有
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusItem.button?.image = NSImage(named: "statusIcon")
        // 图标点击弹出菜单栏
        self.initMenu()
        // 监听拖拽
        self.addDropMonitor()
    }
    
    @IBAction func openTinyPngAction(_ sender: Any) {
        if tinyVC == nil{
            tinyVC = TinyPngWC(windowNibName: "TinyPngWC")
            let btn = statusItem.button
            let btnFrameInWindow = btn!.convert(btn!.frame, to: nil)
            let btnFrameInScreen = btn?.window?.convertToScreen(btnFrameInWindow)
            let rect:CGRect = .init(x: btnFrameInScreen!.minX - 50, y: btnFrameInScreen!.minY - 500, width: TinyPngWC.windowW, height: TinyPngWC.windowH)
            tinyVC.window?.setFrame(rect, display: true)
        }
        tinyVC.show()
    }
    
    @IBAction func showQuickCenterAction(_ sender: Any) {
        QuickCenterWC.share.show()
    }
    
}






