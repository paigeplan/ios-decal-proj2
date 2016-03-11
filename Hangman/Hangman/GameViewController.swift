//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var hangmanImageView: UIImageView!
    var phrase = ""
    @IBOutlet weak var guessedLettersLabel: UILabel!
    @IBOutlet weak var currentGuessLabel: UILabel!
    var guessString = ""
    @IBOutlet weak var wordToGuessLabel: UILabel!
    @IBOutlet weak var exitGameButton: UIBarButtonItem!
    
    var correctGuesses: [Character] = []
    var incorrectGuesses: [String] = []
    
    var wrongGuessCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        makeWordToGuessLabel()
        print(phrase)
    }
    
    func makeWordToGuessLabel() {
        wordToGuessLabel.text = " "
        
        
        for char in phrase.characters {
            if char == " " {
               wordToGuessLabel.text! += "   "
            }
            else if correctGuesses.contains(char) {
                wordToGuessLabel.text! += String(char) + " "
            }
            else {
                wordToGuessLabel.text! += "_  "
            }
            
        }
    }
    
    @IBAction func guessedButtonClicked(sender: UIButton) {
        if phrase.containsString(guessString) {
            correctGuesses.append(Character(guessString))
            makeWordToGuessLabel()
        }
        else {
            if !incorrectGuesses.contains(guessString) {
                incorrectGuesses.append(guessString)
                if incorrectGuesses.count > 1 {
                    guessedLettersLabel.text! += ", " + guessString
                }
                else {
                    guessedLettersLabel.text! += " " + guessString
                }
                wrongGuessCount += 1
                updateHangmanImage()
            }
        }
    }
    
    func updateHangmanImage() {
        if wrongGuessCount + 1 > 7{
            print("Game Over!")
        }
        else {
            let imageName = "hangman" + String(wrongGuessCount + 1)
            hangmanImageView.image = UIImage(named: imageName)
        }
        
    }

    @IBAction func keyboardButtonPressed(sender: UIButton) {
        if let char = sender.titleLabel!.text {
            guessString = char
            currentGuessLabel.text = "Guess: " + char
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
