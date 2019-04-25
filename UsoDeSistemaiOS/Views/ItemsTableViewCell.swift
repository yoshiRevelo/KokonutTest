//
//  ItemsTableViewCell.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!
    
    var itemsDataSource: ItemsModel!{
        didSet{
            configureCell()
        }
    }
    
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
        itemTitleLabel.text = itemsDataSource.title
        itemDateLabel.text = itemsDataSource.created_at
        
        guard let itemImage = itemsDataSource.image_url else {
            return
        }
        
        if let imageURL = URL(string: itemImage){
            itemImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
        }
    }
}
