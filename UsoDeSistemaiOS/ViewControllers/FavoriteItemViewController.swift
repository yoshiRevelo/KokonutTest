//
//  FavoriteItemViewController.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit

class FavoriteItemViewController: UIViewController {

    var favoriteItemSelected : Items!
    
    //MARK: - Outlets
    @IBOutlet weak var favoriteItemSelectedImageView: UIImageView!
    @IBOutlet weak var FavoriteItemSelectedTitleLabel: UILabel!
    @IBOutlet weak var favoriteItemSelectedDateLabel: UILabel!
    @IBOutlet weak var favoriteItemSelectedBody: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavoriteItemSelected()
        // Do any additional setup after loading the view.
    }
    
    private func configureFavoriteItemSelected(){
        FavoriteItemSelectedTitleLabel.text = favoriteItemSelected.title
        favoriteItemSelectedDateLabel.text = favoriteItemSelected.date
        favoriteItemSelectedBody.text = favoriteItemSelected.body
        
        guard let itemImage = favoriteItemSelected.image else {
            return
        }
        
        if let imageURL = URL(string: itemImage){
            favoriteItemSelectedImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
        }
        
    }

}
