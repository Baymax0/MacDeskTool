//
//  MainView_Head.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

struct MainView_Head: View {
    
    @Binding var choosed:Int
    
    var body: some View {
        VStack{
            VStack(spacing:0){
                ForEach(ProjectArr, id: \.index) { p in
                    MainItemCell(index : p.index, imgName : p.icon, choosed : $choosed)
                }
            }
        }
        .animation(.easeOut, value: choosed)
    }
}

struct MainItemCell:View {
    var index:Int = 0
    var imgName:ImageResource
    @Binding var choosed:Int
    
    var rectW:CGFloat = 32
    
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .fill(self.choosed == index ? Color.bg : .clear)
                .frame(width: rectW, height: rectW)
                .padding(8)
            if self.choosed == index{
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                    .stroke(lineWidth: 4)
                    .frame(width: rectW, height: rectW)
                    .foregroundStyle(LinearGradient(colors: [.black.opacity(0.06), .gray.opacity(0.01), .black.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            Image(imgName)
                .resizable()
                .frame(width: 22, height: 22)
        }
        .offset(CGSize(width: self.choosed == index ? 0 : -4.0, height: 0))
        .frame(width: 36, height: self.choosed == index ? 42 : 36)
        .onTapGesture {
            self.choosed = index
        }
    }
}

#Preview {
    MainView_Head(choosed: .constant(0))
}
