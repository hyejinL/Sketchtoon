//
//  UIImage+Screenshot.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 18..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
