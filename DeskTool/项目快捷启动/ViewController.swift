//
//  ViewController.swift
//  DeskTool
//
//  Created by unitree on 2024/3/18.
//

import Cocoa

class ViewController: BaseNSVC {

    @IBOutlet var bgView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
//        window?.level = .floating
        window?.isMovableByWindowBackground = true
        window?.acceptsMouseMovedEvents = true
        self.initUI()
    }
    
    func initUI(){
        let v = MainVIew.getHostView()
//        v.bm.add(toView: bgView, withConstraints: [.fill])
        
    }

}

//MARK: ------------ 获取文件读写权限(开启沙盒是需要，没开启沙盒的话默认就有权限) ------------
extension ViewController{
    // 获取文件读写权限
    func getRW_Right(){
        if getBookMark() == false{
            self.chooseDirectAndSave()
        }
    }
    
    func chooseDirectAndSave(){
        let op = NSOpenPanel()
        op.canChooseDirectories = true
        op.canChooseFiles = false
        op.prompt = "选择目录"
        op.beginSheetModal(for: view.window!) { result in
            // 点击选中按钮
            if result == .OK{
                let url = op.urls.last!
                //                self.selectPath = url.path
                if let bookmark = try? url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil){
                    UserDefaults.standard.setValue(bookmark, forKey: "bookmark")
                    UserDefaults.standard.synchronize()
                }
                
            }
        }
    }
    
    func getBookMark() -> Bool{
        if let bookmark = UserDefaults.standard.value(forKey: "bookmark") as? Data{
            var isStale = false
            let url = try? URL(resolvingBookmarkData: bookmark, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)
            let result = url?.startAccessingSecurityScopedResource()
            if result == true{
                return true
            }
        }
        return false
    }
}
