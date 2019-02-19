//
//  SavedMemeVCForCollectionView.swift
//  Meme
//
//  Created by Madian on 2/7/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit

extension SavedMemesCollectionVC : UICollectionViewDataSource, UICollectionViewDelegate{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as? SentMemsCollectionViewCell {
            cell.updateView(with: memesList[indexPath.row])
            return cell
        }
        
        return SentMemsCollectionViewCell()
    }
    
    
}
