//
//  Spacer+.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

struct HSpacer:View {
    @State var w:CGFloat
    var body: some View {
        Spacer().frame(width: w)
    }
}

struct VSpacer:View {
    @State var h:CGFloat
    var body: some View {
        Spacer().frame(height: h)
    }
}
