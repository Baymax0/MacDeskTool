//
//  AuthenticatorUrlModel.swift
//  DeskTool
//
//  Created by unitree on 2024/4/17.
//

import Foundation
import SwiftData
import SwiftOTP

// App全局的缓存内容
@Model
final class AuthenticatorUrlModel: SD_BaseModel{
    @Attribute(.unique)
    var mark: String // 备注
    var name: String = "" // 账号名称
    var secret: String = "" // 对应secret
    
    init(mark: String,name: String, secret: String) {
        self.mark = mark
        self.name = name
        self.secret = secret
    }
    
    func getCode() -> String{
        return AuthenticatorUrlModel.getCodeWithSecret(self.secret)
    }
    /// OSS "NRZXUF5ZTH6ABJXTIYCHSNBSDYSJOLJVZJYAIYDNVXVDPWMVQGW2OEFRT7MHBZY5"
    static func  getCodeWithSecret(_ secret:String) -> String{
        let data = secret.base32DecodedData!
        let generator = try! Generator(factor: .timer(period: 30),
                                       secret: data,
                                       algorithm: .sha1,
                                       digits: 6)
        let pwd = (try? generator.password(at: Date())) ?? ""
        return pwd
    }
    
}
