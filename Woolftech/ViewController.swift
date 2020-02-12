//
//  ViewController.swift
//  Woolftech
//
//  Created by Orlando Cota on 2/5/20.
//  Copyright © 2020 Orlando Cota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func fromNewAccount(segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func Logout(segue: UIStoryboardSegue)
    {
        //Do Nothing
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginPage"
        {
            let des = segue.destination as! LoginViewController
            des.username = username.text ?? ""
        }
    }
}

