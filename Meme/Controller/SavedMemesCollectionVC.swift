//
//  SavedMemeCollectionVC.swift
//  Meme
//
//  Created by Madian on 2/19/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit

class SavedMemesCollectionVC: UIViewController {

    var memesList: [Meme] {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.mems
    }
    
    @IBOutlet weak var SentMemsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SentMemsCollectionView.dataSource = self
        SentMemsCollectionView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
