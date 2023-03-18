//
//  NumericalQuestions.swift
//  quiz_
//
//  Created by Qihui Jian on 11/27/22.
//

import Foundation
class NQ : Codable{
    var question : String
    var answer: Float
    var date: Date
    let itemKey: String
    init(question: String, answer: Float, date: Date) {
        self.question = question
        self.answer = answer
        self.date = date
        self.itemKey = UUID().uuidString
    }
    
    
}
