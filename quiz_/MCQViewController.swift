//
//  ViewController.swift
//  quiz_
//
//  Created by Qihui Jian on 11/23/22.
//

import UIKit

class MCQViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var current_index : Int = 0;
    
    let questions: [String] =
    ["Which is my name?","Which fruit I like most?","Where do I come from?"];
    
    let choices: [[String]] = [
        ["A: Betty","B:Yvette","C:Bella"],
        ["A:Apple","B:Banana","C:Watermelon"],
        ["A:China","B:Japan","C:United State"]
    ];
    
    let correctAnswer:[String] = ["B:Yvette","C:Watermelon","A:China"];
    
     
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[current_index][row];
    }
    
    var selectedAanswer : String = "";
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAanswer = choices[current_index][row];
    }
    
    
    @IBOutlet weak var FinishLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var AnswerPickerView: UIPickerView!
    
    @IBOutlet weak var submitButton : UIButton!
    @IBAction func SubmitButton(_ sender: UIButton) {
        if  current_index == 2 {
            FinishLabel.isHidden = false
        };
        
        if  selectedAanswer == correctAnswer[current_index]{
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
        if ResultLabel.isHidden == false{
            submitButton.isEnabled = false
        }
        
    }
    
    @IBOutlet weak var nextButton : UIButton!
    @IBAction func NextButton(_ sender: UIButton) {
        if current_index < 2 {
            current_index += 1
            viewDidLoad()
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnswerPickerView.delegate = self
        AnswerPickerView.dataSource = self
        QuestionLabel.text = questions[current_index]
        ResultLabel.isHidden = true
        FinishLabel.isHidden = true
        if current_index == 2 {
            nextButton.isEnabled = false;
        }
        submitButton.isEnabled = true
        // Do any additional setup after loading the view.
        
    }
    //if edit reset page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if movedFlag.sharedInstance.MCQFlag != movedFlag.sharedInstance.flag{
            current_index = 0
            movedFlag.sharedInstance.MCQFlag = movedFlag.sharedInstance.flag
            print(NQStore.allNQs.count)
            viewDidLoad()
        }
    }
    
}

