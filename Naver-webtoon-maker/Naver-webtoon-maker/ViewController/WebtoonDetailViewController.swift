//
//  WebtoonDetailViewController.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 18..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class WebtoonDetailViewController: UIViewController {

    @IBOutlet weak var webtoonCollectionView: UICollectionView!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    var widthRatio: CGFloat = 0.0
    var webtoon: Webtoon = Webtoon(title: "", strokes: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        widthRatio = webtoonCollectionView.bounds.size.width/375
        
        webtoonCollectionView.reloadData()
    }
}


extension WebtoonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionViewInit() {
        webtoonCollectionView.delegate = self; webtoonCollectionView.dataSource = self
        
//        webtoonCollectionView.register(UINib(nibName: CutCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CutCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gino(webtoon.strokes.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CutCollectionViewCell.reuseIdentifier, for: indexPath) as! CutCollectionViewCell
        
//        if let webtoon_ = webtoon {
//            print(2222)
            cell.cutScreenshotImageView.image = webtoon.strokes[indexPath.row].screenshot
//        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let sketchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SketchViewController.reuseIdentifier) as! SketchViewController
//
//        sketchViewController.index = indexPath.row
//        sketchViewController.delegate = self
//
//        self.present(sketchViewController, animated: true, completion: nil)
//    }
    
}

extension WebtoonDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(28*widthRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let indexPath = NSIndexPath(row: 0, section: 0)
        let endEdgeInset = 2*28*widthRatio
        
//        if indexPath.row == 0 {
//            return UIEdgeInsets(top: 0, left: endEdgeInset, bottom: 0, right: 0)
//        } else if indexPath.row == (gino(webtoon.strokes.count)-1) {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: endEdgeInset)
//        } else {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
        return UIEdgeInsets(top: 0, left: endEdgeInset, bottom: 0, right: endEdgeInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 262*widthRatio, height: collectionView.bounds.height*(475/667))
    }
    
}

// MARK: CardView Method
extension WebtoonDetailViewController {
    
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
        visibleRect.origin = webtoonCollectionView.contentOffset
        visibleRect.size = webtoonCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath = webtoonCollectionView.indexPathForItem(at: visiblePoint) {
            currentPageLabel.text = "\(visibleIndexPath.item + 1)"
        }
    }
}
