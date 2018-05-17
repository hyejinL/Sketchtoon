//
//  RoundedProtocol.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

protocol RoundedProtocol: class {
    var cornerRadius: CGFloat { get set }
}

extension RoundedProtocol {
    func cornerRadius(_ view: UIView, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
    }
}
