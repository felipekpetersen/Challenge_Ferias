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
    var heightsForRow = [150, 200, 250, 300]
    var viewModel = ReceivedLettersViewModel()
    let receivedLetterCell = "ReceivedLetterCollectionViewCell"
    var selectedLetter: LetterCodable?
    var cellHeights: [IndexPath : CGFloat] = [:]
    var maxyDireita: CGFloat = 0
    var maxyEsquerda: CGFloat = 0

    var isPar = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        loadData()
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
    
    func loadData() {
        self.viewModel.fetchLetters()
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ReadLetterViewController {
            vc.receivedLetter = self.selectedLetter
        }
    }
}

extension ReceivedLettersViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: receivedLetterCell, for: indexPath) as! ReceivedLetterCollectionViewCell
        
        let random = getRandomSize()
        var cellFrame: CGRect?
        if maxyDireita <= maxyEsquerda {
            cellFrame = CGRect(x:0, y: maxyDireita, width: self.collectionView.frame.size.width/2, height: random)
//            cell.frame = CGRect(x:0, y: maxyDireita, width: self.collectionView.frame.size.width/2, height: random)
            maxyDireita = cell.frame.maxY
            
        } else {
            cellFrame = CGRect(x: self.collectionView.frame.size.width/2, y: maxyEsquerda, width: self.collectionView.frame.size.width/2, height: random)
//            cell.frame = CGRect(x: self.collectionView.frame.size.width/2, y: maxyEsquerda, width: self.collectionView.frame.size.width/2, height: random)
            maxyEsquerda = cell.frame.maxY
        }
        
        print(cellFrame)
        cell.setup(letter: self.viewModel.getLetterForRow(index: indexPath.row))
//        let random = getRandomSize()
//        if maxyDireita <= maxyEsquerda {
//
//            cell.frame = CGRect(x:0, y: maxyDireita, width: self.collectionView.frame.size.width/2, height: random)
//            maxyDireita = cell.frame.maxY
//        } else {
//            cell.frame = CGRect(x: self.collectionView.frame.size.width/2, y: maxyEsquerda, width: self.collectionView.frame.size.width/2, height: random)
//            maxyEsquerda = cell.frame.maxY
//        }
//        if isPar {
//            cell.frame = CGRect(x:cell.frame.origin.x, y: maxyDireita, width: collectionView.frame.size.width/2, height: random)
//            maxyDireita = cell.frame.maxY
//        } else {
//            cell.frame = CGRect(x:cell.frame.origin.x, y: maxyEsquerda, width: collectionView.frame.size.width/2, height: random)
//            maxyEsquerda = cell.frame.maxY
//        }
//        isPar = !isPar
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedLetter = self.viewModel.getLetterForRow(index: indexPath.row)
        performSegue(withIdentifier: "receivedLetterSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let randomSize = getRandomSize()
        if randomSize - CGFloat((self.viewModel.getLetterForRow(index: indexPath.row).content?.count ?? 0)/3) > 50 {
            return CGSize(width: collectionView.frame.size.width/2 , height: CGFloat((self.viewModel.getLetterForRow(index: indexPath.row).content?.count ?? 0)/2) + 100)

        }
        return CGSize(width: collectionView.frame.size.width/2 , height: randomSize)
//        return CGSize(width: collectionView.frame.size.width/2 , height: self.collectionView.cellForItem(at: indexPath)?.contentView.frame.height ?? 150)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
