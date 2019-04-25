//
//  UserProfileViewController.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class UserProfileViewController: UIViewController {

    var dataLogin: LoginResponseModel!
    
    //MARK: - Outlets
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var secondLastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - private methods
    private func getUserProfile(){
        
        guard let userData = dataLogin.data.access_token else{return}
            
        let headers = [
            "lang" : "es_mx",
            "Accept" : "application/json",
            "Authorization" : "Bearer \(userData)"
        ]
        
        
        Alamofire.request(Constants.API.userProfileStr, method: .get, headers: headers)
        .validate()
            .responseData { (response) in
                //print("este es el resultado \(response.result)")
                switch response.result{
                case .success(let value):
                    do{
                        let userProfileResponseModel = try JSONDecoder().decode(UserProfileResponseModel.self, from: value)
                        
                        if userProfileResponseModel.success == 1{
                            self.nameLabel.text = userProfileResponseModel.data?.name
                            self.lastNameLabel.text = userProfileResponseModel.data?.last_name
                            self.secondLastNameLabel.text = userProfileResponseModel.data?.second_last_name
                            self.emailLabel.text = userProfileResponseModel.data?.email
                            guard let userImage = userProfileResponseModel.data?.image else{return}
                            
                            //print(userProfileResponseModel.data?.image)
                            
                            if let imageURL = URL(string: userImage){
                                self.userProfileImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
                            }
                            
                        }else{
                            print("Error al obtener el userProfile")
                            /*let alertController = UIAlertController(title: "Error de sesión", message: "Verifica que tus datos sean correctos.", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion:  nil)*/
                        }
                        
                        
                    }catch let error{
                        print("JSONDecode Error \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("UserProfileResponse Error \(error.localizedDescription)")
                }
                
        }
        
    }

}
