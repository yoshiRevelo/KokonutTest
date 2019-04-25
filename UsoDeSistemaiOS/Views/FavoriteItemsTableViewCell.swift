//
//  FavoriteItemsTableViewCell.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit

class FavoriteItemsTableViewCell: UITableViewCell {
    
    var favoriteitem: Items!{
        didSet{
            configureCell()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var favoriteItemsImageView: UIImageView!
    @IBOutlet weak var favoriteItemsTitle: UILabel!
    @IBOutlet weak var favoriteItemsDateLabel: UILabel!
    
    //MARK: - override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: - Private Methods
    private func configureCell(){
        favoriteItemsTitle.text = favoriteitem.title
        favoriteItemsDateLabel.text = favoriteitem.date
    }
}
