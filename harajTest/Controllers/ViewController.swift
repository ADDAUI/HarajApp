//
//  ViewController.swift
//  harajTest
//
//  Created by Audai Al-Fandi on 11/09/2019.
//  Copyright © 2019 Audai Al-Fandi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UITableViewController {

    //Consts and Vars
    let URL = "https://audai.me/haraj.json"
    var postingsArray: [Posting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.tintColor = .white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
    }

    @objc func refreshData() {
        refreshControl?.endRefreshing()
        getData(URL)
    }
    
    func getData(_ url:String) {
        //TODO get the Data from the link
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                self.presentData(JSON(response.result.value))
                }else{
                    print("Error: \(String(describing: response.result.error))")
                }
        }
    }
    
    func presentData(_ json:JSON) {
        //TODO Present Json Content to Table
        postingsArray.removeAll(keepingCapacity: false)
        for i in json.array!{
            let name = JSON(i).dictionary!["name"]?.string ?? "No Name"
            let url = JSON(i).dictionary!["url"]?.string ?? "No URL"
            let newPost = Posting(name: name, url: url)
            postingsArray.append(newPost)
        }
        tableView.reloadData()
    }
    
    
    //TABLE View functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postingsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let Posting = postingsArray[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(Posting.name)"
        cell.textLabel?.textAlignment = .right
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedPosting = postingsArray[indexPath.row]
        }
        
    }
    
    
    
}

