//
//  SavedMememsVC.swift
//  Meme
//
//  Created by Madian on 2/6/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit

class SavedMememsTableVC: UIViewController {
    
    var memesList: [Meme] {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.mems
    }

    //MARK: Outlets
    @IBOutlet weak var SentMemesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SentMemesTableView.dataSource = self
        SentMemesTableView.delegate = self
        
       
    }
    
    func addMemeToList(meme: Meme){
        //memesList.append(meme)
    }
    //MARK: Actions
    @IBAction func addButton_tapped(_ sender: UIBarButtonItem) {
       
    }

}


