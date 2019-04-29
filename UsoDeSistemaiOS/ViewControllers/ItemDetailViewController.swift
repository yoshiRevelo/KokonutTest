//
//  ItemDetailViewController.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    var itemDetail: ItemsModel?
    var favoriteItemSelected: Items?
    
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
        
        if let itemDetailSet = itemDetail{
            for favoriteItem in savedItem{
                if favoriteItem.title == itemDetailSet.title && favoriteItem.favorite{
                    saveButton.isHidden = true
                    return
                }else{
                    saveButton.isHidden = false
                }
            }
        }else if let _ = favoriteItemSelected{
            saveButton.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Private methods
    private func setItemDetail(){
        if let itemDetailSet = itemDetail{
            titleLabel.text = itemDetailSet.title
            dateLabel.text = itemDetailSet.created_at
            bodyLabel.text = itemDetailSet.body
            
            guard let itemImage = itemDetailSet.image_url else {
                return
            }
            
            if let imageURL = URL(string: itemImage){
                itemImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
            }
        } else if let favoriteItemDetailSet = favoriteItemSelected {
            titleLabel.text = favoriteItemDetailSet.title
            dateLabel.text = favoriteItemDetailSet.date
            bodyLabel.text = favoriteItemDetailSet.body
            
            guard let itemImage = favoriteItemDetailSet.image else {
                return
            }
            
            if let imageURL = URL(string: itemImage){
                itemImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
            }
        }
    }
    
    //MARK: - User interaction
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if let saveItem = itemDetail{
            let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
            let item = Items(context: context)
            
            item.title = saveItem.title
            item.date = saveItem.created_at
            item.body = saveItem.body
            item.image = saveItem.image_url
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
}
