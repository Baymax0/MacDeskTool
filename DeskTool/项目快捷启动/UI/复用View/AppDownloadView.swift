//
//  AppDownloadView.swift
//  DeskTool
//
//  Created by unitree on 2024/3/20.
//

import SwiftUI

struct AppDownloadView: View {
    
    @Binding var showCode:Bool
    
    var downloadURl:String

    var img:ImageResource

    var body: some View {
        ZStack{
            Color.black.opacity(0.5)
            VStack(spacing:16){
                Button(action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(downloadURl, forType: .string)
                }, label: {
                    Text(downloadURl)
                        .lineLimit(2)
                        .tint(.white)
                        .weight(200).height(44)
                })
                .background { Color.black }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Image(img)
                    .onTapGesture {
                        self.showCode = false
                    }
            }
        }.opacity(showCode ? 1 : 0)
            .animation(.easeOut(duration: 0.25), value: showCode)
    }
}

#Preview {
    AppDownloadView(showCode: .constant(true), downloadURl: "123", img: .go2Download)
}
