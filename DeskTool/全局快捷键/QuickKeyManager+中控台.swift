//
//  QuickKeyManager+悬浮中控台.swift
//  DeskTool
//
//  Created by unitree on 2024/6/17.
//

import Foundation

extension QuickKeyManager{
    
    static var isQuickViewShow:Bool{
        return QuickCenterWC.share.isShowed
    }
    /// 显示：双击 esc 开启，间隔时间小于0.4s
    /// 关闭：鼠标点击按钮 / 鼠标点击外面的位置 / esc / option /
    static func centerViewHandleKeys(_ str:String){
        
        if str == "command esc"{ // 判断打开中控台
            if isQuickViewShow == true{
                self.hideCenterView() // Hide
            }else{
                self.showCenterView()
            }
        }
    }
    
    /// 显示
    static func showCenterView(){
        QuickCenterWC.share.show()
    }
    
    /// 关闭
    static func hideCenterView(){
        QuickCenterWC.share.hide()
    }

}
