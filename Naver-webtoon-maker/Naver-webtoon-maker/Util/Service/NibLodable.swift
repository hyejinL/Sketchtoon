//
//  NibLodable.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable {}

extension NibLoadable where Self: UIView {
    static func loadFromNib(with name: String? = nil) -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: name ?? String(describing: self), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first
        
        return nibView as! Self
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: String(describing: self), bundle: bundle)
    }
}

extension UIView: NibLoadable {
    class func instanceFromNib() -> Self {
        return self.loadFromNib()
    }
}
