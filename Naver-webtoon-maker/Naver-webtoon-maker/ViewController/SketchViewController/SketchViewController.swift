//
//  SketchViewController.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import ChromaColorPicker

class SketchViewController: UIViewController, NibLoadable {
    
    // MARK: - Properties
    @IBOutlet weak var sketchView: SketchView!
    
    // SettingView : paint, eraser, brush ... : 하단
    @IBOutlet weak var settingView: SettingButtonView!
    @IBOutlet weak var paletteButton: UIButton!
    @IBOutlet weak var paintButton: CircleButton!
    @IBOutlet weak var eraserButton: CircleButton!
    @IBOutlet weak var brushButton: CircleButton!
    @IBOutlet weak var textButton: CircleButton!
    @IBOutlet weak var photoButton: CircleButton!
    
    // MenuView : save, new sheet : 상단
    @IBOutlet weak var menuView: SettingButtonView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var newSheetButton: UIButton!
    
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    var gestureImage: UIImage = UIImage()
    var settingButtons: [CircleButton] = [CircleButton]()
    var menuButtons: [UIButton] = [UIButton]()
    
    // 수정 후 몇 번째 컷인지 알기 위한 변수
    var index: Int = -1
    
    let userdefault = UserDefaults.standard
    
    // 상태바 hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Methods
    // MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터 불러오기
        if let data = userdefault.value(forKey: "strokes") as? Data {
            if let strokes = try? PropertyListDecoder().decode([Stroke].self, from: data) {
                sketchView.strokes = strokes
            }
        }
        
        settingButtons = [paintButton, eraserButton, brushButton, textButton, photoButton]
        menuButtons = [saveButton, newSheetButton]
        for buttons in [settingButtons, menuButtons] {
            for button in buttons {
                button.alpha = 0
            }
        }
    }
    
    // MARK: -  IBAction
    @IBAction func pressedSettingButton(_ sender: UIButton) {
        settingView.pressedSettingButton(settingButtons: settingButtons)
    }
    
    @IBAction func pressedMenuButton(_ sender: Any) {
        menuView.pressedSettingButton(settingButtons: menuButtons)
    }
    
    // MARK: Menu Button
    // 저장하기
    @IBAction func saveButton(_ sender: Any) {
        userdefault.set(try? PropertyListEncoder().encode(sketchView.strokes), forKey: "strokes")
    }
    
    // 새로 그리기
    @IBAction func newSheetAction(_ sender: Any) {
        let okayAction = UIAlertAction(title: "지울게요 ;(", style: .default) { [weak self] (_) in
            guard let `self` = self else { return }
            self.sketchView.strokes = []
            
            for subview in self.sketchView.subviews {
                subview.removeFromSuperview()
            }
            
            self.sketchView.setNeedsDisplay()
        }
        let cancelAction = UIAlertAction(title: "안 바꿀래요", style: .cancel, handler: nil)
        
        addAlert(title: "새 종이로 바꾸시겠습니까?", message: nil,
                 style: .alert, actions: [okayAction, cancelAction])
    }
    
    @IBAction func pressedDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Setting Button
    // 브러쉬 선택
    @IBAction func chooseSettingButton(_ sender: UIButton) {
        let settingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SettingViewController.reuseIdentifier) as! SettingViewController
        
        settingViewController.dataSource = self
        settingViewController.brush = Brush(colortoString: sketchView.lineColor, width: sketchView.lineWidth)
        settingViewController.settingKind = sender.tag
        
        self.present(settingViewController, animated: true, completion: nil)
    }
    
    // 사진 추가
    @IBAction func choosePhoto(_ sender: Any) {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let cameraLibraryAction = UIAlertAction(title: "카메라",
                                                style: .default) { [weak self] (action : UIAlertAction) in
                                                    guard let `self` = self else { return }
                                                    self.openCamera()
        }
        let photoLibraryAction = UIAlertAction(title: "사진 앨범",
                                               style: .default) { [weak self] (action : UIAlertAction) in
                                                guard let `self` = self else { return }
                                                self.openGallery()
        }
        
        
        let actions: [UIAlertAction] = [cancelAction, cameraLibraryAction, photoLibraryAction]
        
        
        addAlert(title: "사진 소스를 선택해주세요 :)", message: nil,
                 style: .actionSheet, actions: actions)
    }
   
    
}

// MARK: BrushSetting
// parameters : settingKind-지우개, 브러쉬, 배경 중 선택한 종류 / brush: brush 정보
extension SketchViewController: BrushSettingDataSource {
    func brushSetting(_ settingKind: Int, brush: Brush?, backgroundColor color: UIColor?) {
        switch settingKind {
        case SettingKind.background.rawValue:
            sketchView.backgroundColor = color
            
        case SettingKind.eraser.rawValue:
            print(2222)
            
        case SettingKind.brush.rawValue:
            if let brush_ = brush {
                sketchView.lineColor = brush_.color
                sketchView.lineWidth = brush_.width
            }
            
        default:
            break
        }
    }
}

// MARK: GestureableView
// GestureableView의 이미지 크기를 위한 DataSource
extension SketchViewController: GestureableViewDataSource {
    func gestureableImageView(_ gestureableView: GestureableView) -> UIImage {
        return gestureImage
    }
    
    @objc func viewPanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view)
        print(translation)
        
        if let view = gesture.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        
        gesture.setTranslation(CGPoint.zero, in: sketchView)
    }
}

// MARK: - Galleray, Photo
extension SketchViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Method
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            //            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            //            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    // imagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            let nib = GestureableView.loadFromNib()
            nib.dataSource = self
            nib.center = self.sketchView.center
            self.sketchView.addSubview(nib)
            
            self.dismiss(animated: true) {
                print("이미지 피커 사라짐")
            }
        }
        
        if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            gestureImage = originalImage
        }
    }
}
