//
//  Brush.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

// 브러쉬 데이터
struct Brush: Codable {
    var width: CGFloat
    
    var colorString: String = "0xff0000"
    var color: UIColor {
        set { self.colorString = newValue.toHexString }
        get { return UIColor(hexString: self.colorString) }
    }
    
    init(colortoString: UIColor, width: CGFloat) {
        self.width = width
        
        color = colortoString
    }
}

