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
    
    var webtoonData: [Webtoon] = [Webtoon]()
    
    let userdefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = userdefault.value(forKey: "webtoon") as? Data {
            if let webtoons = try? PropertyListDecoder().decode([Webtoon].self, from: data) {
                print(webtoons.count)
                webtoonData = webtoons
                
            webtoonCollectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionViewInit() {
        webtoonCollectionView.delegate = self; webtoonCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webtoonData.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row != webtoonData.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebtoonCollectionViewCell.reuseIdentifier, for: indexPath) as! WebtoonCollectionViewCell
            
            cell.webtoonImageView.image = webtoonData[indexPath.row].strokes[0].screenshot
            cell.titleLabel.text = webtoonData[indexPath.row].title
            
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddWebtoonCollectionViewCell", for: indexPath)
            
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == webtoonData.count {
            let navi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navi") as! UINavigationController
            if let WebtoonSettingViewController = navi.viewControllers.first as? WebtoonSettingViewController {
                WebtoonSettingViewController.webtoonData = webtoonData
            }
            self.present(navi, animated: true, completion: nil)
        } else {
            let webtoonDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: WebtoonDetailViewController.reuseIdentifier) as! WebtoonDetailViewController
    
            webtoonDetailViewController.webtoon = webtoonData[indexPath.row]
            
            self.navigationController?.pushViewController(webtoonDetailViewController, animated: true)
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
