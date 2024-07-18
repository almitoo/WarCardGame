//
//  ViewController.swift
//  War Card Game
//
//  Created by Student14 on 24/06/2024.
//

import UIKit


 class ViewController: UIViewController {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var playerLeftScoreLabel: UILabel!
    @IBOutlet weak var aiRightScoreLabel: UILabel!
     @IBOutlet weak var playerNameLabel: UILabel!
     
    private var gameManager: GameManager!
    private var ticker: MyTicker!
    private var isPlaying = false
     private var numRound=0
     private let maxRounds=10
     var playerName: String?
     var isEastLocation: Bool = false
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        gameManager = GameManager()
        ticker = MyTicker(seconds: 7) { [weak self] in
            self?.playRound()
        }
        
        // Set initial state
        resetCardImages()
        playerNameLabel.text = playerName
        updateScoreLabels()
        adjustLayoutForLocation()
        
        ticker.start()
    }
     private func adjustLayoutForLocation() {
             if isEastLocation {
                 // Player on the right side, AI on the left side
                 playerNameLabel.frame.origin.x = view.frame.width - playerNameLabel.frame.width - 20
                 playerLeftScoreLabel.frame.origin.x = view.frame.width - playerLeftScoreLabel.frame.width - 20
                 aiRightScoreLabel.frame.origin.x = 20
             } else {
                 // Player on the left side, AI on the right side
                 playerNameLabel.frame.origin.x = 20
                 playerLeftScoreLabel.frame.origin.x = 20
                 aiRightScoreLabel.frame.origin.x = view.frame.width - aiRightScoreLabel.frame.width - 20
             }
         }
    
    private func playRound() {
        if numRound >= maxRounds{
            ticker.stop()
            resetCardImages()
            showWinner()
            return
        }
        resetCardImages()
        // Show "back" images for 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                    self?.showCards()
                }
            }
            
            private func showCards() {
                let leftCard = gameManager.drawCard()
                let rightCard = gameManager.drawCard()
                
                leftImageView.image = UIImage(named: leftCard)
                rightImageView.image = UIImage(named: rightCard)
                
                // Show the drawn cards for 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                    self?.updateScores(leftCard: leftCard, rightCard: rightCard)
                    self?.numRound += 1
                }
            }
     
     private func updateScores(leftCard: String, rightCard: String) {
             gameManager.updateScores(leftCard: leftCard, rightCard: rightCard)
             updateScoreLabels()
             resetCardImages()
         }
     private func updateScoreLabels() {
        let scores = gameManager.getScores()
        playerLeftScoreLabel.text = "\(scores.left)"
        aiRightScoreLabel.text = " \(scores.right)"
    }
    
    private func resetCardImages() {
        leftImageView.image = UIImage(named: "back")
        rightImageView.image = UIImage(named: "back")
    }
     private func showWinner() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let winnerVC = storyboard.instantiateViewController(withIdentifier: "winner") as? WinnerViewController {
                let scores = gameManager.getScores()
                winnerVC.playerScore = scores.left
                winnerVC.aiScore = scores.right
                winnerVC.playerName=playerName
                self.present(winnerVC, animated: true)
            }
        }
}
