//
//  ItemDetailViewController.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    var itemDetail: ItemsModel!
    
    //MARK: - Outlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setItemDetail()
        
        let savedItem = CoreDataManager.sharedInstance.readData(class: Items.self)
        
        for favoriteItem in savedItem{
            if favoriteItem.title == itemDetail.title && favoriteItem.favorite{
                saveButton.isHidden = true
                return
            }else{
                saveButton.isHidden = false
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Private methods
    private func setItemDetail(){
        titleLabel.text = itemDetail.title
        dateLabel.text = itemDetail.created_at
        bodyLabel.text = itemDetail.body
        
        guard let itemImage = itemDetail.image_url else {
            return
        }
        
        if let imageURL = URL(string: itemImage){
            itemImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
        }
    }
    
    //MARK: - User interaction
    @IBAction func saveButtonPressed(_ sender: Any) {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let item = Items(context: context)
        
        item.title = itemDetail.title
        item.date = itemDetail.created_at
        item.body = itemDetail.body
        item.image = itemDetail.image_url
        item.favorite = true
        
        
        
        let agreeAlertController = UIAlertController(title: "Favorito", message: "Se ha guardado como favorito", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
            CoreDataManager.sharedInstance.saveContext()
            self.saveButton.isHidden = true
        }
        
        agreeAlertController.addAction(okAction)
        
        present(agreeAlertController, animated: true, completion: nil)
        
    }
}
