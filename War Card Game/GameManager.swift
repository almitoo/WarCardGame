//
//  GameManager.swift
//  War Card Game
//
//  Created by Student14 on 13/07/2024.
//

import Foundation
class GameManager {
    private var playerLeftScore = 0
    private var aiRightScore = 0
    private let cardImages = [
        "1_of_clubs", "1_of_diamonds", "1_of_hearts", "1_of_spades",
        "2_of_clubs", "2_of_diamonds", "2_of_hearts", "2_of_spades",
        "3_of_clubs", "3_of_diamonds", "3_of_hearts", "3_of_spades",
        "4_of_clubs", "4_of_diamonds", "4_of_hearts", "4_of_spades",
        "5_of_clubs", "5_of_diamonds", "5_of_hearts", "5_of_spades",
        "6_of_clubs", "6_of_diamonds", "6_of_hearts", "6_of_spades",
        "7_of_clubs", "7_of_diamonds", "7_of_hearts", "7_of_spades",
        "8_of_clubs", "8_of_diamonds", "8_of_hearts", "8_of_spades",
        "9_of_clubs", "9_of_diamonds", "9_of_hearts", "9_of_spades",
        "10_of_clubs", "10_of_diamonds", "10_of_hearts", "10_of_spades",
        "11_of_clubs", "11_of_diamonds", "11_of_hearts", "11_of_spades",
        "12_of_clubs", "12_of_diamonds", "12_of_hearts", "12_of_spades",
        "13_of_clubs", "13_of_diamonds", "13_of_hearts", "13_of_spades"

    ]
    
    func drawCard() -> String {
        return cardImages[Int(arc4random_uniform(UInt32(cardImages.count - 1)))]
    }
    
    func updateScores(leftCard: String, rightCard: String) {
        let leftValue = cardValue(cardName: leftCard)
        let rightValue = cardValue(cardName: rightCard)
        
        if leftValue > rightValue {
            playerLeftScore += 1
        } else if rightValue > leftValue {
            aiRightScore += 1
        }
    }
    
    func getScores() -> (left: Int, right: Int) {
        return (playerLeftScore, aiRightScore)
    }
    
    private func cardValue(cardName: String) -> Int {
        let components = cardName.split(separator: "_")
        return Int(components[0]) ?? 0
    }
}
