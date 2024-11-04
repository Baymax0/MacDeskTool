//
//  StatusItemController+Drop.swift
//  DeskTool
//
//  Created by unitree on 2024/4/17.
//

import Foundation
import Cocoa

//MARK: ------------ 监听拖拽 ------------
extension StatusItemController{
    /// 监听拖拽
    func addDropMonitor(){
        // 初始化 弹出框
        trayVC = TrayWindowController(windowNibName: "TrayWindowController")
        // 监听
        leftMouseDraggedMonitor = EventMonitor(.leftMouseDragged, { [weak self] event in
            self?.handleLeftMouseDrad(event: event)
        })
        leftMouseDraggedMonitor.start()
    }
    /// 系统拖拽回调
    func handleLeftMouseDrad(event:NSEvent){
        let mouseLoc = NSEvent.mouseLocation
        if trayRect == nil{
            trayRect = getTrayRect()
            trayVC.window?.setFrame(trayRect!, display: false)
        }
        if trayRect!.contains(mouseLoc){
            trayVC.show()
        }else{
            trayVC.hide()
        }
    }
    /// 计算弹出框应该的位置
    func getTrayRect() -> CGRect{
        let btn = statusItem.button
        let btnFrameInWindow = btn!.convert(btn!.frame, to: nil)
        let btnFrameInScreen = btn?.window?.convertToScreen(btnFrameInWindow)
        return .init(x: btnFrameInScreen!.minX - 50, y: btnFrameInScreen!.minY - 38, width: 144, height: 36)
    }
}
