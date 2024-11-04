//
//  QuickKeyManager.swift
//  DeskTool
//
//  Created by unitree on 2024/6/14.
//

import Cocoa


class QuickKeyManager{
    
    static var share:QuickKeyManager!
        
    /// 初始化调用
    static func config(){
        // 快捷键列表
        MyQuickKeys.config()
        
        // 将快捷键配置到全局
        NSEvent.addGlobalMonitorForEvents(matching: [.keyUp, .flagsChanged]) { event in
            if let str = event.getEventString(){
                print(str)
                // 识别全局的快捷键
                MyQuickKeys.findKeysAndWork(str)
                // 中控台响应 开启/关闭
                centerViewHandleKeys(str)
            }
        }
    }
    
}










