//
//  FlowBtn_Dark.swift
//  DeskTool
//
//  Created by unitree on 2024/5/30.
//

import SwiftUI

struct FlowBtn_Dark: View {
    let imgColor = Color.white.opacity(0.7)
    let bg:Color = .tinyImgBg
//    var w:CGFloat = 46
    
    @State var img:String
    @State var w:CGFloat
    @State var isHovering:Bool = false

    var action: (() -> Void)
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: w / 3.5, height: w / 3.5))
                .frame(width: w, height: w)
                .foregroundStyle(isHovering ? Color.white.opacity(0.06) : Color(bg))
                .shadow(color: .gray.opacity(0.24), radius: 4, x: -2, y: -2)
                .shadow(color: .black.opacity(0.6), radius: 5, x: 2, y: 2)
//            RoundedRectangle(cornerSize: CGSize(width: w / 3.5, height: w / 3.5))
//                .stroke(lineWidth: 4)
//                .frame(width: w, height: w)
//                .foregroundStyle(LinearGradient(colors: [.black.opacity(0.06), .gray.opacity(0.01), .black.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            Button(action: {
                action()
            }, label: {
                Image(systemName: img)
                    .resizable()
                    .frame(width: w / 2.5, height: w / 2.5)
                    .foregroundStyle(.gray)
            }).buttonStyle(.plain)
        }
//        .onHover(perform: { hovering in
//            isHovering = hovering
//        })
    }
    
    static func getHostView(img:String, w:CGFloat,action: @escaping (() -> Void)) -> NSHostingView<FlowBtn_Dark>{
        let content = FlowBtn_Dark(img: img, w: w, action: action)
        return MyHostingView(rootView: content)
    }
}

#Preview {
    FlowBtn_Dark(img: "pc", w: 46) {}
        .padding(48)
        .background(Color.tinyImgBg)
}
