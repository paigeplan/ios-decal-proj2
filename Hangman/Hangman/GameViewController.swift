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
    var phraseCharArray: [Character] = []
    var wordSoFar: String = ""
    var userHasWonGame: Bool = false
    
    
    var wrongGuessCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        
        // reset properties if user starts game over
        hangmanImageView.image = UIImage(named: "hangman1")
        guessString = ""
        correctGuesses = []
        incorrectGuesses = []
        wrongGuessCount = 1
        currentGuessLabel.text = "Guess:"
        guessedLettersLabel.text = "Incorrect Guesses:"
        userHasWonGame = false
        phraseCharArray = makeCharArrayWithoutWhitespace(forString: phrase)
    
        makeWordToGuessLabel()
        print(phrase)
    }
    
    func makeCharArrayWithoutWhitespace(forString string: String) -> [Character] {
        var charArrayWithoutWhitespace: [Character] = []
        for char in string.characters {
            if char != " " {
                charArrayWithoutWhitespace.append(char)
            }
        }
        return charArrayWithoutWhitespace
    }

    
    
    func makeWordToGuessLabel() {
        wordToGuessLabel.text = " "
        
        
        for char in phrase.characters {
            if char == " " {
                wordToGuessLabel.text! += "   "
                wordSoFar += " "
            }
            else if correctGuesses.contains(char) {
                wordToGuessLabel.text! += String(char) + " "
                wordSoFar += String(char)
            }
            else {
                wordToGuessLabel.text! += "-  "
            }
            
        }
        
        if userHasWon()  {
            popupIfUserWins()
        }
    }
    
    
    func userHasWon() -> Bool {
        
        for element in phraseCharArray {
            if !correctGuesses.contains(element) {
                return false
            }
        }
        userHasWonGame = true
        return true
    }
    
    
    
    @IBAction func guessedButtonClicked(sender: UIButton) {
        if wrongGuessCount >= 6 {
            popUpIfUserHasLost()
        }
        else if userHasWonGame {
            popupIfUserWins()
        }
        
        
        
        else if phrase.containsString(guessString) {
            correctGuesses.append(Character(guessString))
            makeWordToGuessLabel()
        }
        else {
            if !incorrectGuesses.contains(guessString) && guessString != "" {
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
    
    
    func popupIfUserWins() {
        let alertController = UIAlertController(title: "Congratulations", message:
            "You've won!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func popUpIfUserHasLost() {
        let alertController = UIAlertController(title: "You've run out of moves!", message:
            "Press 'Start Over' to start again.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func updateHangmanImage() {
        if wrongGuessCount + 1 > 7{
            print("game over")
    
        }
        else {
            let imageName = "hangman" + String(wrongGuessCount + 1)
            hangmanImageView.image = UIImage(named: imageName)
            if wrongGuessCount == 6 {
                popUpIfUserHasLost()
            }
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
    @IBAction func startOverButtonPressed(sender: UIBarButtonItem) {
        print("New Game")
        viewDidLoad()
        
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
