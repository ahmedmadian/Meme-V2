//
//  SavdMemeVCForableView.swift
//  Meme
//
//  Created by Madian on 2/7/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit

extension SavedMememsTableVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableViewCell", for: indexPath) as? SentMemsTableViewCell {
            cell.updateView(with: memesList[indexPath.row])
            return cell
        }
        return SentMemsTableViewCell()
    }
}
