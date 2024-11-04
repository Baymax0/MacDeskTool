//
//  FlowBtn.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

/// 按钮
struct FlowBtn:View {
    let imgColor = Color.black.opacity(0.7)
    let bg = #colorLiteral(red: 0.8951551914, green: 0.8899336457, blue: 0.8987590671, alpha: 1)
    var w:CGFloat = 26
    
    @State var img:String
    @State var isHovering:Bool = false

    var action: (() -> Void)
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: w / 3.5, height: w / 3.5))
                .frame(width: w, height: w)
                .foregroundStyle(isHovering ? Color.black.opacity(0.06) : Color(bg))
                .shadow(color: .black.opacity(0.1 ), radius: 4, x: 4, y: 4)
                .shadow(color: .white.opacity(0.6), radius: 3, x: -4, y: -4)
            RoundedRectangle(cornerSize: CGSize(width: w / 3.5, height: w / 3.5))
                .stroke(lineWidth: 4)
                .frame(width: w, height: w)
                .foregroundStyle(LinearGradient(colors: [.black.opacity(0.06), .gray.opacity(0.01), .black.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            Button(action: {
                action()
            }, label: {
                Image(systemName: img)
                    .resizable()
                    .frame(width: w / 2, height: w / 2)
                    .foregroundStyle(imgColor)
            }).buttonStyle(.plain)
        }.onHover(perform: { hovering in
            isHovering = hovering
        })
    }
}

/// 按钮
struct FlowBtn_Long:View {
    
    let bg = #colorLiteral(red: 0.8951551914, green: 0.8899336457, blue: 0.8987590671, alpha: 1)
    var w:CGFloat = 72
    var h:CGFloat = 26
    @State var img:String
    @State var title:String
    
    /// 鼠标悬浮事件
    @State var contentTintColor:Color = Color.black.opacity(0.7)
    @State var isHovering:Bool = false
    let unHover_Color = Color.black.opacity(0.7)
    let Hover_Color = Color.myBlue
    
    /// 点击事件
    var cmdType:PY_CMD
    @State var isLoading:Bool = false
    @State var loadingState:Int = 0 // 0=normal, 1=success, -1=error
    
    var body: some View {
        ZStack{
            HStack(spacing: 3){
                Image(systemName: img)
                    .font(.system(size: 10,weight: .medium))
                    .foregroundStyle(Color(isHovering ? .white : unHover_Color))
                    .offset(x:isHovering ? 22 : 0)
                    .animation(.easeOut(duration: 0.42), value: isHovering)
                    .opacity(isLoading ? 0 : 1)
                Text(title)
                    .font(.system(size: 10,weight: .medium))
                    .foregroundStyle(Color(isHovering ? .clear : unHover_Color))
                    .animation(.easeOut(duration: 0.15), value: isHovering)
                    .opacity(isLoading ? 0 : 1)
            }
            .overlay { // 点击的 加载 和 结果
                ZStack{
                    Image(systemName: "xmark.circle").foregroundStyle(.red).font(.system(size: 15).bold())
                        .opacity(loadingState == -1 ? 1 : 0)
                    Image(systemName: "checkmark.circle").foregroundStyle(Color.myGreen).font(.system(size: 15).bold())
                        .opacity(loadingState == 1 ? 1 : 0)
                    HalfCircleIndicator(loading: $isLoading)
                        .opacity(loadingState == 0 ? 1 : 0)
                        .animation(.easeOut(duration: 0.4), value: loadingState)
                }
                .opacity(isLoading ? 1 : 0)
            }
            .padding(.horizontal, 6)
            .frame(width: w, height: h)
            .background {
                RoundedRectangle(cornerSize: CGSize(width: h / 3.5, height: h / 3.5))
                    .frame(height: h)
                    .foregroundStyle((isHovering && isLoading == false) ? Hover_Color : Color(bg))
                    .animation(.easeOut(duration: 0.3), value: isHovering)
                    .shadow(color: .black.opacity(0.1 ), radius: 5, x: 4, y: 4)
                    .shadow(color: .white.opacity(0.6), radius: 4, x: -5, y: -5)
                RoundedRectangle(cornerSize: CGSize(width: h / 3.5, height: h / 3.5))
                    .stroke(lineWidth: 4)
                    .frame(height: h)
                    .foregroundStyle(LinearGradient(colors: [.black.opacity(0.06), .gray.opacity(0.01), .black.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing))
            }.onHover(perform: { hovering in
                isHovering = hovering
            })
            .onTapGesture {
                if isLoading == true { return }
                self.isLoading = true
                self.loadingState = 0
                Task{
                    if cmdType.needWindow() == true{
                        ToolFunc.openPath(cmdType)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                            self.isLoading = false
                        }
                    }else{
                        let result = await ToolFunc.runCMD(cmdType)
                        if result == true{
                            loadingState = 1
                        }else{
                            loadingState = -1
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.isLoading = false
                            self.loadingState = 0
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VStack(spacing:16){
        FlowBtn(img: "pc") {}
        FlowBtn_Long(img: "play.fill", title: "更新翻译", cmdType: .go2_UpdateWeb)
    }
    .padding(30)
    .background {
        Color.bg
    }
}



struct HalfCircleIndicator:View {
    @Binding var loading:Bool
    
    @State var degrees:CGFloat = 0
    @State var animationResult:Int = 1
    
    let timer = Timer.publish(every: 0.6, on: .main, in: .common)
    var body: some View {
        content()
        .opacity(loading ? 1 : 0)
        .animation(.linear(duration: 0.25), value: loading)
    }
    
    @ViewBuilder
    func content() -> some View{
        VStack(alignment:.leading){
            ZStack{
                Group{
                    Circle().trim(from: 0, to: 0.1)
                        .stroke(
                            AngularGradient(colors: [.black], center: .center),
                            style: .init(lineWidth: 3, lineCap: .round)
                        )
                    Circle().trim(from: 0.5, to: 0.6)
                        .stroke(
                            AngularGradient(colors: [.black], center: .center),
                            style: .init(lineWidth: 3, lineCap: .round)
                        )
                }
                .frame(width: 60, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(.degrees(degrees))
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: false), value: degrees)
            }
        }
        .onAppear(perform: {
            self.degrees = 180
        })
    }
}
