//
//  ViewController.swift
//  TicTacToe
//
//  Created by Chantal on 2025-01-03.
//

import UIKit

class ViewController: UIViewController {

    enum Turn {
        case o
        case x
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.x
    var currentTurn = Turn.x
    var board = [UIButton]()
    
    var O = "O"
    var X = "X"
    
    var OScore = 0
    var XScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }


    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if (checkForVictory(X)) {
            XScore += 1
            resultAlert(title: "X Wins!")
        }
        if (checkForVictory(O)) {
            OScore += 1
            resultAlert(title: "O Wins!")
        }
        
        if (fullBoard()) {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s: String) -> Bool {
        // Horizontal Victory
        if (thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)) {
            return true
        }
        if (thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)) {
            return true
        }
        if (thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)) {
            return true
        }
        
        // Vertical Victory
        if (thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)) {
            return true
        }
        if (thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)) {
            return true
        }
        if (thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)) {
            return true
        }
        
        // Diagonal Victory
        if (thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)) {
            return true
        }
        if (thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)) {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "\nO score: " + String(OScore) + "\nX score: " + String(XScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if(firstTurn == Turn.o) {
            firstTurn = Turn.x
            turnLabel.text = X
        }
        else if(firstTurn == Turn.x) {
            firstTurn = Turn.o
            turnLabel.text = O
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            if(currentTurn == Turn.o){
                sender.setTitle(O, for: .normal)
                currentTurn = Turn.x
                turnLabel.text = X
            }
            else if(currentTurn == Turn.x){
                sender.setTitle(X, for: .normal)
                currentTurn = Turn.o
                turnLabel.text = O
            }
            sender.isEnabled = false
        }
    }
}

