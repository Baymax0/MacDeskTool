//
//  SDManager.swift
//  DeskTool
//
//  Created by unitree on 2024/3/26.
//

import SwiftData
import Foundation

@ModelActor
actor SDCache{
    /// Models
    static let SDModels_V1:[any PersistentModel.Type] = [
        AppCache.self,
        AuthenticatorUrlModel.self
    ]
    /// 版本号
    static var VersionIdentifier = Schema.Version.init(1, 0, 1)

    /// 上下文
    static var context:ModelContext?
    
    /// 初始化
    static func config(){
        guard SDCache.context == nil else { return }
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "")  + "/cache.sqlit"
        let pathURL = URL.init(filePath: path)
        
        let scheme = Schema(SDModels_V1,version: VersionIdentifier)
        if let container = try? ModelContainer(for: scheme, configurations: .init(url: pathURL)){
            SDCache.context = ModelContext(container)
            print("SwiftData 初始化成功 ✅ v:\(container.schema.version.description)")
        }else{
            print("SwiftData 初始化失败 ❌")
        }
    }
    
}

//MARK: ------------ MigrationPlan ------------
//enum MyMigrationPlan: SchemaMigrationPlan{
//
//    static var schemas: [VersionedSchema.Type]{ [Schema_V1.self] }
//    static var stages: [MigrationStage]{[]}
//}



