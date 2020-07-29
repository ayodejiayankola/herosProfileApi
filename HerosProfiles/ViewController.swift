//
//  ViewController.swift
//  HerosProfiles
//
//  Created by Ayodeji Ayankola on 7/28/20.
//  Copyright © 2020 konga. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    var heros = [HeroStats]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downloadJson {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heros[indexPath.row].localized_name.capitalized
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination  = segue.destination as? HeroViewController {
            destination.hero = heros[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
     func downloadJson(completed: @escaping () -> ()){
          let url = URL(string: "https://api.opendota.com/api/heroStats")
          URLSession.shared.dataTask(with:url!){ (data, response, error ) in
            if error == nil {
            do {
                self.heros = try JSONDecoder().decode([HeroStats].self, from: data!)
                DispatchQueue.main.async {
                    completed()
                }
                completed()
            } catch {
                print("JSON error")
                }
            }
          }.resume()
        }
    }

