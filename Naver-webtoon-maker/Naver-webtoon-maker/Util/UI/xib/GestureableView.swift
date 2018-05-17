//
//  GestureableView.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

protocol GestureableViewDataSource: class {
    func gestureableImageView(_ gestureableView: GestureableView) -> UIImage
}

class GestureableView: UIView {
    
    @IBOutlet weak var gestureImageView: UIImageView!
    @IBOutlet weak var imageDeleteButton: CircleButton!
    @IBOutlet weak var gestureImageViewHeightConstant: NSLayoutConstraint!
    
    var imageViewToPan: UIImageView?
    
    var lastPanPoint: CGPoint?
    
    var dataSource: GestureableViewDataSource?
    
    // 레이아웃이 바뀔때마다 매번 호출
    override func layoutSubviews() {
        if let image = dataSource?.gestureableImageView(self) {
            gestureImageView.image = image
            
            //            let imageHeight = image.size.height*150/image.size.width
            //            self.frame.size = CGSize(width: 190, height: imageHeight+40)
        }
    }
    
    // 한 번 호출
    override func awakeFromNib() {
        configure()
    }
    
    @IBAction func pressedRemoveImageButton(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    func configure() {
        imageDeleteButton.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageDeleteButton.width = 0.5
        
        gestureImageView.contentMode = .scaleAspectFit
        
        gestureInit()
    }
    
    func gestureInit() {
        let viewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanGesture(gesture:)))
        viewPanGesture.minimumNumberOfTouches = 1; viewPanGesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(viewPanGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGesture(gesture:)))
        rotationGesture.delegate = self
        self.addGestureRecognizer(rotationGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(gesture:)))
        pinchGesture.delegate = self
        self.addGestureRecognizer(pinchGesture)
    }
    
}

// MARK: - Check Current View
// TODO: 현재 뷰가 아닐 때 border clear 하는 것
extension GestureableView {
    
    func touchFrame() {
        gestureImageView.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        gestureImageView.layer.borderWidth = 2.5
    }
    
    func touchEnd() {
        gestureImageView.layer.borderWidth = 0.0
    }
}

// MARK: - Gesture
// Gesture func : Pan Gesture, Rotation Gesture, Pinch Gesture
extension GestureableView {
    
    @objc func viewPanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        if let view = gesture.view {
            if gesture.state == .began || gesture.state == .changed {
                touchFrame()
                
                view.transform = view.transform.translatedBy(x: translation.x, y: translation.y)
                
                gesture.setTranslation(CGPoint.zero, in: self)
            } else if gesture.state == .ended {
                touchEnd()
            }
        }
    }
    
    @objc func rotationGesture(gesture: UIRotationGestureRecognizer) {
        if let view = gesture.view {
            if gesture.state == .began || gesture.state == .changed {
                touchFrame()
                
                view.transform = view.transform.rotated(by: gesture.rotation)
                gesture.rotation = 0.0
            } else if gesture.state == .ended {
                touchEnd()
            }
        }
    }
    
    @objc func pinchGesture(gesture: UIPinchGestureRecognizer) {
        if let view = gesture.view {
            if gesture.state == .began || gesture.state == .changed {
                touchFrame()
                
                view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
                gesture.scale = 1.0
            } else if gesture.state == .ended {
                touchEnd()
            }
        }
    }
}

// MARK: Gesture Delegate
extension GestureableView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
