//
//  MainViewBgStyle.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

/// 大背景样式
extension View{
    public func mainViewBg() -> some View{
        modifier(MainViewBgStyle())
    }
}
struct MainViewBgStyle: ViewModifier {
   func body(content: Content) -> some View {
       content
           .padding(.vertical, 12)
           .padding(.horizontal, 12)
           .frame(width: 187)
           .background { Color.bg }
           .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
           .overlay(content: {
               RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)).stroke(Color.white.opacity(0.7), lineWidth: 2)
           })
   }
}
