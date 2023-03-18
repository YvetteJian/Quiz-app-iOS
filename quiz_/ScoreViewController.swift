//
//  ScoreViewController.swift
//  quiz_
//
//  Created by Qihui Jian on 11/25/22.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController{
    
    
    @IBOutlet weak var noCorrectLabel: UILabel!
    @IBOutlet weak var noIncorrectLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        noCorrectLabel.text = String(Items.sharedInstance.noCorrect)
        noIncorrectLabel.text = String(Items.sharedInstance.noIncorrect)
        if Items.sharedInstance.noCorrect > Items.sharedInstance.noIncorrect{
            view.backgroundColor = .green
        }else if Items.sharedInstance.noCorrect < Items.sharedInstance.noIncorrect{
            view.backgroundColor = .red
            
        }else{
            view.backgroundColor = .white
        };
        //after editing set default score
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.backgroundColor = .white
        viewWillAppear(false)
    }
    
}
