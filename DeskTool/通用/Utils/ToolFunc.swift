//
//  ToolFunc.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import Cocoa

class ToolFunc{
    /// 使用系统默认打开方式
    static func openPath(_ link:Link){
        let url = URL(filePath: link.rawValue)
        NSWorkspace.shared.open(url)
    }
    
    static func openPath(_ py:PY_CMD){
        let url = URL(filePath: py.rawValue)
        NSWorkspace.shared.open(url)
    }
    
    static func openWebUrl(_ url:String){
        if let url = URL(string: url){
            NSWorkspace.shared.open(url)            
        }
    }
    /// 获得Xcode项目版本，
    static func getVersion(_ base:Link) -> (String,String){
        let path = base.rawValue + "/project.pbxproj"
        let fileContents = (try? String(contentsOf: URL(filePath: path))) ?? ""
        let v = self.find(key: "MARKETING_VERSION", in: fileContents)
        let b = self.find(key: "CURRENT_PROJECT_VERSION", in: fileContents)
        return (v,b)
    }
    
    static func setBuild(_ base:Link, from fBuild:String, to tBuild:String){
        let fromStr = "CURRENT_PROJECT_VERSION = \(fBuild)"
        let toStr = "CURRENT_PROJECT_VERSION = \(tBuild)"
        let path = base.rawValue + "/project.pbxproj"
        let url = URL(filePath: path)
        let fileContents = (try? String(contentsOf: url)) ?? ""
        let newContents = fileContents.replacingOccurrences(of: fromStr, with: toStr)
        try? newContents.write(to: url, atomically: true, encoding: .utf8)
    }
    
    /// 获得Web版本
    static func getWebVersion(_ base:Link) -> (String,String){
        let path = base.rawValue
        var fileContents = (try? String(contentsOf: URL(filePath: path))) ?? ""
        fileContents = fileContents.trimmingCharacters(in: .whitespacesAndNewlines)
        let arr = fileContents.components(separatedBy: "\n")
        let v = arr[0]
        let t = arr[1]
        return (v,t)
    }
    
    static func find(key:String,in fileContents:String) -> String{
        let regex = try! NSRegularExpression(pattern: "\(key) = ((\\d)|\\.)+\\s*", options: [])
        let matches = regex.matches(in: fileContents, options: [], range: NSRange(location: 0, length: fileContents.utf16.count))
        let range = Range(matches.first!.range, in: fileContents)!
        let versionString = String(fileContents[range])
        let value = versionString.components(separatedBy: " ").last
        return value ?? ""
    }

    static func runCMD(_ cmd:PY_CMD) async -> Bool{
        let pipe = Pipe()
        
        let task = Process()
        task.launchPath = "/bin/zsh"
        task.arguments = ["-c", cmd.rawValue]
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        print(output)
        if output.contains("-- Finish --"){
            return true
        }else{
            return false
        }
    }
    
    

}




