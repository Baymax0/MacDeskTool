//
//  ModifierFlags+监听.swift
//  DeskTool
//
//  Created by unitree on 2024/6/17.
//

import Cocoa
typealias MyFlag = NSEvent.ModifierFlags

extension NSEvent.ModifierFlags{
    
    static var myFlag:[MyFlag] {
        return [.option, .command, .shift, .control, .function]
    }
    
    var rawValue_Str:String{
        if self == .option{ return "option" }
        if self == .command{ return "command" }
        if self == .shift{ return "shift" }
        if self == .control{ return "control" }
        if self == .function{ return "function" }
        return ""
    }
    
    static func getWithCode( _ code:UInt16) -> MyFlag?{
        if code == 55 { return .command }
        if code == 56 { return .shift }
        if code == 58 { return .option }
        if code == 59 { return .control }
        if code == 63 { return .function }
        return nil
    }
}


extension NSEvent{
    ///  将键盘事件转为 字符串：command 1 / esc / option /
    func getEventString() -> String?{
        var result:[String] = []
        // 组合键 抬起时触发
        if self.type == .keyUp{
            for myK in NSEvent.ModifierFlags.myFlag{ // 组合键中的功能键
                if self.modifierFlags.contains(myK){
                    result.append(myK.rawValue_Str)
                }
            }
            if self.keyCode == 53{
                result.append("esc")
            }else if let str = self.charactersIgnoringModifiers{ // 组合键中的符号键
                result.append(str)
            }

        }
        // 功能键 抬起时触发
        else if self.type == .flagsChanged && self.modifierFlags.rawValue == 256{
            if let str = MyFlag.getWithCode(self.keyCode)?.rawValue_Str{
                result.append(str)
            }
        }
        if result.count == 0{ return nil}
        let r = result.joined(separator: " ")
        return r
    }
}
