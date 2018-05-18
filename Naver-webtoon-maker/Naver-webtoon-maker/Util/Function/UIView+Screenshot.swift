//
//  UIView+Screenshot.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 18..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

