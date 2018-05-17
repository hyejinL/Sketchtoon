//
//  MainViewController.swift
//  Naver-webtoon-maker
//
//  Created by 이혜진 on 2018. 5. 17..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var webtoonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewInit()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionViewInit() {
        webtoonCollectionView.delegate = self; webtoonCollectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if indexPath.row != 5 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebtoonCollectionViewCell.reuseIdentifier, for: indexPath) as! WebtoonCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddWebtoonCollectionViewCell", for: indexPath)
        }
        
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            let addWebtoonViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: WebtoonSettingViewController.reuseIdentifier) as! WebtoonSettingViewController
            self.navigationController?.pushViewController(addWebtoonViewController, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125*self.view.frame.width/375, height: 177*self.view.frame.height/667)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
