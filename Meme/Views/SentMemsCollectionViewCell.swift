//
//  SentMemsCollectionViewCell.swift
//  Meme
//
//  Created by Madian on 2/7/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit

class SentMemsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var SentMemeImageView: UIImageView!
    
    func updateView(with meme: Meme){
        SentMemeImageView.image = meme.memedImage
    }
}
