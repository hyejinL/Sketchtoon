//
//  BrushSettingView.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit
import ChromaColorPicker

class BrushSettingView: UIView {
    
    @IBOutlet weak var brushView: CircleView!
    @IBOutlet weak var brushScaleSlider: UISlider!
    @IBOutlet weak var colorPicker: ChromaColorPicker!
    @IBOutlet weak var brushAlphaSlider: UISlider!
    @IBOutlet weak var brushViewWidth: NSLayoutConstraint!
    
    var brushColor: UIColor = UIColor()
    var brush = Brush(colortoString: UIColor(), width: CGFloat())
    
    override func layoutSubviews() {
        brushView.backgroundColor = brush.color
        //        brushViewWidth.constant = brush.width
    }
    
    @IBAction func changedBrushScale(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        //        brushView.frame.size = CGSize(width: value, height: value)
        brushViewWidth.constant = value
    }
    
    func brushSetting() -> Brush {
        if let color = brushView.backgroundColor {
            brush.color = color
        }
        brush.width = CGFloat(brushScaleSlider.value)
        
        return brush
    }
}
