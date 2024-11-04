//
//  TinyPngWC.swift
//  DeskTool
//
//  Created by unitree on 2024/5/30.
//

import Cocoa
import SwiftUI

class TinyPngWC: BaseWC, TPClientCallback{
    
    @IBOutlet weak var windowContentView: NSView!
        
    static var windowW: CGFloat = 360
    static var windowH: CGFloat = 550

    @IBOutlet weak var countLab: NSTextField!
    @IBOutlet weak var runBtnBg: NSView!
    var runBtn:NSHostingView<FlowBtn_Dark>!
    @IBOutlet weak var finderBtnBg: NSView!
    @IBOutlet weak var settingBtnBg: NSView!

    @IBOutlet weak var itemBg: NSView!
    @IBOutlet weak var dropContainer: DragContainer!

    @IBOutlet weak var emptyPlaceHolderView: NSView!
    var dataArr:[FileInfo] = []
    var itemViewsArr:[TinyPngItem] = []

    @IBOutlet weak var itemListBg: NSView!
    
    let numOnRow: CGFloat = 3
    let itemBlock:CGFloat = 12
    var itemW: CGFloat = 0
    var itemH: CGFloat = 0
    
    var settingWindow: TinyPngSettingWC!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        window?.level = NSWindow.Level.floating
        hide()
        self.initUI()
        dropContainer.delegate = self
        
        self.reloadCache()
        TPClient.sharedClient.callback = self
        
        itemW = (TinyPngWC.windowW - 40 + itemBlock) / numOnRow - itemBlock
        itemH = itemW + 25
        noti.addObserver(self, selector: #selector(imgUploadSuccess), name: .tinyPng_upload_Success, object: nil)
    }
    
    @objc func imgUploadSuccess(){
        // 上传完毕 次数 -1
        AppCache.share.tinyPngTokenNum = AppCache.share.tinyPngTokenNum - 1
        AppCache.update()
        
        self.reloadCache()
    }
    
    // 读取缓存
    func reloadCache(){
        let key = AppCache.share.tinyPngKey
        let num = AppCache.share.tinyPngTokenNum
        TPClient.sApiKey = key
        countLab.stringValue = "剩余额度: \(num)"
    }
    
    func initUI(){
        runBtn = FlowBtn_Dark.getHostView(img:"play.fill", w: 30) {
            self.runAction()
        }
        runBtn.bm.add(toView: runBtnBg, withConstraints: [.fill])
        runBtn.isHidden = true
        
        let v2 = FlowBtn_Dark.getHostView(img:"folder.fill",w: 30) {
            self.openFolder()
        }
        v2.bm.add(toView: finderBtnBg, withConstraints: [.fill])
        
        let v3 = FlowBtn_Dark.getHostView(img:"gearshape",w: 30) {
            if self.settingWindow == nil{
                self.settingWindow = TinyPngSettingWC(windowNibName: "TinyPngSettingWC")
            }
            let x = (self.window?.frame.minX ?? 100) + 30
            let y = (self.window?.frame.minY ?? 100) + 60
            self.settingWindow.window?.setFrame(.init(x: x, y: y, width: 308, height: 270), display: true)
            self.settingWindow.showWindow(nil)
        }
        v3.bm.add(toView: settingBtnBg, withConstraints: [.fill])
        
    }
    
    func taskStatusChanged(task: TPTaskInfo) {
        self.reloadItems()
    }
}

/// 显示拖拽
extension TinyPngWC: DragContainerDelegate{
    func draggingEntered() { }
    
    func draggingExit() { }
    
    func draggingFileAccept(_ files: Array<FileInfo>) {
        // 隐藏占位图片
        if files.count > 0 {
            emptyPlaceHolderView.isHidden = true
        }
        // 如果投入时，有已经完成的图片，清空
        if runBtn.isHidden == true && itemViewsArr.count != 0{
            for v in itemViewsArr{
                v.removeFromSuperview()
            }
            itemViewsArr = []
            dataArr = []
            
        }
        
        // 添加新图片
        for f in files{
            let v = TinyPngItem()
            v.superWindow = self
            v.setFileData(f)
            let index = dataArr.count
            self.reloadItemFrame(v, index)
            itemViewsArr.append(v)
            dataArr.append(f)
        }
        runBtn.isHidden = false
    }
    
    func reloadItemFrame(_ v:TinyPngItem, _ index:Int){
        if v.superview != nil{
            v.removeFromSuperview()
        }
        
        let row = CGFloat(index / 3) // 行数
        let col = CGFloat(index % 3) // 列
        let x = CGFloat(col * (itemW + itemBlock))
        var y = CGFloat(row * (itemH + itemBlock))
        y = 396 - y - itemH

        itemListBg.addSubview(v)
        v.frame = .init(x: x, y: y, width: itemW, height: itemH)
    }
}

/// 显示Items
extension TinyPngWC{
    /// 转换
    func runAction(){
        var tasks = [TPTaskInfo]()
        let manager = FileManager.default
        for file in dataArr {
            let task = TPTaskInfo(
                file,
                originSize: file.orignalSize,
                filePermission: nil
            )
            tasks.append(task)
        }
        TPClient.sharedClient.add(tasks)
        TPClient.sharedClient.checkExecution()
        runBtn.isHidden = true
        self.reloadItems()
    }
    
    /// 打开文件夹
    func openFolder(){
        
    }
    
    /// 刷新页面
    func reloadItems(){
        for v in itemViewsArr{
            v.reloadWithTask()
        }
    }
    
    func deleteItem(_ file:FileInfo){
        dataArr.removeAll { f in
            return f.uuid == file.uuid
        }
        var itemView:TinyPngItem!
        itemViewsArr.removeAll { i in
            if i.file.uuid == file.uuid{
                itemView = i
                return true
            }
            return false
        }
        itemView.removeFromSuperview()
        itemView.alphaValue = 0
        self.windowContentView.layoutSubtreeIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            NSAnimationContext.runAnimationGroup { content in
                content.duration = 0.35
                content.timingFunction = .init(name: .easeOut)
                content.allowsImplicitAnimation = true
                var index = 0
                for item in self.itemViewsArr {
                    self.reloadItemFrame(item, index)
                    index += 1
                    item.layer?.setNeedsLayout()
                }
                self.windowContentView.layoutSubtreeIfNeeded()
            }
        }
    }
}
