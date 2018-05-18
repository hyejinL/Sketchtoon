//
//  WebtoonSettingViewController.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 18..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class WebtoonSettingViewController: UIViewController {

    @IBOutlet weak var cutCollectionView: UICollectionView!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    var cutCount = 1
    var widthRatio: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewInit()
        
        pageCountLabel.text = "/ \(cutCount)"
        pageLabel.text = "1"
        
        widthRatio = cutCollectionView.bounds.size.width/375
    }
    
    @IBAction func pressedAddCut(_ sender: Any) {
        cutCount += 1
        
        pageCountLabel.text = "/ \(cutCount)"
        cutCollectionView.reloadData()
        
        let indexPath = IndexPath(row: cutCount-1, section: 0)
        cutCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
}

extension WebtoonSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionViewInit() {
        cutCollectionView.delegate = self; cutCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cutCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CutCollectionViewCell.reuseIdentifier, for: indexPath) as! CutCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sketchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SketchViewController.reuseIdentifier) as! SketchViewController
        
        sketchViewController.index = indexPath.row
        
        self.present(sketchViewController, animated: true, completion: nil)
    }
    
}

extension WebtoonSettingViewController: sendScreenshotProtocol {
    func sendScreenshotProtocol(index: Int, screenshot: UIImage) {
//        let cell = cutCollectionView.cellForItem(at: IndexPath(row: 0, section: index)) as! CutCollectionViewCell
//        cell.cutScreenshotImageView.image = screenshot
    }
}

extension WebtoonSettingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(28*widthRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let indexPath = NSIndexPath(row: 0, section: 0)
        let endEdgeInset = 2*28*widthRatio
        
        if indexPath.row == 0 {
            return UIEdgeInsets(top: 0, left: endEdgeInset, bottom: 0, right: 0)
        } else if indexPath.row == (cutCount-1) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: endEdgeInset)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 262*widthRatio, height: collectionView.bounds.height*(475/667))
    }
    
}

// MARK: CardView Method
extension WebtoonSettingViewController {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Simulate "Page" Function
        let pageWidth: Float = Float(290*widthRatio)
        let currentOffset: Float = Float(scrollView.contentOffset.x)
        let targetOffset: Float = Float(targetContentOffset.pointee.x)
        
        var newTargetOffset: Float = 0
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        }
        else {
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        if newTargetOffset < 0 {
            newTargetOffset = 0
        }
        else if (newTargetOffset > Float(scrollView.contentSize.width)){
            newTargetOffset = Float(Float(scrollView.contentSize.width))
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = cutCollectionView.contentOffset
        visibleRect.size = cutCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath = cutCollectionView.indexPathForItem(at: visiblePoint) {
            pageLabel.text = "\(visibleIndexPath.item + 1)"
        }
    }
}
