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

    // UI Elements
    @IBOutlet weak var p1First: UILabel!
    @IBOutlet weak var p1Second: UILabel!
    @IBOutlet weak var p1Third: UILabel!
    @IBOutlet weak var p1UndoButton: UIButton!
    
    @IBOutlet weak var p2View: UIView!
    @IBOutlet weak var p2First: UILabel!
    @IBOutlet weak var p2Second: UILabel!
    @IBOutlet weak var p2Third: UILabel!
    @IBOutlet weak var p2UndoButton: UIButton!
    
    @IBOutlet weak var calcOverlay: UIView!
    @IBOutlet weak var calcDisplay: UILabel!
    
    // Variables
    let numFormat: String = "%03d"
    
    var p1Calc: Bool = true
    
    var p1Undos: IntStack = IntStack()
    var p2Undos: IntStack = IntStack()
    
    // Control Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        p2View.rotate(angle: 180)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // p1 Button Actions
    @IBAction func p1AddTapped(sender: AnyObject) { addTapped(true) }
    @IBAction func p1UndoTapped(sender: AnyObject) { undoTapped(true) }
    @IBAction func p1ClearTapped(sender: AnyObject) { clearTapped(true) }
    
    // p2 Button Actions
    @IBAction func p2AddTapped(sender: AnyObject) { addTapped(false) }
    @IBAction func p2UndoTapped(sender: AnyObject) { undoTapped(false) }
    @IBAction func p2ClearTapped(sender: AnyObject) { clearTapped(false) }
    
    // p1/p2 Button Actions
    func addTapped(p1: Bool) {
        p1Calc = p1
        calcDisplay.text = String(format: numFormat, 000)
        
        calcOverlay.hidden = false
    }
    func undoTapped(p1: Bool) {
        let undoButton = p1 ? p1UndoButton : p2UndoButton
        let first = p1 ? p1First : p2First
        
        var num = 0
        if p1 {
            num = p1Undos.pop()
        } else  {
            num = p2Undos.pop()
        }
        first.text = String(format: numFormat, Int(first.text!)! - num)
        if (p1 ? p1Undos : p2Undos).isEmpty() {
            undoButton.enabled = false
        }
    }
    func clearTapped(p1: Bool) {
        let undoButton = p1 ? p1UndoButton : p2UndoButton
        let first = p1 ? p1First : p2First
        
        first.text = String(format: numFormat, 000)
        if p1 {
            p1Undos.clear()
        } else  {
            p2Undos.clear()
        }
        undoButton.enabled = false
    }
    
    // Calculator Actions
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
        calcDisplay.text = String(format: numFormat, (Int(calcDisplay.text!)!*10 + num) % 1000)
    }
    @IBAction func calcSubmitTapped(sender: AnyObject) {
        let undoButton = p1Calc ? p1UndoButton : p2UndoButton
        let first = p1Calc ? p1First : p2First
        
        calcOverlay.hidden = true
        
        let num = Int(calcDisplay.text!)!
        first.text = String(format: numFormat, Int(first.text!)! + num)
        if p1Calc {
            p1Undos.push(num)
        } else  {
            p2Undos.push(num)
        }
        if !undoButton.enabled {
            undoButton.enabled = true
        }
    }
}

