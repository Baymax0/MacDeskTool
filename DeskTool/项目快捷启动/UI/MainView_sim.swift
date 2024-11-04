//
//  MainView_sim.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI
struct MainView_sim: View {
    /// 备注信息
    @State var markString:String = "1"
    let markCacheKey:CacheKey = .mark_sim
    /// (版本号,build号)
    @State var version:(String,String) = ("","")
    /// 显示下载二维码
    @State var showCode:Bool = false // go2_download
    var downloadURl = "https://flowus.cn/share/ddd9f81e-463b-425d-acd7-f248a2c280e2?code=ZWN81R"

    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            HStack(spacing:5){
                ShieldsView(title: "版本号", value: $version.0, color: .myRed)
                ShieldsView(title: "Build", value: $version.1, color: .myGreen)
            }
            
            HStack(spacing:12){
                FlowBtn(img: "pc"){ ToolFunc.openPath(.sim_Project) }
                FlowBtn(img: "folder"){ ToolFunc.openPath(.sim_File) }
                FlowBtn(img: "qrcode"){ showCode = true }
            }.padding(.vertical, 8)
            
            HStack(spacing:12){
                FlowBtn_Long(img: "play.fill",title: "更新web", cmdType: .sim_UpdateWeb)
            }
    
            MyTextEditor(text: $markString).padding(.top, 8)
        }
        .mainViewBg()
        .overlay(content: {
            AppDownloadView(showCode: $showCode, downloadURl: downloadURl, img: .simdownload)
        })
        .onAppear {
            version = ToolFunc.getVersion(.sim_Project)
            showCode = false
            markString = Cache.getMark(key: markCacheKey)
        }.onDisappear(perform: {
            Cache.save(key: markCacheKey, value: markString)
        })
    }

}

#Preview {
    MainView_sim()
}
