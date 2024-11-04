//
//  EventMointor.swift
//  DeskTool
//
//  Created by unitree on 2024/3/7.
//

import Cocoa

class EventMonitor: NSObject {
    
    var mask:NSEvent.EventTypeMask!
    var handle:((_ event:NSEvent)->Void)!
    var monitor:Any?

    init(_ mask:NSEvent.EventTypeMask, _ handle:@escaping(NSEvent) -> Void) {
        super.init()
        self.mask = mask
        self.handle = handle
    }
    
    func start(){
        self.monitor = NSEvent.addGlobalMonitorForEvents(matching: self.mask) {[weak self] event in
            self?.handle(event)
        }
    }
    
    func stop(){
        guard let m = self.monitor else { return }
        NSEvent.removeMonitor(m)
        self.monitor = nil
    }
}
