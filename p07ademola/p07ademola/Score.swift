//
//  Score.swift
//  p07ademola
//
//  Created by Lynda on 6/22/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit

class Score: NSObject {
    private var currentScore = 0
    private var multiplier = 1
    
    init(startScore: Int) {
        currentScore = startScore
    }
    
    func incrementScore(inc: Int) {
        currentScore += multiplier * inc
    }
    
    func decrementScore(dec: Int) {
        currentScore -= dec
    }
    
    func setMultiplier(multi: Int) {
        multiplier = multi
    }
    
    func getCurrentScore() -> Int {
        //print("score is: %d", currentScore)
        return currentScore
    }
    
    func resetScore() {
        currentScore = 0
    }
}
