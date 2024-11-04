//
//  StatusItemController+Menu.swift
//  DeskTool
//
//  Created by unitree on 2024/4/17.
//

import Foundation
import Cocoa

// model.mark = "Aliyun"
// model.secret = "YFOJ2Z5EL3NC4REIXM6HBHEYFESONPCYYOUFRHYJD7WN76SG4OWFXLZXZNKB7ZOL"
//MARK: ------------ Menu ------------
extension StatusItemController{
    
    func initMenu(){
        self.statusItem.menu = statusMenu
        
        // 打开计时器
        let timer = Timer(timeInterval: TimeInterval(1), target: self, selector: #selector(updateMenu), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.eventTracking)
    }
    
    @objc func updateMenu() {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let dateComponents = calendar.dateComponents([.second], from: Date())
        let second = 30 - dateComponents.second! % 30

        timerMenuItem.title = "过期时间: \(second)s"
//        let models = AuthenticatorUrlModel.getAll()
        // 插入 数据cell-待刷新
        let models = AuthenticatorUrlModel.getAll()
        while authItemArr.count < models.count {
            let index = authItemArr.count
            
            let authCodeMenuItem = NSMenuItem()
            authCodeMenuItem.target = self
            authCodeMenuItem.action = #selector(copyAction)
            authCodeMenuItem.toolTip = ""
            authCodeMenuItem.keyEquivalentModifierMask = [.command, .shift]
            authItemArr.append(authCodeMenuItem)
            statusMenu.insertItem(authCodeMenuItem, at: 1)
            
            let model = models[index]
            let deleteItem = NSMenuItem()
            deleteItem.target = self
            deleteItem.title = String(format: "删除：%@", model.mark)
            deleteItem.tag = index
            deleteItem.action = #selector(deleteAction)
            keysDeleteMenu.insertItem(deleteItem, at: 2)
        }
        while authItemArr.count > models.count {
            statusMenu.removeItem(at: 1)
            keysDeleteMenu.removeItem(at: 2)
            
            authItemArr.removeLast()
        }
        
        var index = 0
        for item in self.authItemArr {
            let model = models[index]
            item.tag = index
            
            item.title = String(format: "\t%@：\t%@", model.mark, model.getCode())
            let deleteItem = self.keysDeleteMenu.items[index]
            deleteItem.tag = index
            
            index += 1
        }

    }
    
    /// 复制到剪贴板
    @objc func copyAction(_ sender: NSMenuItem){
        var code = sender.title.components(separatedBy: "：").last ?? ""
        code = code.trimmingCharacters(in: .whitespacesAndNewlines)
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(code, forType: .string)
    }
    
    @IBAction func addVerifyClicked(_ sender: NSMenuItem) {
        AddKeyController.showWC()
    }

    @objc func deleteAction(_ sender: NSMenuItem) {
        let index = sender.tag
        let models = AuthenticatorUrlModel.getAll()
        let m = models[index]
        m.delete()
    }


    // 退出
    @IBAction func quitClicked(sender: NSMenuItem) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        NSApplication.shared.terminate(self)
    }
}
