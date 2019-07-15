//
//  ReceivedLettersViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 11/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class ReceivedLettersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var heightsForRow = [200, 250, 300, 350, 400]
    
    let receivedLetterCell = "ReceivedLetterCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: receivedLetterCell, bundle: nil), forCellWithReuseIdentifier: receivedLetterCell)
        self.collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout
    }
    
    func getRandomSize() -> CGFloat{
        return CGFloat(heightsForRow.randomElement() ?? 400)
    }
}

extension ReceivedLettersViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: receivedLetterCell, for: indexPath) as! ReceivedLetterCollectionViewCell
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 , height: self.getRandomSize())
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
