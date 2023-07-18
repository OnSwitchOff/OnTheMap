//
//  StudentLocationDetailViewController.swift
//  OnTheMap
//
//  Created by MacBook Pro on 5.07.23.
//

import UIKit

class StudentLocationDetailViewController: UIViewController {
    var location: StudentLocation?
    var isReadOnly: Bool!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mediaUrlTextField: UITextField!
    @IBOutlet weak var mapLocationTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var uniqueKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        isReadOnly = location != nil
        if location == nil {
            location = StudentLocation()
        }
        firstNameTextField.text = location!.firstName
        firstNameTextField.isUserInteractionEnabled = !isReadOnly
        lastNameTextField.text = location!.lastName
        lastNameTextField.isUserInteractionEnabled = !isReadOnly
        mediaUrlTextField.text = location!.mediaURL
        mediaUrlTextField.isUserInteractionEnabled = !isReadOnly
        mapLocationTextField.text = location!.mapString
        mapLocationTextField.isUserInteractionEnabled = !isReadOnly
        latitudeTextField.text = String(location!.latitude)
        latitudeTextField.isUserInteractionEnabled = !isReadOnly
        longitudeTextField.text = String(location!.longitude)
        longitudeTextField.isUserInteractionEnabled = !isReadOnly
        uniqueKeyTextField.text = location!.uniqueKey
        uniqueKeyTextField.isUserInteractionEnabled = !isReadOnly
    }
    
    @IBAction func PostButtonTabbed(_ sender: UIButton) {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let mapString = mapLocationTextField.text!
        let mediaURL = mediaUrlTextField.text!
        let latitude: Double = Double(latitudeTextField.text!) ?? 0
        let longitude: Double = Double(longitudeTextField.text!) ?? 0
        OTMUdacityClient.createNewStudentLocation(firstName: firstName, lastName: lastName, mapString: mapString, mediaUrl: mediaURL, lat: latitude, long: longitude, completion: handleCreateNewStudentLocationResponse(success:error:))
    }
    
    func handleCreateNewStudentLocationResponse(success: Bool, error: Error?) {
        if success {
            print(success)
            navigationController?.popViewController(animated: true)
        } else {
            showPostFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func showPostFailure(message: String) {
        let alertVC = UIAlertController(title: "Post location Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}
