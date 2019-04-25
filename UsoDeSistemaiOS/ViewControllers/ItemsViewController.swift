//
//  ItemsViewController.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ItemsViewController: UIViewController {

    var loginData: LoginResponseModel!
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = [ItemsModel]()
    private var refreshControl = UIRefreshControl()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(getItems), for: .valueChanged)
        tableView.addSubview(refreshControl)
        getItems()
        
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserProfileViewController"{
            let userProfileViewController = segue.destination as! UserProfileViewController
            userProfileViewController.dataLogin = loginData
        }else if segue.identifier == "ItemDetailViewController"{
            let itemDetailViewController = segue.destination as! ItemDetailViewController
            
            itemDetailViewController.itemDetail = sender as? ItemsModel
            
        }
       
    }
    
    //MARK: private methods
    @objc private func getItems(){
        Alamofire.request(Constants.API.postsStr)
        .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    do{
                        let itemsResponseModel = try JSONDecoder().decode(ItemsResponseModel.self, from: value)
                        
                        guard let postItems = itemsResponseModel.data!.data else {return}
                        
                        if itemsResponseModel.success == 1 {
                            self.dataSource = postItems
                            self.tableView.reloadData()
                            self.refreshControl.endRefreshing()
                            //print(self.dataSource.count)
                            
                        }
                        
                    }catch let error{
                        print("ItemsResponseModel Error \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error getItemsRequest \(error.localizedDescription)")
                }
        }
    }
    

    //MARK: - User interaction
    @IBAction func userProfileButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "UserProfileViewController", sender: loginData)
    }
    
    
    
}



extension ItemsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsTableViewCell") as! ItemsTableViewCell
        
        cell.itemsDataSource = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource[indexPath.row]
        performSegue(withIdentifier: "ItemDetailViewController", sender: item)
    }
}
