//
//  DetailViewController.swift
//  harajTest
//
//  Created by Audai Al-Fandi on 11/09/2019.
//  Copyright © 2019 Audai Al-Fandi. All rights reserved.
//


import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    //Consts and Vars
    var selectedPosting:Posting? = nil
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = selectedPosting?.name
        Alamofire.request(selectedPosting!.url, method: .get).validate()
            .responseData(completionHandler: { (responseData) in
                self.image.image = UIImage(data: responseData.data!)
            })

    }
    
    @IBAction func doneClicked(_ sender: Any) {
        print("HERE")
        self.dismiss(animated: true, completion: nil)
    }
    
}
