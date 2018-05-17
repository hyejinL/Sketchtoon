//
//  SettingButtonView.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

class SettingButtonView: UIView, RoundedProtocol {
    
    var cornerRadius: CGFloat = 0
    
    override func layoutSubviews() {
        self.layer.masksToBounds = true
        
        cornerRadius = self.frame.width/2
        cornerRadius(self, borderWidth: 0, borderColor: .clear)
    }
    
    func pressedSettingButton(settingButtons: [UIButton]) {
        
        if self.transform == .identity {
            
            UIView.animate(withDuration: 0.4, animations: { [weak self] in
                guard let `self` = self else { return }
                
                self.transform = CGAffineTransform(scaleX: 6.0, y: 6.0)
                
            }) { [weak self] (_) in
                guard let `self` = self else { return }
                
                for button in settingButtons {
                    self.settingButtonAlphaAnimation(button: button)
                }
                
            }
            
        } else {
            
            for button in settingButtons {
                self.settingButtonAlphaAnimation(button: button)
            }
            
            UIView.animate(withDuration: 0.4, animations: { [weak self] in
                guard let `self` = self else { return }
                
                self.transform = .identity
                
            })
        }
    }
    
    func settingButtonAlphaAnimation(button: UIButton) {
        let alpha: CGFloat = button.alpha == 0 ? 1 : 0
        print(alpha)
        
        UIView.animate(withDuration: 0.4) {
            button.alpha = alpha
        }
    }
}
