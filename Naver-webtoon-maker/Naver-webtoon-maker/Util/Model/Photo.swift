//
//  Photo.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 18..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit
import Cache

// 이미지 데이터
struct Photo: Codable {
    let frame: CGRect
    let transform: CGAffineTransform
    
    var imageData: Data = Data()
    var image: UIImage {
        set { self.imageData = try! JSONEncoder().encode(ImageWrapper(image: newValue)) }
        get { return try! JSONDecoder().decode(ImageWrapper.self, from: self.imageData).image }
    }
    
    init(frame: CGRect, transform: CGAffineTransform, imagetoData: UIImage) {
        self.frame = frame
        self.transform = transform
        
        image = imagetoData
    }
}
