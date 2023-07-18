//
//  ViewController.swift
//  OnTheMap
//
//  Created by MacBook Pro on 26.06.23.
//
import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    @IBAction func loginTapped(_ sender: UIButton) {
        OTMUdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            let params: String = OTMQueryStringBuilder().buildGetStudentLocationQueryParamString(limit: 100, orderBy: "updatedAt", asc: false)
            _ = OTMUdacityClient.getStudentsLocation(queryParams: params, completion: handleGetStudentLocationResponse(locationList:error:))
        } else {
            if let response = error as? OTMResponse {
                switch response.statusCode {
                case 400:
                    showLoginFailure(message: "Please enter your credentials")
                case 403:
                    showLoginFailure(message: "The credentials were incorrect, please check youy email or/and your password")
                default:
                    showLoginFailure(message: error?.localizedDescription ?? "")
                }
                return
            }
            showLoginFailure(message: "The Internet connection is offline, please try againe later")
        }
    }
    
    func handleGetStudentLocationResponse(locationList: [StudentLocation]?, error: Error?) {
        if error == nil {
            if let locationList = locationList {
                OnTheMapData.locationList = locationList
            }
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        OTMUdacityClient.logout {_,_ in 
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func pinTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Confirmation", message: "Do you want to post your location?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [self] (_) in
            OnTheMapData.selectedLocation = nil
            //self.performSegue(withIdentifier: "showDetail", sender: nil)
            self.performSegue(withIdentifier: "postLocation", sender: nil)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

