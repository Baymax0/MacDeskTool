//
//  AppCache.swift
//  DeskTool
//
//  Created by unitree on 2024/4/2.
//

import Foundation
import SwiftData

// App全局的缓存内容
@Model
final class AppCache: SD_SingleModel{
    
    /// 默认单利对象
    static var share: AppCache {
        var m = getAll().first
        if m == nil{
            m = AppCache()
            context?.insert(m!)
        }
        return m!
    }
    
    @Attribute(.unique)
    var id: String = "unique"
    var tempString: String! = "default"
    var tempBool = false
    
    /// TinyPng Key,密钥
    var tinyPngKey:String = "L0wzc0p5F63pJKdPX9cLr30YhCfzPKZ2"
    /// TinyPng 剩余额度
    var tinyPngTokenNum = 500
    /// 保存路径，“” 表示替换
    var tinyPngSaveLocation:String = ""

    init() {}
    
}
