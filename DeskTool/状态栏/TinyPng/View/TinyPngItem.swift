//
//  TinyPngItem.swift
//  DeskTool
//
//  Created by unitree on 2024/6/3.
//

import Cocoa

class TinyPngItem: NSView {
    
    var file:FileInfo!
    
    var img:NSImageView!
    
    var stateLab:NSTextField!
    
    var task:TPTaskInfo?
    
    weak var superWindow:TinyPngWC?
    
    var leftConstrant:NSLayoutConstraint?
    var topConstrant:NSLayoutConstraint?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    func  setFileData(_ file:FileInfo){
        self.file = file
        img = NSImageView()
        img.image = .init(contentsOf: file.filePath)
        img.bm.add(toView: self, withConstraints: [.top(2), .left(0), .right(0), .w_h_aspect(1)])
        img.wantsLayer = true
        img.layer?.cornerRadius = 8
        img.layer?.borderWidth = 2
        img.layer?.borderColor = NSColor.tinyImgImgViewBg.cgColor
        img.layer?.backgroundColor = NSColor.tinyImgImgViewBg.cgColor

        let s = Formator.formatSize(file.orignalSize)
        print(s)
        stateLab = NSTextField()
        stateLab.stringValue = s
        stateLab.font = .systemFont(ofSize: 12)
        stateLab.textColor = .white
        stateLab.bm.add(toView: self, withConstraints: [.left(2), .under(img, 5), .right(2), .h(20)])
        stateLab.isEditable = false
        stateLab.backgroundColor = .clear
        stateLab.isBordered = false
        if self.menu == nil{
            self.menu = self.getMenu()
        }
    }
    
    func reloadWithTask(){
        if task == nil{
            task = TPStore.sharedStore.getTaskWithUUID(file.uuid)
        }
        let taskStatus = (task?.status)!
        var statusText = ""
        var progress = 0
        switch taskStatus {
            case .initial:
                statusText = Formator.formatSize(file.orignalSize)
                progress = 1
            case .prepare:
                statusText = "初始化"
                progress = 2
            case .uploading:
                statusText = "上传:" + String(format: "(%.2f%%)", (task?.progress.fractionCompleted)! * 100)
                progress = 3
            case .processing:
                statusText = "正在压缩"
                progress = 4
            case .downloading:
                statusText = "下载:" + String(format: "(%.2f%%)", (task?.progress.fractionCompleted)! * 100)
                progress = 5
            case .finish:
                let result = Formator.formatSize(task!.resultSize)
                let sizeChange = (task!.originSize - task!.resultSize) / task!.originSize
                statusText = String(format: "\(result)(-%0.0f%%) ✅", sizeChange * 100)
                progress = 6
            case .error:
                statusText = "ERROR ❌"
        }
        stateLab.stringValue = statusText
    }
    
    
    override func rightMouseDown(with event: NSEvent) {
        let loc = event.locationInWindow
        print(loc)
        let location = self.convert(event.locationInWindow, to: nil)
        self.menu?.popUp(positioning: nil, at: loc, in: superWindow?.windowContentView)
    }
    
    func getMenu() -> NSMenu{
        let menu = NSMenu(title: "")
        let item = NSMenuItem(title: "删除", action: #selector(deleteAction), keyEquivalent: "")
        item.isEnabled = true
        item.target = self
        menu.addItem(item)
        return menu
    }
    
    @objc func deleteAction(){
        self.superWindow?.deleteItem(self.file)
    }
}
