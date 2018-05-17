//
//  CircleView.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

class CircleView: UIView, RoundedProtocol {
    
    var cornerRadius: CGFloat = 0.0
    @IBInspectable var width: CGFloat = 0
    @IBInspectable var color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        
        cornerRadius = self.frame.width/2
        cornerRadius(self, borderWidth: width, borderColor: color)
    }
}
