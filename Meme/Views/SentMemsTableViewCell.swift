//
//  SentMemsTableViewCell.swift
//  Meme
//
//  Created by Madian on 2/6/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit

class SentMemsTableViewCell: UITableViewCell {

    //MARK: OUtlets
    @IBOutlet weak var MemeImageView: UIImageView!
    @IBOutlet weak var TopAndBottomLabel: UILabel!
    
    func updateView(with meme: Meme){
        MemeImageView.image = meme.memedImage
        TopAndBottomLabel.text = "\(meme.topText) \(meme.bottomText)"
    }

}
