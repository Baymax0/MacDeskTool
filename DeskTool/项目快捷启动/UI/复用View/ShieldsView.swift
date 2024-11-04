//
//  ShieldsView.swift
//  DeskTool
//
//  Created by unitree on 2024/3/20.
//

import SwiftUI

/// 按钮
struct ShieldsView:View {
    @State var title:String
    @Binding var value:String
    @State var color:Color = Color.myRed
    var body: some View {
        HStack(spacing:2){
            Text(title)
                .foregroundStyle(Color.white).font(.system(size: 9))
                .padding(EdgeInsets(top: 3, leading: 4, bottom: 3, trailing: 4))
                .background {
                    Rectangle().fill(Color.textColor)
                }
            Text(value)
                .foregroundStyle(Color.white).font(.system(size: 9))
                .padding(.leading, 3)
                .padding(.trailing, 4)
        }.background {
            Rectangle().fill(color)
        }
    }
}

#Preview {
    ShieldsView(title: "版本", value: .constant("1.1.1"))
        .padding(12)
}
