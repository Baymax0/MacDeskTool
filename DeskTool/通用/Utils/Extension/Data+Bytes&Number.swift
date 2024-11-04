//
//  Data+Bytes&Number.swift
//  YSBase
//
//  Created by unitree on 2024/1/2.
//  Copyright © 2024 unitree.lee. All rights reserved.
//

import Foundation

extension Data {
    public func toString() -> String?{
        return String.init(data: self, encoding: String.Encoding.utf8)
    }
    
    public var toBytes:[UInt8]? {
        if self.count == 0{
            return nil
        }
        let bytes = [UInt8](self)
        return bytes
    }
}

extension String {
    public func toData() -> Data{
        self.data(using: String.Encoding.utf8)!
    }
}


extension Numeric {
    public var toData: Data {
        var source = self
        // This will return 1 byte for 8-bit, 2 bytes for 16-bit, 4 bytes for 32-bit and 8 bytes for 64-bit binary integers. For floating point types it will return 4 bytes for single-precision, 8 bytes for double-precision and 16 bytes for extended precision.
        return .init(bytes: &source, count: MemoryLayout<Self>.size)
    }
}

extension Numeric {
    public init<D: DataProtocol>(_ data: D) {
        var value: Self = .zero
        let size = withUnsafeMutableBytes(of: &value, { data.copyBytes(to: $0)} )
        assert(size == MemoryLayout.size(ofValue: value))
        self = value
    }
}

extension Array where Element == UInt8 {
    public var toData: Data{
        return Data(self)
    }
    
    public var toDouble: Double!{
        let v = Double(self.toData)
        if v.isNaN { return 0}
        return v
    }
    
    public var toFloat32: Float32!{
        let v = Float32(self.toData)
        if v.isNaN { return 0}
        return v
    }
}

extension ArraySlice {
    public var toArray: Array<Element>{
        return Array(self)
    }
}

extension Float32{
    public var toDouble:Double{
        Double(self)
    }
}
