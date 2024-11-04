//
//  Cache.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import Foundation

enum CacheKey:String{
    case mark_go2 = "markTF_Go2"
    case mark_b2 = "markTF_B2"
    case mark_sim = "markTF_Sim"
    case mark_up = "markTF_UP"
    case mark_fp = "markTF_FP"
    
    case nextFinishWorkTime = "nextFinishWorkTime"

}

class Cache{
    static let cacheKey = "MarkDic"
    static var cacheDic:Dictionary<String,Any>!
    
    static func getMark(key:CacheKey) -> String{
        if cacheDic == nil{
            cacheDic = UserDefaults.standard.dictionary(forKey: cacheKey) ?? [:]
        }
        return (cacheDic[key.rawValue] as? String) ?? ""
    }
    
    static func save(key:CacheKey, value:String){
        if cacheDic == nil{
            cacheDic = UserDefaults.standard.dictionary(forKey: cacheKey) ?? [:]
        }
        cacheDic[key.rawValue] = value
        UserDefaults.standard.setValue(cacheDic, forKey: cacheKey)
    }
    
    static func saveFinishWorkTime(_ h:Int?,_ m:Int?, _ s:Int?){
        if cacheDic == nil{
            cacheDic = UserDefaults.standard.dictionary(forKey: cacheKey) ?? [:]
        }
        if h == nil{
            cacheDic[CacheKey.nextFinishWorkTime.rawValue] = nil
        }else{
            let tS = Date().toString("yyyy-MM-dd") + String(format: " %02d:%02d:%02d", h!,m!,s!)
            cacheDic[CacheKey.nextFinishWorkTime.rawValue] = tS
        }
        UserDefaults.standard.setValue(cacheDic, forKey: cacheKey)
    }
    
    static func getFinishWorkTime() -> Date?{
        if cacheDic == nil{
            cacheDic = UserDefaults.standard.dictionary(forKey: cacheKey) ?? [:]
        }
        guard let saveV = cacheDic[CacheKey.nextFinishWorkTime.rawValue] as? String else { return nil}
        let date = saveV.toDate()
        guard date?.isToday == true else { return nil }
        return date
    }
}
