//
//  Frame+.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

/// 设置View宽和高
extension View{
    
    public func height(_ h:CGFloat) -> some View{
        modifier(View_Heght(h: h))
    }
    
    public func weight(_ w:CGFloat) -> some View{
        modifier(View_Weight(w: w))
    }
    
    public func rightConstant(_ c:CGFloat) -> some View{
        modifier(View_Right(constant: c))
    }
    public func bottomConstant(_ c:CGFloat) -> some View{
        modifier(View_Botton(constant: c))
    }
}

struct View_Heght: ViewModifier {
    @State var h:CGFloat
   func body(content: Content) -> some View {
       content
           .frame(height: h)
   }
}

struct View_Weight: ViewModifier {
    @State var w:CGFloat
   func body(content: Content) -> some View {
       content
           .frame(width: w)
   }
}

struct View_Right: ViewModifier {
    @State var constant:CGFloat
   func body(content: Content) -> some View {
       HStack{
           Spacer()
           content
           Spacer().frame(width: constant)
       }
   }
}

struct View_Botton: ViewModifier {
    @State var constant:CGFloat
   func body(content: Content) -> some View {
       VStack{
           Spacer()
           content
           Spacer().frame(height: constant)
       }
   }
}
