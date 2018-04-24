//
//  TabButton.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 24/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class TabButton: NSButton, CALayerDelegate {

    let activeColor = NSColor(red: 0.97, green: 0.62, blue: 0.16, alpha: 1)
    let inactiveColor = NSColor(red: 0.95, green: 0.9, blue: 0.85, alpha: 1)
    
    var leftLayer: CALayer! = nil
    
    public override func draw(_ dirtyRect: NSRect) {
        
        isBordered = false
        wantsLayer = true
        
        self.layer?.masksToBounds = true
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        if let font = font {
        
            var attrs = [
                    NSAttributedStringKey.paragraphStyle: style,
                    NSAttributedStringKey.font: font,
                ]
            
            if self.state == .on {
                attrs[NSAttributedStringKey.foregroundColor] = NSColor.white
            } else {
                attrs[NSAttributedStringKey.foregroundColor] = NSColor.black
            }
            
            
            self.attributedTitle = NSAttributedString(string: self.title, attributes: attrs)
            //self.attributedAlternateTitle = NSAttributedString(string: "Value", attributes: myAttributeOn)
            
        }
        
        if state == .off {
            self.layer?.backgroundColor = inactiveColor.cgColor
        } else {
            self.layer?.backgroundColor = activeColor.cgColor
        }
        
        
        if let layer = self.layer {
            
            if leftLayer == nil {
                leftLayer = CALayer()
            }
            
            //leftLayer.borderColor = CGColor(red: 0.4, green: 0.30, blue: 0.28, alpha: 0.4)
            leftLayer.borderColor = CGColor(gray: 0.3, alpha: 0.4)
            leftLayer.borderWidth = 1
            leftLayer.frame = CGRect(x: 0, y: -1, width: dirtyRect.width + 1, height: dirtyRect.height + 2)
            
            if layer.sublayers == nil || layer.sublayers?.contains(leftLayer) == false {
               // layer.addSublayer(leftLayer)
            }
        
        }
        
        super.draw(dirtyRect)
    
    }
    
}
