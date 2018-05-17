//
//  Stroke.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

// 선 데이터
struct Stroke: Codable {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let brush: Brush
    
    init(startPoint: CGPoint, endPoint: CGPoint, brush: Brush) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.brush = brush
    }
}
