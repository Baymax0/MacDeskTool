//
//  MainView_go2.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

struct MainView_go2: View {
    /// 备注信息
    @State var markString:String = "1"
    let markCacheKey:CacheKey = .mark_go2
    /// (版本号,build号)
    @State var version:(String,String) = ("","")
    /// 显示下载二维码
    @State var showCode:Bool = false // go2_download
    var downloadURl = "https://flowus.cn/share/2d06ea2a-b91b-4cdf-aaa0-1acf7abefd85?code=ZWN81R"
    
    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            HStack(spacing:5){
                ShieldsView(title: "版本号", value: $version.0, color: .myRed)
                ShieldsView(title: "Build", value: $version.1, color: .myGreen)
            }
            HStack(spacing:12){
                FlowBtn(img: "pc"){ ToolFunc.openPath(.go2_Project) }
                FlowBtn(img: "folder"){ ToolFunc.openPath(.go2_File) }
                FlowBtn(img: "tablecells"){ ToolFunc.openPath(.go2_Excel) }
                FlowBtn(img: "qrcode"){ showCode = true }
            }.padding(.vertical, 8)
            
            //MARK: ------------   ------------
            HStack(spacing:12){
                FlowBtn_Long(img: "play.fill",title: "更新web", cmdType: .go2_UpdateWeb)
                FlowBtn_Long(img: "play.fill",title: "更新翻译", cmdType: .go2_UpdateExcel)
            }
            MyTextEditor(text: $markString).padding(.top, 8)
        }
        .mainViewBg()
        .overlay(content: {
            AppDownloadView(showCode: $showCode, downloadURl: downloadURl, img: .go2Download)
        })
        .onAppear {
            version = ToolFunc.getVersion(.go2_Project)
            showCode = false
            markString = Cache.getMark(key: markCacheKey)
        }.onDisappear(perform: {
            Cache.save(key: markCacheKey, value: markString)
        })
    }
    
}

#Preview {
    MainView_go2()
}

