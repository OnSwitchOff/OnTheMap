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
                    self.mapView.addAnnotation(annotation)
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
                self.mapView.addAnnotation(annotation)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: coordinate!, span: span)
                
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @IBAction func postLocationTapped(_ sender: Any) {
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
