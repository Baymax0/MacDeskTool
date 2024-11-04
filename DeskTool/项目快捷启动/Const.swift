//
//  Const.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

struct Project{
    var index:Int
    var name:String
    var icon:ImageResource
}

var ProjectArr:[Project] = [
    Project(index: 0, name: "Go2", icon: .go2),
    Project(index: 1, name: "B2", icon: .b2),
    Project(index: 2, name: "模拟器", icon: .模拟器),
    Project(index: 3, name: "715", icon: .pump),
    Project(index: 4, name: "LS", icon: .ls),
]

//MARK: ------------ Color ------------
extension Color{
    
    static var bg        :Color{ let c =  #colorLiteral(red: 0.9290329218, green: 0.9233832955, blue: 0.9332787395, alpha: 1) ; return Color(c) }
    
    static var textColor :Color{ let c =  #colorLiteral(red: 0.2666666806, green: 0.2666666806, blue: 0.2666666806, alpha: 1) ; return Color(c) }
    
    static var descTextColor :Color{ let c =  #colorLiteral(red: 0.2667553723, green: 0.3556000888, blue: 0.5124317408, alpha: 0.4221807345) ; return Color(c) }

    static var myRed     :Color{ let c =  #colorLiteral(red     : 0.9556482434, green     : 0.3088407218, blue     : 0.3273916543, alpha     : 1) ; return Color(c) }
    
    static var myGreen     :Color{ let c =  #colorLiteral(red: 0.29449898, green: 0.7723554969, blue: 0.1144918874, alpha: 1) ; return Color(c) }

    static var myBlue    :Color{ let c =  #colorLiteral(red    : 0.3247125745, green    : 0.5099535584, blue    : 0.7809648514, alpha    : 1) ; return Color(c) }
    
    static var myPurple    :Color{ let c =  #colorLiteral(red: 0.6159889102, green: 0.3976619244, blue: 0.7825508118, alpha: 1) ; return Color(c) }

    static var myYellow    :Color{ let c =  #colorLiteral(red: 0.8939641118, green: 0.5566363335, blue: 0, alpha: 1) ; return Color(c) }
}

//MARK: ------------ 路径 ------------
enum Link: String{
    case go2_File         = "/Users/unitree/Desktop/Project/go2"
    case go2_Project      = "/Users/unitree/Desktop/Project/go2/Go2.xcodeproj"
    case go2_Excel        = "/Users/unitree/Desktop/Project/go2/Script/翻译表.xls"
    case go2_Archive_CN   = "/Users/unitree/Desktop/Project/打包/Go2_CN打包.app"
    case go2_Archive_OS   = "/Users/unitree/Desktop/Project/打包/Go2_OS打包.app"

    case b2_File          = "/Users/unitree/Desktop/Project/b2"
    case b2_Project       = "/Users/unitree/Desktop/Project/b2/B2.xcodeproj"
    case b2_Archive       = "/Users/unitree/Desktop/Project/打包/B2打包.app"

    case sim_File         = "/Users/unitree/Desktop/Project/Unitree exp"
    case sim_Project      = "/Users/unitree/Desktop/Project/Unitree exp/Unitree exp.xcodeproj"
    
    case go2_distTimeFile = "/Users/unitree/Desktop/Project/go2/Go2/dist/time.json"
    case b2_distTimeFile  = "/Users/unitree/Desktop/Project/b2/B2/dist/time.json"
    
    case others_Project_NLV = "/Users/unitree/Desktop/Project/NLV/NLV.xcodeproj"
    case others_Project_DeskTool = "/Users/unitree/Desktop/Project/DeskTool/DeskTool.xcodeproj"
    case others_Project_Pump_CN = "/Users/unitree/Desktop/Project/UnitreePump/ys715.xcworkspace"
    case others_Project_Pump_OS = "/Users/unitree/Desktop/Project/FitnessPump/Fitness Pump.xcworkspace"
    case others_Project_Pump_India = "/Users/unitree/Desktop/Project/Pump印度/Fitness Pump.xcworkspace"
}

///
//MARK: ------------ 脚本 ------------
enum PY_CMD: String{
    
    case go2_UpdateWeb   = "/Users/unitree/Desktop/Project/go2/Script/更新前端.sh"
    case go2_UpdateExcel = "/Users/unitree/Desktop/Project/go2/Script/翻译映射.sh"
    
    case b2_UpdateWeb    = "/Users/unitree/Desktop/Project/b2/Script/更新前端.sh"
    case b2_UpdateExcel  = "/Users/unitree/Desktop/Project/b2/Script/翻译映射.sh"

    case sim_UpdateWeb   = "/Users/unitree/Desktop/Project/Unitree exp/updateWebDir.py"

    func needWindow() -> Bool{
        switch self {
        case .go2_UpdateWeb:
            return true
        case .go2_UpdateExcel:
            return false
        case .b2_UpdateWeb:
            return true
        case .b2_UpdateExcel:
            return false
        case .sim_UpdateWeb:
            return true
        }
    }
}
