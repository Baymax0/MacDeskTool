//
//  Macro.swift
//  DeskTool
//
//  Created by unitree on 2024/6/7.
//

import Foundation
import Cocoa

//MARK: ------------ Noti ------------
public let noti = NotificationCenter.default
public extension NSNotification.Name {
    /// 验证码过期 需要从新登陆
    static let tinyPng_upload_Success = NSNotification.Name("tinyPng_upload_Success")
}

