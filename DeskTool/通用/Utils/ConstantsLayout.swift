//
//  ConstantsLayout.swift
//  YSBase
//
//  Created by unitree on 2024/1/3.
//  Copyright © 2024 unitree.lee. All rights reserved.
//

import Foundation
import Cocoa
import AppKit
// 只是简化一些常用的有带默认属性（如multiplier = 1，value=0）的约束添加
//
// 包含：高度约束，宽度约束，与父视图的边距、水平中心对齐、垂直中心对齐
//
// 复杂的约束、请使用第三方库或者xib

// 定义命名空间
public final class Baymax<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// 可添加的约束
public enum EasyConstraint {
    
    case h(CGFloat) /// 高约束
    case w(CGFloat) /// 宽约束
    
    case fill /// 填充父视图 = margin（0，0，0，0）
    case margin(CGFloat?,CGFloat?,CGFloat?,CGFloat?) /// 距父视图边距（上、左、下、右、）
    case top(CGFloat) /// 距父视图上边距
    case left(CGFloat) /// 距父视图左边距
    case bottom(CGFloat)/// 距父视图下边距
    case right(CGFloat) /// 距父视图右边距
    
    case center /// 距父视图剧中
    case center_X(CGFloat)  /// 距父视图水平剧中
    case center_Y(CGFloat)  /// 距父视图垂直剧中
    case centerWith(NSView) /// 和VIew剧中对齐

    case above(NSView,CGFloat)  /// 在其他view竖直上边
    case under(NSView,CGFloat)  /// 在其他view竖直下边
    case before(NSView,CGFloat) /// 在其他view水平左边
    case after(NSView,CGFloat)  /// 在其他view水平右边
    /// 宽高比
    case w_h_aspect(CGFloat)
    case equal_W(NSView)    /// 等宽
    case equal_H(NSView)    /// 等高
}


public protocol ConstraintsCompatible {
    associatedtype CompatibleType
    var bm: Baymax<CompatibleType> { get }
}

public extension ConstraintsCompatible {
    var bm: Baymax<Self> {
        return Baymax(self)
    }
}

extension NSView: ConstraintsCompatible{}

extension Baymax where Base: NSView{
    
    /// 添加到视图 & 添加约束
    @discardableResult
    public func add(toView:NSView ,withConstraints constraints:[EasyConstraint]) -> [NSLayoutConstraint]{
        if base.superview != nil {
            base.removeFromSuperview()
        }
        toView.addSubview(base)
        return self.addConstraints(constraints)
    }
    
    /// 只添加约束
    @discardableResult
    public func addConstraints(_ constraints:[EasyConstraint]) -> [NSLayoutConstraint]{
        base.translatesAutoresizingMaskIntoConstraints = false
        var result = [NSLayoutConstraint]()
        /// 处理不需要 sup的约束
        for c in constraints {
            switch c {
            case let .w(value):
                result.append( align(to: nil, attribute: .width, constant: value))
            case let .h(value):
                result.append( align(to: nil, attribute: .height, constant: value))
            case let .w_h_aspect(value):
                let c = self.addCons(to: base, att: .width, by: .equal, att: .height, multiplier: value, constant: 0)
                base.addConstraint(c)
                result.append(c)
            default :
                continue
            }
        }
        
        // 处理需要sup的约束
        guard let sup = base.superview else { return result }
        for c in constraints {
            switch c {
            case let .top(value):
                result.append( align(to: sup, attribute: .top, constant: value))
            case let .left(value):
                result.append( align(to: sup, attribute: .left, constant: value))
            case let .bottom(value):
                result.append( align(to: sup, attribute: .bottom, constant: -value))
            case let .right(value):
                result.append( align(to: sup, attribute: .right, constant: -value))
                
            case let .margin(t,l,b,r):
                if t != nil { result.append( align(to: sup, attribute: .top, constant: t!)) }
                if l != nil { result.append( align(to: sup, attribute: .left, constant: l!)) }
                if b != nil { result.append( align(to: sup, attribute: .bottom, constant: -b!)) }
                if r != nil { result.append( align(to: sup, attribute: .right, constant: -r!)) }
            case .fill:
                result.append( align(to: sup, attribute: .top, constant: 0))
                result.append( align(to: sup, attribute: .left, constant: 0))
                result.append( align(to: sup, attribute: .bottom, constant: 0))
                result.append( align(to: sup, attribute: .right, constant: 0))
                
            case .center:
                result.append( align(to: sup, attribute: .centerX, constant: 0))
                result.append( align(to: sup, attribute: .centerY, constant: 0))
                
            case let .center_X(value):
                result.append( align(to: sup, attribute: .centerX, constant: value))
                
            case let .center_Y(value):
                result.append( align(to: sup, attribute: .centerY, constant: value))
                
            case let .centerWith(view):
                let c1 = self.addCons(to: view, att: .centerX, by: .equal, att: .centerX, multiplier: 1, constant: 0)
                let c2 = self.addCons(to: view, att: .centerY, by: .equal, att: .centerY, multiplier: 1, constant: 0)
                sup.addConstraint(c1)
                sup.addConstraint(c2)
                result.append(c1)
                result.append(c2)
                
            case let .above(view, value):
                let c = self.addCons(to: view, att: .bottom, by: .equal, att: .top, multiplier: 1, constant: value)
                sup.addConstraint(c)
                result.append(c)
                
            case let .under(view, value):
                let c = self.addCons(to: view, att: .top, by: .equal, att: .bottom, multiplier: 1, constant: value)
                sup.addConstraint(c)
                result.append(c)
                
            case let .before(view, value):
                let c = self.addCons(to: view, att: .right, by: .equal, att: .left, multiplier: 1, constant: value)
                sup.addConstraint(c)
                result.append(c)
                
            case let .after(view, value):
                let c = self.addCons(to: view, att: .left, by: .equal, att: .right, multiplier: 1, constant: value)
                sup.addConstraint(c)
                result.append(c)
                
            case let .equal_W(view):
                let c = self.addCons(to: view, att: .width, by: .equal, att: .width, multiplier: 1, constant: 0)
                sup.addConstraint(c)
                result.append(c)
                
            case let .equal_H(view):
                let c = self.addCons(to: view, att: .height, by: .equal, att: .height, multiplier: 1, constant: 0)
                sup.addConstraint(c)
                result.append(c)
            default :
                continue
            }
        }
        return result
    }
    
    // 添加约束
    @discardableResult
    fileprivate func addCons(to:NSView?,
         att selfAtt:NSLayoutConstraint.Attribute,
                  by:NSLayoutConstraint.Relation,
           att toAtt:NSLayoutConstraint.Attribute,
          multiplier:CGFloat = 1,
            constant:CGFloat) -> NSLayoutConstraint {
        
        // true会把当前frame自动转约束，新加约束就会冲突，所以把默认转换关了，手动添加约束
        return NSLayoutConstraint(item: base,
                                  attribute: selfAtt,
                                  relatedBy: by,
                                  toItem: to,
                                  attribute: toAtt,
                                  multiplier: multiplier,
                                  constant: constant)
    }
        
    // 相同的约束位置， 且mult=1的简化版添加
    @discardableResult
    fileprivate func align(to: NSView?, attribute: NSLayoutConstraint.Attribute, constant: CGFloat) -> NSLayoutConstraint {
        let c = self.addCons(to: to, att: attribute, by: .equal, att: attribute, multiplier: 1, constant: constant)
        (to ?? base).addConstraint(c)
        return c
    }
    
}



