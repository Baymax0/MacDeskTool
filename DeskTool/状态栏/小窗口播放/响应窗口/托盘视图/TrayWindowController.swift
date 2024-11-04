//
//  TrayWindowController.swift
//  DeskTool
//
//  Created by unitree on 2024/3/7.
//

import Cocoa

//MARK: ------------ WindowController ------------
class TrayWindowController: BaseWC, TrayContainerViewDragDelegate{

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.backgroundColor = .clear
        window?.level = NSWindow.Level.floating
        hide()
    }

    func performDragOperation(draggingInfo: NSDraggingInfo) -> Bool {
        if let url = draggingInfo.getDraggingUrl(){
            print(url)
            // 打开播放窗口
            let webWindow = WebViewWindowController(url: url)
            webWindow.showWindow(nil)
            // 关闭当前托盘窗口
            self.hide()
            // 激活
            NSApplication.shared.activate(ignoringOtherApps: true)
            return true
        }else{
            return false
        }
    }
}


//MARK: ------------ ContentView ------------
@objc protocol TrayContainerViewDragDelegate {
    func performDragOperation(draggingInfo: NSDraggingInfo) -> Bool
}

class TrayContainerView: NSView {

    @IBOutlet weak var delegate: TrayContainerViewDragDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerForDraggedTypes([NSPasteboard.PasteboardType.string, .URL])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = sender.draggingPasteboard.canReadObject(forClasses: [NSURL.self, NSString.self])
        return allow ? .copy : []
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return delegate?.performDragOperation(draggingInfo: sender) ?? false
    }
}
