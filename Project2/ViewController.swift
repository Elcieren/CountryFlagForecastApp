//
//  ViewController.swift
//  Project2
//
//  Created by Eren Elçi on 20.09.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button1: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counter = 0
    var highScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HighScor Check
        let storedHigScore = UserDefaults.standard.object(forKey: "highscoree")
        
        if storedHigScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        if let newScore = storedHigScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        countries += ["estonia","france","germany","ireland","monaco","nigeria","poland","russia","spain","uk","us"]
        
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderColor = UIColor.black.cgColor
        
        
        
        asQuestion()
        
        
    }
    
    func asQuestion(action: UIAlertAction! = nil ){
        
        countries.shuffle()// bu metot array karıştırı ve bir öncekinden farklı yapar
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) Score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
            var title: String
            counter += 1
            
            if sender.tag == correctAnswer {
                title = "Doğru"
                score += 1
            } else {
                title = "Yanlış"
                score -= 1
                let selectedCountry = countries[sender.tag]
                title += " Seçtiğin Bayrak \(selectedCountry.uppercased())"
            }
            
            if counter == 11 {
                if score > highScore {
                    highScore = score
                    highScoreLabel.text = "Highscore: \(highScore)"
                    UserDefaults.standard.set(highScore, forKey: "highscoree")
                }
                
                let alert1 = UIAlertController(title: "10 tur oynanmıştır. Oyun bitti.", message: "Tekrar oynamak ister misiniz?", preferredStyle: .alert)
                let continueButton = UIAlertAction(title: "Yeni tur", style: .default) { action in
                    self.counter = 0
                    self.score = 0
                    self.asQuestion()
                }
                alert1.addAction(continueButton)
                present(alert1, animated: true)
            } else {
                let alert = UIAlertController(title: title, message:"Şuanki skorun: \(score)", preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "Decam", style: .default, handler: asQuestion)
                alert.addAction(alertButton)
                present(alert, animated: true)
            }
        }
    
}

