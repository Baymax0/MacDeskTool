//
//  MyTextEditor.swift
//  DeskTool
//
//  Created by unitree on 2024/3/19.
//

import SwiftUI

struct MyTextEditor: View {
    @Binding var text:String
    var body: some View {
            TextEditor(text: $text)
                .multilineTextAlignment(.leading)
                .scrollContentBackground(.hidden)
                .foregroundStyle(Color.bg)
                .colorMultiply(Color.textColor)
                .font(.system(size: 10))
                .padding(.horizontal, 4)
                .padding(.vertical, 8)
                .background(
                    ZStack{
                        Color.bg
                        LinearGradient(colors: [.black.opacity(0.11), .black.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        RoundedRectangle(cornerRadius: 9)
                            .padding(4)
                            .shadow(color: Color.white, radius: 3, x: 0, y: 0)
                            .overlay {
                                LinearGradient(colors: [.black.opacity(0.11), Color.bg], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .clipShape(RoundedRectangle(cornerRadius: 9))
                                    .padding(4)
                                
                            }
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .height(70)
                
        
    }
}

struct StateWrapper<Value, Content:View>: View {
    @State var value: Value
    let content: (_ value: Binding<Value>) -> Content
    init(value: Value, @ViewBuilder content: @escaping (_ value: Binding<Value>) -> Content) {
        _value = .init(initialValue: value)
        self.content = content
    }
    var body: some View {
        content($value)
    }
}

#Preview {
    StateWrapper(value: "123") { value in
        MyTextEditor(text: value)
    }
}
