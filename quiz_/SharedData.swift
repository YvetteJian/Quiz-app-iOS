//
//  SharedData.swift
//  quiz_
//
//  Created by Qihui Jian on 11/26/22.
//

class Items {
    static let sharedInstance = Items();
    var noCorrect :Int = 0;
    var noIncorrect : Int = 0;
}
//detect whether NQ data edit
class movedFlag{
    static let sharedInstance = movedFlag();
    var flag :Int = 0;
    var MCQFlag = 0;
    var FIBQSFlag = 0;
}
