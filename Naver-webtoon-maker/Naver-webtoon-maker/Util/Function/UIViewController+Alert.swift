//
//  UIViewController+Alert.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addAlert(title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: style)
        
        for action in actions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
