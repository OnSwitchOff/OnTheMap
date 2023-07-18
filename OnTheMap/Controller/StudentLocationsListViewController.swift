//
//  StudentLocationsViewController.swift
//  OnTheMap
//
//  Created by MacBook Pro on 3.07.23.
//
import UIKit

class StudentLocationsListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! StudentLocationDetailViewController
            detailVC.location = OnTheMapData.selectedLocation
        }
    }
}

extension StudentLocationsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OnTheMapData.locationList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableViewCell")!
        cell.textLabel?.text = "test"
        
        let info = OnTheMapData.locationList[indexPath.row]
        
        cell.textLabel?.text = info.firstName + " " + info.lastName

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OnTheMapData.selectedLocation = OnTheMapData.locationList[indexPath.row]
 
        let app = UIApplication.shared
        if let toOpen = OnTheMapData.selectedLocation?.mediaURL {
            if let url = URL(string: toOpen) {
                app.open(url)
            } else {
                let alertVC = UIAlertController(title: "Open URL Failed", message: toOpen, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                show(alertVC, sender: nil)
            }
        }
    }
}



