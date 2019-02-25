//
//  ViewController.swift
//  learnPogoda
//
//  Created by Mark on 31/01/2019.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var Indicator: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
    }


}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let urlString = "https://api.apixu.com/v1/current.json?key=5318f945dbfb45bca46125503193101&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: urlString)
        
        var locationName: String?
        var temperatura: Double?
        
        let task = URLSession.shared.dataTask(with: url!){ [weak self] (data, response, error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let location = json["location"]{
                    locationName = location["name"] as? String
                }
                if let current = json["current"]{
                    temperatura = current["temp_c"] as? Double
                }
                DispatchQueue.main.async {
                    self?.cityLabel.text = locationName
                    
                    self?.temperatureLabel.text =  "\(temperatura!)"
                }
             
                
            } catch let jsonError{
                print(jsonError)
            }
       
    }
         task.resume()
    }
    
}
