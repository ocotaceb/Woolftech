//
//  LoginViewController.swift
//  Woolftech
//
//  Created by Sudarshan Kadalazhi (Student) on 2/5/20.
//  Copyright © 2020 Orlando Cota. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var greeting: UILabel!
    var username: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
        greeting.text = "Hello, " + username + "!"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToLogin(segue: UIStoryboardSegue)
    {
        //Do Nothing
    }
}
