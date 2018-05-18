//
//  StrokeData.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit
import Cache

// 하나의 그림 데이터
struct StrokeData: Codable {
    let title: String
    let strokes: [Stroke]
    let photoes: [Photo]?
    
    var screenshotData: Data = Data()
    var screenshot: UIImage {
        set { self.screenshotData = try! JSONEncoder().encode(ImageWrapper(image: newValue)) }
        get { return try! JSONDecoder().decode(ImageWrapper.self, from: self.screenshotData).image }
    }
    
    init(title: String, strokes: [Stroke],
         photoes: [Photo]?, screenshottoData: UIImage) {
        self.title = title
        self.strokes = strokes
        self.photoes = photoes
        
        screenshot = screenshottoData
    }
}
