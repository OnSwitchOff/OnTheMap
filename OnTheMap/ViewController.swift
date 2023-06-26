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
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"udacity\": {\"username\" : \"kassovvg@gmail.com\", \"password\": \"LightOff17\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if  error != nil {
                return
            }
            let range = 5..<data!.count
            let newData = data?.subdata(in: range)
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
}

