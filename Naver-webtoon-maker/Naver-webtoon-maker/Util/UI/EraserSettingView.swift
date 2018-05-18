//
//  EraserSettingView.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

class EraserSettingView: UIView {
    
    @IBOutlet weak var eraserView: CircleView!
    @IBOutlet weak var eraserScaleSlider: UISlider!
    
    var brush = Brush(colortoString: UIColor.white, width: CGFloat())
    
    func brushSetting() -> Brush {
        brush.width = CGFloat(eraserScaleSlider.value)
        
        return brush
    }
}
