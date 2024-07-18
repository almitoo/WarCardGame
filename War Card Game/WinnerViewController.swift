//
//  WinnerViewController.swift
//  War Card Game
//
//  Created by Student14 on 14/07/2024.
//

import  UIKit

class WinnerViewController: UIViewController{
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var playerScore: Int = 0
       var aiScore: Int = 0
       var playerName: String? // Variable to hold the player's name

       override func viewDidLoad() {
           super.viewDidLoad()
           if playerScore > aiScore {
                       winnerLabel.text = "\(playerName ?? "Player") Wins!"
                       scoreLabel.text = "Score: \(playerScore)"
                   } else {
                       winnerLabel.text = "AI Wins!"
                       scoreLabel.text = "Score: \(aiScore)"
                   }
       }
    
    
    @IBAction func buttomBackMenu(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "menu") as? menuViewController {
            
            self.present(vc, animated: true)
        }
    }

}
