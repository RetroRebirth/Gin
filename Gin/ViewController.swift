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
    func rotate(_ angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat(Double.pi)
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}

class ViewController: UIViewController {
    
    struct IntStack {
        var items = [Int]()
        mutating func push(_ item: Int) {
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
    @IBOutlet weak var p1ClearButton: UIButton!
    
    @IBOutlet weak var p2View: UIView!
    @IBOutlet weak var p2First: UILabel!
    @IBOutlet weak var p2Second: UILabel!
    @IBOutlet weak var p2Third: UILabel!
    @IBOutlet weak var p2UndoButton: UIButton!
    @IBOutlet weak var p2ClearButton: UIButton!
    
    @IBOutlet weak var calcOverlay: UIView!
    @IBOutlet weak var calcDisplay: UILabel!
    
    // Variables
    let numFormat: String = "%03d" // TODO caps lock
    let STAGE_WIN: Int = 150
    let NUM_STAGES: Int = 3
    
    var p1Calc: Bool = true
    
    var p1Undos: IntStack = IntStack()
    var p1Stage: Int = 0
    var p2Undos: IntStack = IntStack()
    var p2Stage: Int = 0
    
    // Control Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        p2View.rotate(180)
        
        p1UndoButton.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        p1ClearButton.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        p2UndoButton.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        p2ClearButton.setTitleColor(UIColor.gray, for: UIControlState.disabled)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // p1 Button Actions

    @IBAction func p1AddTapped(_ sender: Any) { addTapped(true) }
    @IBAction func p1UndoTapped(_ sender: Any) { undoTapped(true) }
    @IBAction func p1ClearTapped(_ sender: Any) { clearTapped(true) }
    
    // p2 Button Actions
    @IBAction func p2AddTapped(_ sender: Any) { addTapped(false) }
    @IBAction func p2UndoTapped(_ sender: Any) { undoTapped(false) }
    @IBAction func p2ClearTapped(_ sender: Any) { clearTapped(false) }
    
    // p1/p2 Button Actions
    func addTapped(_ p1: Bool) {
        if p1 != p1Calc {
            calcOverlay.rotate(180)
        }
        
        p1Calc = p1
        calcDisplay.text = String(format: numFormat, 000)
        calcOverlay.isHidden = false
    }
    func undoTapped(_ p1: Bool) {
        let undoButton = p1 ? p1UndoButton : p2UndoButton
        let clearButton = p1 ? p1ClearButton : p2ClearButton
        
        var text: UILabel? = getCurLabel(p1)
        let curNum = Int(text!.text!)!
        
        if curNum <= 0 {
            if p1 {
                p1Stage = p1Stage - 1
            } else {
                p2Stage = p2Stage - 1
            }
            text = getCurLabel(p1)
        }
        
        var num = 0
        if p1 {
            num = p1Undos.pop()
        } else  {
            num = p2Undos.pop()
        }
        text!.text = String(format: numFormat, Int(text!.text!)! - num)
        if (p1 ? p1Undos : p2Undos).isEmpty() {
            undoButton?.isEnabled = false
            clearButton?.isEnabled = false
        }
    }
    func clearTapped(_ p1: Bool) {
        let undoButton = p1 ? p1UndoButton : p2UndoButton
        let clearButton = p1 ? p1ClearButton : p2ClearButton
        let first = p1 ? p1First : p2First
        let second = p1 ? p1Second : p2Second
        let third = p1 ? p1Third : p2Third
        
        first?.text = String(format: numFormat, 000)
        second?.text = String(format: numFormat, 000)
        third?.text = String(format: numFormat, 000)
        if p1 {
            p1Undos.clear()
            p1Stage = 0
        } else  {
            p2Undos.clear()
            p2Stage = 0
        }
        undoButton?.isEnabled = false
        clearButton?.isEnabled = false
    }
    
    // Calculator Actions
    @IBAction func calc1Tapped(_ sender: Any) { calcNumTapped(1) }
    @IBAction func calc2Tapped(_ sender: Any) { calcNumTapped(2) }
    @IBAction func calc3Tapped(_ sender: Any) { calcNumTapped(3) }
    @IBAction func calc4Tapped(_ sender: Any) { calcNumTapped(4) }
    @IBAction func calc5Tapped(_ sender: Any) { calcNumTapped(5) }
    @IBAction func calc6Tapped(_ sender: Any) { calcNumTapped(6) }
    @IBAction func calc7Tapped(_ sender: Any) { calcNumTapped(7) }
    @IBAction func calc8Tapped(_ sender: Any) { calcNumTapped(8) }
    @IBAction func calc9Tapped(_ sender: Any) { calcNumTapped(9) }
    @IBAction func calc0Tapped(_ sender: Any) { calcNumTapped(0) }
    func calcNumTapped(_ num: Int) {
        calcDisplay.text = String(format: numFormat, (Int(calcDisplay.text!)!*10 + num) % 1000)
    }
    @IBAction func calcSubmitTapped(_ sender: Any) {
        let undoButton = p1Calc ? p1UndoButton : p2UndoButton
        let clearButton = p1Calc ? p1ClearButton : p2ClearButton

        var text: UILabel? = getCurLabel(p1Calc)
        
        calcOverlay.isHidden = true
        
        let num = Int(calcDisplay.text!)!
        let sum = Int(text!.text!)! + num
        text!.text = String(format: numFormat, sum)
        if p1Calc {
            p1Undos.push(num)
        } else  {
            p2Undos.push(num)
        }
        if !undoButton!.isEnabled {
            undoButton?.isEnabled = true
        }
        if !clearButton!.isEnabled {
            clearButton?.isEnabled = true
        }
        
        // Check winning condition
        if sum >= STAGE_WIN {
            if p1Calc {
                p1Stage += 1
                if p1Stage >= NUM_STAGES {
                    print("P1 WINS!")
                    // TODO display win message
//                    clearTapped(true)
//                    clearTapped(false)
                }
            } else {
                p2Stage += 1
                if p2Stage >= NUM_STAGES {
                    print("P2 WINS!")
                    // TODO display win message
//                    clearTapped(true)
//                    clearTapped(false)
                }
            }
        }
    }
    
    func getCurLabel(_ p1: Bool) -> UILabel {
        if p1 {
            switch p1Stage {
            case 0:
                return p1First
            case 1:
                return p1Second
            case 2:
                return p1Third
            default:
                print("Unexpected value: \(p1Stage)")
                return p1Third
            }
        } else {
            switch p2Stage {
            case 0:
                return p2First
            case 1:
                return p2Second
            case 2:
                return p2Third
            default:
                print("Unexpected value: \(p2Stage)")
                return p2Third
            }
        }
        
        return p1First
    }
}

