//
//  FileInfo.swift
//  TinyPNG4Mac
//
//  Created by kyleduo on 2019/9/26.
//  Copyright © 2019 kyleduo. All rights reserved.
//

import Foundation

class FileInfo {
    var filePath: URL
    var relativePath: String
    var uuid:String = UUID().uuidString
    
    var orignalSize:Double = 0
    
    init(_ filePath: URL, relativePath: String) {
        self.filePath = filePath
        self.relativePath = relativePath
        self.orignalSize = self.getFileSize()
    }
    
    func getFileSize() -> Double{
        let manager = FileManager.default
        let attributes = try? manager.attributesOfItem(atPath: filePath.path)
        let size = (attributes![FileAttributeKey.size]! as AnyObject).doubleValue!
        return size
    }
}
