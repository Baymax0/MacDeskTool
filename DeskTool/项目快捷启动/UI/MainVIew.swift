//
//  MainVIew.swift
//  DeskTool
//
//  Created by unitree on 2024/3/18.
//

import SwiftUI

struct MainVIew: View {
    
    @State var choosed:Int = 0
    
    @State var timeString:String? = nil
    
    @State var textBgColor:Color = .textColor
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var h:Int = 1
    @State var m:Int = 1
    @State var s:Int = 1
    
    var body: some View {
        HStack(spacing:4){
            VStack(spacing:7){
                if timeString != nil{
                    ClockChooseView(h: $h, m: $m, s: $s, numBgColor: $textBgColor, w: 22)
                }
                ZStack(alignment:.top){
                    MainView_go2()
                        .opacity(choosed == 0 ? 1:0)
                    MainView_b2()
                        .opacity(choosed == 1 ? 1:0)
                    MainView_sim()
                        .opacity(choosed == 2 ? 1:0)
                    VStack(spacing:16){ MainView_715_CN(); MainView_715_OS()}
                        .opacity(choosed == 3 ? 1:0)
                    MainView_Others()
                        .opacity(choosed == 4 ? 1:0)
                }.frame(width: 187,alignment: .top)
                Spacer()
            }.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: timeString)
            
            VStack{
                MainView_Head(choosed: $choosed)
                Spacer()
            }
        }.onReceive(timer, perform: { _ in
            self.handleTimer()
        })
        .padding(10)
    }
    
    static func getHostView() -> NSHostingView<MainVIew>{
        let content = MainVIew()
        return MyHostingView(rootView: content)
    }
    
    func handleTimer() {
        if let time = Cache.getFinishWorkTime(){
            var value = Int(Date().timeIntervalSince(time))
            var fuHao = ""
            if value >= 0{
                fuHao = "-"
                textBgColor = .myRed
                if value % 2 == 0{
                    textBgColor = .textColor
                }else{
                    textBgColor = .myRed
                }
            }else{
                value = -value
                if value > 600{
                    textBgColor = .textColor
                }else{
                    if value % 2 == 0{
                        textBgColor = .textColor
                    }else{
                        textBgColor = .myYellow
                    }
                }
            }
            h = value / 3600
            value = value % 3600
            m = value / 60
            s = value % 60
            timeString = String(format: "\(fuHao)%02d:%02d:%02d", h,m,s)
            
        }else{
            timeString = nil
        }
    }
}


#Preview {
    MainVIew().padding(.top, 20)
}

