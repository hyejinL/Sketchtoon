//
//  StrokeData.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

// 하나의 그림 데이터
struct StrokeData: Codable {
    let title: String = ""
//    let screenShot: UIImage
    let strokes: [Stroke]
}
