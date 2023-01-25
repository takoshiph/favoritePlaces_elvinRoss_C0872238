//
//  ViewController.swift
//  favoritePlaces_elvinRoss_C0872238
//
//  Created by Elvin Ross Fabella on 2023-01-24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var faveLocations: [String] = ["Scarborough, Ontario","Missasauga, Ontario","Tondo, Philippines"]
    //var receivedData: String?
    var userDefaults = UserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //receivedData = UserDefaults.value(forKey: "locality") as? String
        
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return faveLocations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let location = userDefaults.value(forKey: "locality") as? String

        cell.textLabel?.text = faveLocations[indexPath.row]
        //cell.textLabel?.text = location

        //cell.textLabel?.text = faveLocations
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            faveLocations.remove(at: indexPath.row)
            //receivedData?.remove(at: [0])
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
            
    }
    
}
