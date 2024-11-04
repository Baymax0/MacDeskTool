//
//  PipManager.swift
//  DeskTool
//
//  Created by unitree on 2024/3/7.
//

import Cocoa
import WebKit

class JSFullSCManager: NSObject {
    static var bilibili: String {
        let jsFile = Bundle.main.path(forResource: "bili", ofType: "js")
        let str = try? String(contentsOf: URL(filePath: jsFile!), encoding: .utf8)
        return str ?? ""
    }
}
