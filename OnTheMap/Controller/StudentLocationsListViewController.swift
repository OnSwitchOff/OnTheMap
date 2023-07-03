//
//  StudentLocationsViewController.swift
//  OnTheMap
//
//  Created by MacBook Pro on 3.07.23.
//
import UIKit

class StudentLocationsListViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }}

extension StudentLocationsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableViewCell")!
        cell.textLabel?.text = "test"
        return cell
    }
    
    
}


