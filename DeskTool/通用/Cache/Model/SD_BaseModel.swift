//
//  SD_BaseModel.swift
//  DeskTool
//
//  Created by unitree on 2024/4/2.
//

import SwiftData

//MARK: ------------ 对象遵循的协议 ------------
protocol SD_BaseModel:PersistentModel {
    /// 获得上下文
    static var context:ModelContext? { get }
    /// 存档
    func update()
    /// 存档
    static func update()
    /// 获取所有数据
    static func getAll() -> [Self]
}

//MARK: ------------ 单利对象遵循的协议 ------------
protocol SD_SingleModel:SD_BaseModel {
    static var share:Self { get }
}


extension SD_BaseModel{
    
    static var context:ModelContext?{
        return SDCache.context
    }
    
    func insert(){
        SDCache.context?.insert(self)
        Self.update()
    }
    
    func update(){
        Self.update()
    }
    
    static func update(){
        try? context?.save()
    }
    
    func delete(){
        SDCache.context?.delete(self)
        Self.update()
    }
    
    /// 获取所有数据
    static func getAll() -> [Self]{
        return (try? context?.fetch(FetchDescriptor<Self>())) ?? []
    }
}


