//
//  SettingViewController.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import ChromaColorPicker

// 브러쉬, 지우개, 배경
enum SettingKind: Int {
    case background
    case eraser
    case brush
}

// 브러쉬 정보 전달을 위한 dataSource
protocol BrushSettingDataSource: class {
    func brushSetting(_ settingKind: Int, brush: Brush?, backgroundColor color: UIColor?)
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var dismissActionView: UIView!
    
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var viewInSettingView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet var backgroundSettingView: ChromaColorPicker!
    @IBOutlet var brushSettingView: BrushSettingView!
    @IBOutlet var eraserSettingView: EraserSettingView!
    
    var brush = Brush(colortoString: UIColor(), width: CGFloat())
    var backgroundColor: UIColor?
    
    var settingKind: Int = -1
    
    var dataSource: BrushSettingDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        backgroundSettingView.delegate = self
        brushSettingView.colorPicker.delegate = self
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        self.dismissActionView.addGestureRecognizer(dismissGesture)
    }
    
    @IBAction func pressedDismissButton(_ sender: Any) {
        dismissAction()
    }
    
    func configure() {
        var view: UIView = UIView()
        
        switch settingKind {
        case SettingKind.background.rawValue:
            view = backgroundSettingView
            
        case SettingKind.eraser.rawValue:
            view = eraserSettingView
            if let bgColor = backgroundColor {
                eraserSettingView.brush = Brush(colortoString: bgColor, width: 10)
            }
            
        case SettingKind.brush.rawValue:
            view = brushSettingView
            brushSettingView.brush = brush
            
        default:
            break
        }
        
        viewHeight.constant = view.frame.height
        self.view.layoutIfNeeded()
        viewInSettingView.addSubview(view)
    }
    
    @objc func dismissAction() {
        switch settingKind {
        case SettingKind.eraser.rawValue:
            brush = brushSettingView.brushSetting()
            dataSource?.brushSetting(settingKind, brush: brush, backgroundColor: nil)
        case SettingKind.brush.rawValue:
            brush = brushSettingView.brushSetting()
            dataSource?.brushSetting(settingKind, brush: brush, backgroundColor: nil)
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        brush.color = color
        if colorPicker == brushSettingView.colorPicker {
            brushSettingView.brushView.backgroundColor = brush.color
            brushSettingView.brush.color = color
        } else {
            // TODO: 배경이 바뀌는 delegate 만들 것
            dataSource?.brushSetting(settingKind, brush: nil, backgroundColor: color)
            dismissAction()
        }
    }
}
