//
//  NSDraggingInfo+.swift
//  DeskTool
//
//  Created by unitree on 2024/3/7.
//

import Cocoa

extension NSDraggingInfo{
    func getDraggingUrl() -> URL?{
        if let str = draggingPasteboard.string(forType: .string){
            return URL(string: str)
        } else if let str = draggingPasteboard.string(forType: .URL){
            return URL(string: str)
        }
        return nil
    }
}

