//
//  MainView_CacheTest.swift
//  DeskTool
//
//  Created by unitree on 2024/3/28.
//

import SwiftUI

struct MainView_CacheTest: View {
    
    var isTrue = false
    var num = 1.23

    var body: some View {
        VStack{
            
            Button {
                
            } label: {
                Text("Delete")
                Text("Num: \(1.2132, specifier: "0.2f")")
                Text("Image: \(Image(systemName: "globe"))")
            }
        }
    }
}

#Preview {
    MainView_CacheTest()
}
