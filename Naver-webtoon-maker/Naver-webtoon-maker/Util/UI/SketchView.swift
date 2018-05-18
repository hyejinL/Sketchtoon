//
//  SketchView.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

class SketchView: UIView {
    
    var startPoint: CGPoint = CGPoint.zero
    var touchPoint: CGPoint = CGPoint.zero
    
    @IBInspectable var lineColor: UIColor = UIColor.black
    @IBInspectable var lineWidth: CGFloat = 5
    
    var strokes: [Stroke] = [Stroke]()
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            startPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPoint = touch.location(in: self)
        }
        
        let brush = Brush(colortoString: lineColor, width: lineWidth)
        let stroke = Stroke(startPoint: startPoint, endPoint: touchPoint, brush: brush)
        strokes.append(stroke)
        
        startPoint = touchPoint
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(.round)
        
        for stroke in strokes {
            context?.beginPath()
            context?.move(to: stroke.startPoint)
            context?.addLine(to: stroke.endPoint)
            context?.setStrokeColor(stroke.brush.color.cgColor)
            context?.setLineWidth(stroke.brush.width)
            context?.strokePath()
        }
    }
    
    func savePhoto() -> [Photo] {
        var photoes: [Photo] = [Photo]()
        
        for subview in self.subviews {
            if let view = subview as? GestureableView,
                let image = view.gestureImageView.image {
                let photo = Photo(frame: view.frame, transform: view.transform, imagetoData: image)
                
                photoes.append(photo)
                print(photo)
            }
        }
        
        return photoes
    }
    
    func openPhoto(photoes: [Photo]?) -> [GestureableView] {
        var gestureView: [GestureableView] = [GestureableView]()
        
        if let photoes_ = photoes {
        for photo in photoes_ {
//            if let photoView = photo {
//                let photoImage = photo.image {
            print(photo)
            let view: GestureableView = {
                let view = GestureableView()
                
                view.gestureImageView.frame = photo.frame
                view.transform = photo.transform
                view.gestureImageView.image = photo.image
                
                return view
            }()
            
            gestureView.append(view)
//            }
        }
        }
        
        return gestureView
    }
    
}
