//
//  QuickKeyManager+Keys.swift
//  DeskTool
//
//  Created by unitree on 2024/6/19.
//

import Foundation
import Cocoa

/// Command ：⌘
/// Option  ：⌥
/// Control ：⌃
/// Shift   ：⇧
class MyQuickKeys{
    
    static var xcode:[QuickKeyModel] = []
    
    static var safari:[QuickKeyModel] = []
    
    // 初始化所有快捷键
    static func config(){
        MyQuickKeys.config_Xcode()
        MyQuickKeys.config_Safari()
    }
    
    // 查找快捷键，并执行事件
    static func findKeysAndWork(_ eventStr:String){
        if eventStr.count == 0 { return }
        for m in xcode{
            if eventStr == m.eventString{
                m.handle()
                return
            }
        }
        for m in safari{
            if eventStr == m.eventString{
                m.handle()
                return
            }
        }
    }
}

/// Xcode 快捷键
extension MyQuickKeys {
    private static func config_Xcode(){
        // Go2
        xcode.append(
            QuickKeyModel(name: "Go2", keyFlag: .command, keyCharacter: "1") {
                ToolFunc.openPath(.go2_Project)
            }
        )
        // B2
        xcode.append(
            QuickKeyModel(name: "B2", keyFlag: .command, keyCharacter: "2") {
                ToolFunc.openPath(.b2_Project)
            }
        )
        // DeskTool
        xcode.append(
            QuickKeyModel(name: "DeskTool", keyFlag: .command, keyCharacter: "3") {
                ToolFunc.openPath(.others_Project_DeskTool)
            }
        )
    }
}

/// Safari  快捷键
extension MyQuickKeys {
    private static func config_Safari(){
        // Go2
        safari.append(
            QuickKeyModel(name: "阿里云OSS", keyFlag: .option, keyCharacter: "1") {
                ToolFunc.openWebUrl("https://oss.console.aliyun.com/bucket/oss-cn-hangzhou/unitree-fitness-app/object?path=go2_app_test_download%2F")
            }
        )
        // Connect
        safari.append(
            QuickKeyModel(name: "Apple Connect", keyFlag: .option, keyCharacter: "2") {
                ToolFunc.openWebUrl("https://appstoreconnect.apple.com")
            }
        )
        // Connect
        safari.append(
            QuickKeyModel(name: "Gitlab", keyFlag: .option, keyCharacter: "3") {
                ToolFunc.openWebUrl("http://10.0.4.3:10081")
            }
        )
    }
}


struct QuickKeyModel{
    // 状态栏内的名称
    var name:String = ""
    
    // 快捷键 工具按键 ：.control/.option/.command/.shift
    var keyFlag:NSEvent.ModifierFlags?
    // 快捷键 指令建 1/2/3/a/b/c
    var keyCharacter:String?
    // 触发时的事件
    var handle:(()->())
    
    var eventString = ""
    
    init(name: String, keyFlag: NSEvent.ModifierFlags, keyCharacter: String, handle: @escaping () -> Void) {
        self.name = name
        self.keyFlag = keyFlag
        self.keyCharacter = keyCharacter
        self.handle = handle
        self.eventString = self.getEventString()
    }
    
    func getEventString() ->String{
        if keyFlag == nil || keyCharacter == nil { return ""}
        var result:[String] = []
        for myK in NSEvent.ModifierFlags.myFlag{
            if keyFlag!.contains(myK){
                result.append(myK.rawValue_Str)
            }
        }
        result.append(keyCharacter!)
        let r = result.joined(separator: " ")
        return r
    }
}
