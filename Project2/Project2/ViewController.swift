//
//  ViewController.swift
//  Project2
//
//  Created by sasageyo on 1.09.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfQuestions = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(viewScore))
        
        askQuestion()
}
    func askQuestion(action: UIAlertAction! = nil) {
        if numberOfQuestions == 10 {
            numberOfQuestions = 0
            score = 0
        }
        numberOfQuestions += 1
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() + "   -  SCORE: " + String(score)
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if numberOfQuestions == 10 {
            let ac2 = UIAlertController(title: "Game Over", message: "Your final score is \(score)", preferredStyle:  .alert)
            ac2.addAction(UIAlertAction(title: "New Game", style: .default, handler: askQuestion))
            present(ac2, animated: true)
        }
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[correctAnswer].uppercased())"
            score -= 1
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    @objc func viewScore() {
        let text = "Your score is \(score)"
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        present(vc, animated: true)
    }
}

