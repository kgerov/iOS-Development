//
//  ResultViewController.swift
//  Roshambo
//
//  Created by Konstantin Gerov on 6/26/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var userChoice: Roshambo?
    var computerChoice: Roshambo?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    
    enum gameOutcome: Int { case UserWon = 0, ComputerWon, Tie}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userChoice == computerChoice {
            displayGameOutcome(gameOutcome.Tie, winner: nil)
            return
        }
        
        switch userChoice! {
        case Roshambo.Rock:
            if computerChoice == Roshambo.Scissor {
                displayGameOutcome(.UserWon, winner: .Rock)
            } else if computerChoice == Roshambo.Paper {
                displayGameOutcome(.ComputerWon, winner: .Paper)
            }
        case Roshambo.Paper:
            if computerChoice == Roshambo.Scissor {
                displayGameOutcome(.ComputerWon, winner: .Scissor)
            } else if computerChoice == Roshambo.Rock {
                displayGameOutcome(.UserWon, winner: .Paper)
            }
        case Roshambo.Scissor:
            if computerChoice == Roshambo.Paper {
                displayGameOutcome(.UserWon, winner: .Scissor)
            } else if computerChoice == Roshambo.Rock {
                displayGameOutcome(.ComputerWon, winner: .Rock)
            }
        }
    }
    
    private func displayGameOutcome(outcome: gameOutcome, winner: Roshambo?) {
        var resultText = ""
        
        switch winner {
        case .Some(Roshambo.Rock):
            resultText = "Rock crushes scissors. "
            resultImage.image = UIImage(named: "RockCrushesScissors")
        case .Some(Roshambo.Paper):
            resultText = "Paper covers rock. "
            resultImage.image = UIImage(named: "PaperCoversRock")
        case .Some(Roshambo.Scissor):
            resultText = "Scissors cut paper. "
            resultImage.image = UIImage(named: "ScissorsCutPaper")
        default:
            resultImage.image = UIImage(named: "Tie")
        }
        
        switch outcome {
        case gameOutcome.ComputerWon:
            resultText += "You lose!"
        case gameOutcome.UserWon:
            resultText += "You win!"
        case gameOutcome.Tie:
            resultText += "It's a tie!"
        }
        
        self.resultLabel.text = resultText;
    }
    
    @IBAction func closeView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}