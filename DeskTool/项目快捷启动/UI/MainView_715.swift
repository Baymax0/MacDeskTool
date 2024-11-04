//
//  MainView_715.swift
//  DeskTool
//
//  Created by unitree on 2024/3/21.
//

import SwiftUI

struct MainView_715_CN: View {
    @State var markString:String = "1"
    let markCacheKey:CacheKey = .mark_up

    /// (版本号,build号)
    @State var version:(String,String) = ("","")
    @State var market = "国内"
    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            HStack(spacing:5){
                ShieldsView(title: "版本", value: $version.0, color: .myRed)
                ShieldsView(title: "Build", value: $version.1, color: .myGreen)
                ShieldsView(title: "M", value:$market, color: .myBlue)
            }
            HStack(spacing:16){
//                FlowBtn(img: "pc"){ ToolFunc.openPath(.pump_CN_Project) }
//                FlowBtn(img: "folder"){ ToolFunc.openPath(.pump_CN_File) }
            }.padding(.vertical, 8)
            
            MyTextEditor(text: $markString)
        }
        .mainViewBg()
        .onAppear {
//            version = ToolFunc.getVersion(.pump_CN_Project)
//            markString = Cache.getMark(key: markCacheKey)
        }.onDisappear(perform: {
            Cache.save(key: markCacheKey, value: markString)
        })
    }
}

struct MainView_715_OS: View {
    @State var markString:String = "1"
    let markCacheKey:CacheKey = .mark_fp

    /// (版本号,build号)
    @State var version:(String,String) = ("","")
    @State var market = "海外"

    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            HStack(spacing:5){
                ShieldsView(title: "版本", value: $version.0, color: .myRed)
                ShieldsView(title: "Build", value: $version.1, color: .myGreen)
                ShieldsView(title: "M", value:$market, color: .myPurple)

            }
            HStack(spacing:16){
//                FlowBtn(img: "pc"){ ToolFunc.openPath(.pump_CN_Project) }
//                FlowBtn(img: "folder"){ ToolFunc.openPath(.pump_OS_File) }
            }.padding(.vertical, 8)
            
            MyTextEditor(text: $markString)
        }
        .mainViewBg()
        .onAppear {
//            version = ToolFunc.getVersion(.pump_OS_Project)
//            markString = Cache.getMark(key: markCacheKey)
        }.onDisappear(perform: {
            Cache.save(key: markCacheKey, value: markString)
        })
    }
}

#Preview {
    VStack{
        MainView_715_CN()
        MainView_715_OS()
    }
}
