//
//  FIBQSViewController.swift
//  quiz_
//
//  Created by Qihui Jian on 11/25/22.
//

import Foundation
import UIKit

class FIBQSViewController: UIViewController, UITextFieldDelegate{
    
    var currentIndex : Int = 0;
    
    var inputAnswer : Float!;
    
    var imageStore: ImageStore! = ImageStore()
    
    
    @IBOutlet weak var InputTextField:UITextField!
    
    //if no data , disable submit button
    @IBAction func InputChanged(_ sender: UITextField) {
        inputAnswer = Float(InputTextField.text ?? "")
        if InputTextField.text != nil{
            SubmitButton.isEnabled = true
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        InputTextField.resignFirstResponder()
    }
    
    
    //input validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
            let replacementTextHasDecimalSeparator = string.range(of: ".")
            let allowedCharacters = ".-+1234567890"
            let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharcterSet = CharacterSet(charactersIn: string)
            if existingTextHasDecimalSeparator != nil,
             replacementTextHasDecimalSeparator != nil {
                return false
             }
            else if (!allowedCharcterSet.isSuperset(of: typedCharcterSet)) {
                return false
            }
            else{
             return true
             }
           }
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var FinishLabel: UILabel!
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var nextButton : UIButton!
    
    @IBAction func NextButton(_ sender: UIButton) {
        if currentIndex < NQStore.allNQs.count - 1 {
            currentIndex += 1
            viewDidLoad()
        }
    }
    
    
    
    @IBOutlet weak var SubmitButton : UIButton!
    @IBAction func submitbutton(_ sender: UIButton) {
        if  currentIndex == NQStore.allNQs.count - 1 {
            FinishLabel.isHidden = false
        };
        
        if  inputAnswer == NQStore.allNQs[currentIndex].answer{
            ResultLabel.isHidden = false
            ResultLabel.text = "Correct"
            ResultLabel.textColor = .green
            Items.sharedInstance.noCorrect += 1
        }else{
            ResultLabel.isHidden = false
            ResultLabel.text = "Incorrect"
            ResultLabel.textColor = .red
            Items.sharedInstance.noIncorrect += 1
        }
        
        //can only submit once, if is submitted, disable the submit button
        if ResultLabel.isHidden == false{
            SubmitButton.isEnabled = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NQStore.allNQs.count == 0{
            ResultLabel.text = "No Questions!"
            nextButton.isHidden = true
            FinishLabel.isHidden = true
            SubmitButton.isHidden = true
            QuestionLabel.isHidden = true
            InputTextField.isHidden = true
            imageView.isHidden = true

        }else{
            print(NQStore.allNQs.count + 1)
            QuestionLabel.text = NQStore.allNQs[currentIndex].question
            imageView.isHidden = false
            nextButton.isHidden = false
            FinishLabel.isHidden = false
            SubmitButton.isHidden = false
            QuestionLabel.isHidden = false
            InputTextField.isHidden = false
            ResultLabel.isHidden = true
            FinishLabel.isHidden = true
            nextButton.isEnabled = true;
            // if comes to an end disable net button
            if currentIndex == NQStore.allNQs.count - 1 {
                nextButton.isEnabled = false;
            }
            InputTextField.placeholder = "Input Answer"
            InputTextField.text = ""
            SubmitButton.isEnabled = false
            QuestionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            InputTextField.textColor = .blue
            imageView.image = imageStore.image(forKey:NQStore.allNQs[currentIndex].itemKey)

            print ( currentIndex)
            print ( NQStore.allNQs.count)
        }
    };
    
    //if edit reset page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if movedFlag.sharedInstance.FIBQSFlag != movedFlag.sharedInstance.flag{
            currentIndex = 0
            movedFlag.sharedInstance.FIBQSFlag = movedFlag.sharedInstance.flag
            viewDidLoad()
        }
    
    }
    

}
