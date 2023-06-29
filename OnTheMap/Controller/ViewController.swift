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
            print(success)
            let params: String = OTMQueryStringBuilder().buildGetStudentLocationQueryParamString(limit: 100, orderBy: "asdasd")
            _ = OTMUdacityClient.getStudentsLocation(queryParams: params, completion: handleGetStudentLocationResponse(locationList:error:))
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleGetStudentLocationResponse(locationList: [StudentLocation], error: Error?) {
        if error == nil {
            print(locationList[0].firstName)
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

