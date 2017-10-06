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
    
    @IBOutlet weak var calcOverlay: UIView!
    @IBOutlet weak var calcDisplay: UILabel!
    
    let numFormat: String = "%03d"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func p1AddTapped(sender: AnyObject) {
        calcDisplay.text = String(format: numFormat, 0)
        calcOverlay.hidden = false
    }

    @IBAction func p1UndoTapped(sender: AnyObject) {
        p1First.text = String(format: numFormat, Int(p1First.text!)! - Int(calcDisplay.text!)!)
    }
    
    @IBAction func calc1Tapped(sender: AnyObject) { calcNumTapped(1) }
    @IBAction func calc2Tapped(sender: AnyObject) { calcNumTapped(2) }
    @IBAction func calc3Tapped(sender: AnyObject) { calcNumTapped(3) }
    @IBAction func calc4Tapped(sender: AnyObject) { calcNumTapped(4) }
    @IBAction func calc5Tapped(sender: AnyObject) { calcNumTapped(5) }
    @IBAction func calc6Tapped(sender: AnyObject) { calcNumTapped(6) }
    @IBAction func calc7Tapped(sender: AnyObject) { calcNumTapped(7) }
    @IBAction func calc8Tapped(sender: AnyObject) { calcNumTapped(8) }
    @IBAction func calc9Tapped(sender: AnyObject) { calcNumTapped(9) }
    @IBAction func calc0Tapped(sender: AnyObject) { calcNumTapped(0) }

    func calcNumTapped(num: Int) {
        calcDisplay.text = String(format: numFormat, Int(calcDisplay.text!)!*10 + num)
    }
    
    @IBAction func calcSubmitTapped(sender: AnyObject) {
        calcOverlay.hidden = true
        p1First.text = String(format: numFormat, Int(p1First.text!)! + Int(calcDisplay.text!)!)
    }
}

