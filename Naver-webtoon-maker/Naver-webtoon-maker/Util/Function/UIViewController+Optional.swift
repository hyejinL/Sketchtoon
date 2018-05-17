//
//  UIViewController+Optional.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func gsno(_ value: String?) -> String {
        return value ?? ""
    }
    
    func gino(_ value: Int?) -> Int {
        return value ?? 0
    }
}

