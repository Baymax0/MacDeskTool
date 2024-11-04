//
//  QuickCenterWC.swift
//  DeskTool
//
//  Created by unitree on 2024/6/18.
//

import Cocoa
/// Command ：⌘
/// Option  ：⌥
/// Control ：⌃
/// Shift   ：⇧
///
class QuickCenterWC: BaseWC {
    @IBOutlet weak var contentBg: NSView!
    @IBOutlet weak var contentEffectView: NSVisualEffectView!
    
    @IBOutlet weak var go2_BuildLab: NSTextField!
    @IBOutlet weak var go2_WebLab: NSTextField!
    
    @IBOutlet weak var b2_BuildLab: NSTextField!
    @IBOutlet weak var b2_WebLab: NSTextField!
    
    @IBOutlet weak var timeLab: NSTextField!
    var timer:Timer!
    
    static var share = QuickCenterWC.init(nil)
    
    var monitor:Any!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = NSWindow.Level.floating
        window?.backgroundColor = .clear
        window?.isMovableByWindowBackground = true
        window?.acceptsMouseMovedEvents = true
        
        contentBg.wantsLayer = true
        contentBg.layer?.cornerRadius = 12
    }
    
    override func mouseDown(with event: NSEvent) { }
    
    override func show(_ frame: CGRect? = nil) {
        super.show(frame)
        monitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { e in
            if self.isShowed == true{
                self.hide()
            }
        }
        print("show Center")
        self.updateView()
        if timer == nil{
            timer = Timer(timeInterval: TimeInterval(1), target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: .common)
            updateTime()
        }
    }
    
    override func hide() {
        super.hide()
        if monitor != nil{
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
        print("hide Center")
        if timer != nil{
            timer.invalidate()
            timer = nil
        }
    }
    
    @objc func updateTime(){
        guard isShowed == true else { return }
        let day = Date().toString("yyyy-M-d")
        let week = Date().getweekDayString()
        let clock = Date().toString("HH:mm:ss")
        timeLab.stringValue = String(format: "%@  %@  %@",day, week, clock)
    }
    
    @IBAction func safariAction(_ sender: NSButton) {
        guard isShowed == true else { return } // 防止双击导致的问题
        if sender.tag == 0{
            MyQuickKeys.safari[0].handle()
        }else if sender.tag == 1{
            MyQuickKeys.safari[1].handle()
        }else{
            MyQuickKeys.safari[2].handle()
        }
        self.hide()
    }
    
    @IBAction func folderAction(_ sender: NSButton) {
        guard isShowed == true else { return } // 防止双击导致的问题
        var link = ""
        if sender.tag == 0{
            link = "/Users/unitree/Desktop/Project"
        }else if sender.tag == 1{
            link = "/Users/unitree/Desktop/Modules"
        }else if sender.tag == 2{
            link = "/Users/unitree/Desktop/IPA"
        }else if sender.tag == 3{
            link = "/System/Applications"
        }else if sender.tag == 4{
            link = "/Users/unitree/Downloads"
        }
        
        let url = URL(filePath: link)
        NSWorkspace.shared.open(url)
        self.hide()
    }
    
    /// 刷新页面数据
    func updateView(){
        let pV = ToolFunc.getVersion(.go2_Project)
        go2_BuildLab.stringValue = pV.1
        let wV = ToolFunc.getWebVersion(.go2_distTimeFile)
        let removeYear =  wV.1.replacingOccurrences(of: "2024-", with: "")
        go2_WebLab.stringValue = removeYear
        
        let pV2 = ToolFunc.getVersion(.b2_Project)
        b2_BuildLab.stringValue = pV2.1
        let wV2 = ToolFunc.getWebVersion(.b2_distTimeFile)
        let removeYear2 =  wV2.1.replacingOccurrences(of: "2024-", with: "")
        b2_WebLab.stringValue = removeYear2
    }
    
    //MARK: ------------ Go2/B2 ------------
    /// 打开文件夹
    @IBAction func go2_OpenProjectFile_Action(_ sender:NSButton){
        if sender.tag == 0{
            ToolFunc.openPath(.go2_File)
        }else{
            ToolFunc.openPath(.b2_File)
        }
    }
    /// Build + 1,前面为今天的日期
    @IBAction func go2_BuildPlus1_Action(_ sender:NSButton){
        sender.isEnabled = false
        if sender.tag == 0{
            let nowBuild = go2_BuildLab.stringValue
            let todayStr = Date().toString("Mdd")
            var toBuild = ""
            /// 判断当前Build的日期是否为今天
            if nowBuild.hasPrefix(todayStr){
                // 是的话，Build+1
                let lastB = Int(nowBuild)! % 10 + 1
                toBuild = todayStr + "\(lastB)"
            }else{
                // 不是的话使用”日期1“为Build
                toBuild = todayStr + "1"
            }
            ToolFunc.setBuild(.go2_Project, from: nowBuild, to: toBuild)
            go2_BuildLab.stringValue = toBuild
        }else{
            let nowBuild = b2_BuildLab.stringValue
            let todayStr = Date().toString("Mdd")
            var toBuild = ""
            /// 判断当前Build的日期是否为今天
            if nowBuild.hasPrefix(todayStr){
                // 是的话，Build+1
                let lastB = Int(nowBuild)! % 10 + 1
                toBuild = todayStr + "\(lastB)"
            }else{
                // 不是的话使用”日期1“为Build
                toBuild = todayStr + "1"
            }
            ToolFunc.setBuild(.b2_Project, from: nowBuild, to: toBuild)
            b2_BuildLab.stringValue = toBuild
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            sender.isEnabled = true
        }
    }
    /// 更新前端
    @IBAction func go2_UpdateWeb_Action(_ sender:NSButton){
        if sender.tag == 0{
            ToolFunc.openPath(PY_CMD.go2_UpdateWeb)
        }else{
            ToolFunc.openPath(PY_CMD.b2_UpdateWeb)
        }
        self.hide()
    }
    /// 打开Excle （同一个文件）
    @IBAction func go2_ExcelOpen_Action(_ sender:NSButton){
        if sender.tag == 0{
            ToolFunc.openPath(.go2_Excel)
        }else{
            ToolFunc.openPath(.go2_Excel)
        }
        self.hide()
    }
    /// 同步Excle
    @IBAction func go2_ExcelUpdate_Action(_ sender:NSButton){
        if sender.tag == 0{
            ToolFunc.openPath(PY_CMD.go2_UpdateExcel)
        }else{
            ToolFunc.openPath(PY_CMD.b2_UpdateExcel)
        }
        self.hide()
    }
    /// 打包
    @IBAction func go2_ArchiveCN_Action(_ sender:NSButton){
        if sender.tag == 0{
            ToolFunc.openPath(.go2_Archive_CN)
            updateReadMe(0)
        }else{
            ToolFunc.openPath(.b2_Archive)
            updateReadMe(2)
        }
        self.hide()
    }
    @IBAction func go2_ArchiveOS_Action(_ sender:NSButton){
        if sender.tag == 0{
            ToolFunc.openPath(.go2_Archive_OS)
            updateReadMe(1)
        }
        self.hide()
    }
    
    func updateReadMe(_ index:Int){
        
        let url = URL(fileURLWithPath: "/Users/unitree/Desktop/IPA/README.md")
        if let data = try? Data(contentsOf: url), let content = String(data: data, encoding:.utf8) {
            var lines = content.split(separator: "\n")
            if index == 0{
                let v = ToolFunc.getVersion(.go2_Project)
                lines[0] = "Go2_CN \(v.0) \(v.1)"
            }else if index == 1{
                let v = ToolFunc.getVersion(.go2_Project)
                lines[1] = "Go2_OS \(v.0) \(v.1)"
            }else if index == 2{
                let v = ToolFunc.getVersion(.b2_Project)
                lines[2] = "B2 \(v.0) \(v.1)"
            }
            let newContent = lines.joined(separator: "\n")
            try! newContent.write(to: url, atomically: true, encoding:.utf8)
        }
    }
    
    //MARK: ------------ Others ------------

    @IBAction func othersProjectAciton(_ sender: NSButton) {
        let arr:[Link] = [.others_Project_NLV,
                          .others_Project_DeskTool,
                          .others_Project_Pump_CN,
                          .others_Project_Pump_OS,
                          .others_Project_Pump_India]
        let l = arr[sender.tag]
        ToolFunc.openPath(l)
    }
}

