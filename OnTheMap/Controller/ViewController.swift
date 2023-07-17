//
//  ViewController.swift
//  OnTheMap
//
//  Created by MacBook Pro on 26.06.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        OTMUdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            let params: String = OTMQueryStringBuilder().buildGetStudentLocationQueryParamString(limit: 100, orderBy: "updatedAt", asc: false)
            _ = OTMUdacityClient.getStudentsLocation(queryParams: params, completion: handleGetStudentLocationResponse(locationList:error:))
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleGetStudentLocationResponse(locationList: [StudentLocation]?, error: Error?) {
        if error == nil {
            if let locationList = locationList {
                OnTheMapData.locationList = locationList
            }
            performSegue(withIdentifier: "completeLogin", sender: nil)
            
            
            /*print("++++++Create location")
            let firstName = "Victor"
            let lastName = "Kas"
            let mapString = "Kyiv, UA"
            let mediaURL = "https://udacity.com"
            let latitude: Double = 40.40
            let longitude: Double = 40.40
            OTMUdacityClient.createNewStudentLocation(firstName: firstName, lastName: lastName, mapString: mapString, mediaUrl: mediaURL, lat: latitude, long: longitude, completion: handleCreateNewStudentLocationResponse(success:error:))*/
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleCreateNewStudentLocationResponse(success: Bool, error: Error?) {
        if success {
            print(success)
            
            print("++++++Update location")
            let firstName = "Victor"
            let lastName = "Kas"
            let mapString = "Mariupol, UA"
            let mediaURL = "https://udacity.com"
            let latitude: Double = 40.40
            let longitude: Double = 40.40
            //Thread.sleep(forTimeInterval: 2.0)
            OTMUdacityClient.updateExistingStudentLocation(firstName: firstName, lastName: lastName, mapString: mapString, mediaUrl: mediaURL, lat: latitude, long: longitude, completion: handleUpdateExistingStudentLocationResponse(success:error:))
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleUpdateExistingStudentLocationResponse(success: Bool, error: Error?) {
        if success {
            print(success)
            OTMUdacityClient.logout(completion: handleLogoutResponse(success:error:))
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleLogoutResponse(success: Bool, error: Error?) {
        if success {
            print(success)
            _ = OTMUdacityClient.getPublicUserInfo(completion: handleGetPublicUserInfoResponse(userInfo:error:))
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleGetPublicUserInfoResponse(userInfo: UserInfo?, error: Error?) {
        if let userInfo = userInfo {
            print(userInfo.lastName)
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

