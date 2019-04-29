//
//  LoginViewController.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    private var currentTextField: UITextField?
    
    private var loginData: LoginResponseModel?
    
    //MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - override methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentTextField?.resignFirstResponder()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemsViewController"{
            let navigationController = segue.destination as! UINavigationController
            
            let itemsViewController = navigationController.viewControllers.first as! ItemsViewController
            
            itemsViewController.loginData = loginData
        }
    }
    
    
    //MARK: - User interaction
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        login()
    }
    
    @IBAction func showPasswordButtonPresse(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    
    //MARK: - Private methods
    private func login(){
        if emailTextField.text == "" || passwordTextField.text == ""{
            let alertController = UIAlertController(title: "Campos Vacíos", message: "Ingresa el usuario o contraseña", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion:  nil)
        }else{
            
            //User: sergio@kokonutstudio.com Password: 1234qwer
            let params : [String : Any] = [
                "username": emailTextField.text!,
                "password": passwordTextField.text!
            ]
            
            Alamofire.request(Constants.API.loginStr, method: .post, parameters: params)
            .validate()
                .responseData { (response) in
                    switch response.result{
                    case .success(let value):
                        do{
                            
                            let loginResponse = try JSONDecoder().decode(LoginResponseModel.self, from: value)
                            if loginResponse.success == 1{
                                self.loginData = loginResponse
                                //print(loginResponse.data.access_token!)
                                self.performSegue(withIdentifier: "ItemsViewController", sender: self.loginData)
                            }else{
                                print("Error de sesión")
                            }
                            
                        }catch let error{
                            print("LoginResponseModel error \(error.localizedDescription)")
                            let alertController = UIAlertController(title: "Ha ocurrido un error", message: "Verifica que tus datos sean correctos o intentalo más tarde Gracias.", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion:  nil)
                        }
                    case .failure(let error):
                        print("Response error \(error.localizedDescription)")
                    }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField =  view.viewWithTag(textField.tag + 1) as? UITextField
        {
            nextTextField.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
            login()
        }
        return true
        
        /*
        
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            currentTextField?.resignFirstResponder()
            login()
        default:
            break
        }
        
        return true*/
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        currentTextField = nil
    }
}
