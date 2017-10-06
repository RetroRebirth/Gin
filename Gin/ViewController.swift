//
//  ViewController.swift
//  Gin
//
//  Created by Christopher Williams on 10/5/17.
//  Copyright © 2017 Christopher Williams. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(angle angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat(M_PI)
        let rotation = CGAffineTransformRotate(self.transform, radians);
        self.transform = rotation
    }
}

class ViewController: UIViewController {
    
    struct IntStack {
        var items = [Int]()
        mutating func push(item: Int) {
            items.append(item)
        }
        mutating func pop() -> Int {
            return items.removeLast()
        }
        func isEmpty() -> Bool {
            return items.isEmpty
        }
        mutating func clear() {
            items.removeAll()
        }
    }

    @IBOutlet weak var p1First: UILabel!
    @IBOutlet weak var p1Second: UILabel!
    @IBOutlet weak var p1Third: UILabel!
    @IBOutlet weak var p1UndoButton: UIButton!
    
    @IBOutlet weak var p2View: UIView!
    
    @IBOutlet weak var calcOverlay: UIView!
    @IBOutlet weak var calcDisplay: UILabel!
    
    let numFormat: String = "%03d"
    
    var undos: IntStack = IntStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        p2View.rotate(angle: 180)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func p1AddTapped(sender: AnyObject) {
        calcDisplay.text = String(format: numFormat, 000)
        calcOverlay.hidden = false
    }

    @IBAction func p1UndoTapped(sender: AnyObject) {
        let num = undos.pop()
        p1First.text = String(format: numFormat, Int(p1First.text!)! - num)
        
        if undos.isEmpty() {
            p1UndoButton.enabled = false
        }
    }
    
    @IBAction func p1ClearTapped(sender: AnyObject) {
        p1First.text = String(format: numFormat, 000)
        undos.clear()
        
        p1UndoButton.enabled = false
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
        
        let num = Int(calcDisplay.text!)!
        p1First.text = String(format: numFormat, Int(p1First.text!)! + num)
        undos.push(num)
        
        if !p1UndoButton.enabled {
            p1UndoButton.enabled = true
        }
    }
}

