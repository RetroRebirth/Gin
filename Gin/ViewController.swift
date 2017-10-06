//
//  ViewController.swift
//  Gin
//
//  Created by Christopher Williams on 10/5/17.
//  Copyright © 2017 Christopher Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var p1First: UILabel!
    @IBOutlet weak var p1Second: UILabel!
    @IBOutlet weak var p1Third: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func p1AddTapped(sender: AnyObject) {
        p1First.text =  String(Int(p1First.text!)! + 1)
    }

    @IBAction func p1UndoTapped(sender: AnyObject) {
        p1Second.text =  String(Int(p1Second.text!)! + 1)
    }
    
}

