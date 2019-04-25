//
//  FavoriteItemsViewController.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit

class FavoriteItemsViewController: UIViewController {

    private var dataSource: [Items] = []
    private var refreshControl = UIRefreshControl()
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(readData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        readData()
        
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavoriteItemViewController"{
            let favoriteItemViewController = segue.destination as! FavoriteItemViewController
            favoriteItemViewController.favoriteItemSelected = sender as! Items
        }
    }
    
    //MARK: - Private methods
    @objc private func readData(){
        dataSource = CoreDataManager.sharedInstance.readData(class: Items.self)
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

extension FavoriteItemsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteItemsTableViewCell") as! FavoriteItemsTableViewCell
        
        cell.favoriteitem = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favoriteItem = dataSource[indexPath.row]
        performSegue(withIdentifier: "FavoriteItemViewController", sender: favoriteItem)
    }
}
