//
//  PostStudentLocationViewController.swift
//  OnTheMap
//
//  Created by MacBook Pro on 17.07.23.
//

import UIKit
import MapKit

class PostStudentLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mediaUrlTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var lastAddedAnnotation: MKPointAnnotation? = nil
    
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location0 = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location0, toCoordinateFrom: mapView)
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let _ = error{
                return
            }
            
            if let placemark = placemarks?.first {
                if let address = placemark.name {
                    print(address)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
                    if let lastAddedAnnotation = self.lastAddedAnnotation {
                        self.mapView.removeAnnotation(lastAddedAnnotation)
                    }
                    self.mapView.addAnnotation(annotation)
                    self.lastAddedAnnotation = annotation
                    
                    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                        if let error = error {
                            print(error)
                            self.searchTextField.text = ""
                        }
                        if let placemark = placemarks?.first {
                            self.searchTextField.text = placemark.name ?? ""
                        }
                    }
                }
            }
        }
    }
    
   
    
    @IBAction func searchButtomTapped(_ sender: UIButton) {
        
        guard let searchString = searchTextField.text, !searchString.isEmpty else { return }
        
        CLGeocoder().geocodeAddressString(searchString) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if  let placemark = placemarks?.first {
                
                let location = placemark.location
                let coordinate = location?.coordinate
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(coordinate?.latitude ?? 0, coordinate?.longitude ?? 0)
                
                if let lastAddedAnnotation = self.lastAddedAnnotation {
                    self.mapView.removeAnnotation(lastAddedAnnotation)
                }
                self.mapView.addAnnotation(annotation)
                self.lastAddedAnnotation = annotation
                
                CLGeocoder().reverseGeocodeLocation(location!) { placemarks, error in
                    if let error = error {
                        print(error)
                        self.searchTextField.text = ""
                    }
                    if let placemark = placemarks?.first {
                        self.searchTextField.text = placemark.name ?? ""
                    }
                }
                
                let span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
                let region = MKCoordinateRegion(center: coordinate!, span: span)
                
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @IBAction func postLocationTapped(_ sender: Any) {
        let firstName = OnTheMapData.firstname
        let lastName = OnTheMapData.lastname
        let mapString = searchTextField.text!
        let mediaURL = mediaUrlTextField.text!
        
        let coordinate = lastAddedAnnotation?.coordinate
        let latitude: Double = Double(coordinate?.latitude ?? 0)
        let longitude: Double = Double(coordinate?.longitude ?? 0)
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
    
    // MARK: - MKMapViewDelegate

    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        annotationView.annotation = annotation
        annotationView.pinTintColor = .blue // Set the pin color here
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        annotationView.canShowCallout = true
        return annotationView
    }
    
}
