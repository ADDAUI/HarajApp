//
//  Posting.swift
//  harajTest
//
//  Created by Audai Al-Fandi on 11/09/2019.
//  Copyright © 2019 Audai Al-Fandi. All rights reserved.
//

import Foundation

class Posting {
    
    var name: String = ""
    var url: String = ""
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    func printPost() {
        print("name = \(self.name)")
        print("url = \(self.url)")
    }
    
}
