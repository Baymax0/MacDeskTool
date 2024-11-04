//
//  MainView_Others.swift
//  DeskTool
//
//  Created by unitree on 2024/3/22.
//

import SwiftUI

struct MainView_Others: View {
    
    @State var isClockOn: Bool = false
    
    @State var h:Int = 21
    @State var m:Int = 0
    @State var s:Int = 0
    @State var numBgColor:Color = Color.black.opacity(0.8)

    var body: some View {
        VStack{
            VStack(alignment:.leading, spacing: 8){
                //MARK: ------------ Project ------------
                HStack(spacing:6){
                    Group{
                        VStack(alignment: .leading){
                            Text("🗂️ DeskTool").font(.system(size: 10, weight: .semibold)).foregroundStyle(Color.myRed)
                            HStack(spacing:10){
//                                FlowBtn(img: "pc"){ ToolFunc.openPath(.deskTool_Project) }
//                                FlowBtn(img: "folder"){ ToolFunc.openPath(.deskTool_File) }
                            }
                        }
                        VStack(alignment: .leading){
                            Text("👩 LS").font(.system(size: 12, weight: .semibold)).foregroundStyle(Color.myYellow)
                            HStack(spacing:10){
//                                FlowBtn(img: "pc"){ ToolFunc.openPath(.ls_Project) }
//                                FlowBtn(img: "folder"){ ToolFunc.openPath(.ls_File) }
                            }
                        }
                    }   .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1.0)
                        }
                }
                VSpacer(h: 1)
                //MARK: ------------ WorkOff ------------
                Text(" Time Over").foregroundStyle(Color.myGreen).font(.system(size: 10).bold())
                HStack{
                    ClockChooseView(h: $h, m: $m, s: $s, numBgColor:$numBgColor, w:26)
                        .padding(.horizontal, 8)
                        .height(40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1.0)
                        }
                    //                Text("📢").height(42).weight(44)
                    
                    Button { self.changeClockState() } label: { Text("📢").height(36).weight(34) }
                        .buttonStyle(.plain)
                        .background(content: { Color.black.opacity(isClockOn ? 0.8 : 0) })
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1.0)
                        }
                }.onAppear(perform: {
                    self.checkClock()
                })
            }
            .mainViewBg()
            
            MainView_CacheTest()
                .mainViewBg()
        }
    }
    
    func checkClock(){
        if let time = Cache.getFinishWorkTime(){
            h = Int(time.hourString) ?? 21
            m = Int(time.minuteString) ?? 0
            s = Int(time.secendString) ?? 0
            isClockOn = true
            return
        }
        isClockOn = false
    }
    
    func changeClockState(){
        if isClockOn == false{
            /// 打开
            isClockOn = true
            Cache.saveFinishWorkTime(h, m, s)
        }else{/// 关闭
            isClockOn = false
            Cache.saveFinishWorkTime(nil, nil, nil)
        }
    }
}

#Preview {
    MainView_Others()
}

struct ClockChooseView:View {
    
    @Binding var h:Int
    @Binding var m:Int
    @Binding var s:Int
    
    @Binding var numBgColor:Color
    
    var w:CGFloat = 33
    
    var body: some View {
        HStack(spacing:4){
            TimeLab(String(format: "%02d", h))
            Text(":").foregroundStyle(Color.textColor).font(.system(size: w/2).bold())
            TimeLab(String(format: "%02d", m))
                .onTapGesture(perform: {
                    var value = m + 2
                    m = value == 60 ? 0 : value
                })
            Text(":").foregroundStyle(Color.textColor).font(.system(size: w/2).bold())
            TimeLab(String(format: "%02d", s))
        }
    }
    
    @ViewBuilder
    func TimeLab(_ str:String) -> some View{
        Text(str).font(.system(size: w/2)).frame(width: w, height: w)
            .background {
                RoundedRectangle(cornerRadius: 6).fill(numBgColor)
            }
    }
}
