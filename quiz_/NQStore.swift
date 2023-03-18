//
//  NQStore.swift
//  quiz_
//
//  Created by Qihui Jian on 11/27/22.
//

import Foundation
import UIKit

class NQStore{
    
    
    
    static var allNQs : [NQ] = {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(NQStore.self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
        do {
        let data = try Data(contentsOf: itemArchiveURL)
        let unarchiver = PropertyListDecoder()
        let items = try unarchiver.decode([NQ].self, from: data)
            print(items)
            return items
    } catch {
        print("Error reading in saved items: \(error)")
              return [];
    }
        }()
    
    static let itemArchiveURL: URL = {
     let documentsDirectories =
     FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentDirectory = documentsDirectories.first!
     return documentDirectory.appendingPathComponent("NQs.plist")
    }()
    
    @objc static func saveChanges() -> Bool {
        print(itemArchiveURL)
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allNQs)
            try data.write(to: itemArchiveURL, options: .atomic)
            print("Saved all of the NQs")
            return true
        }catch let encodingError{
            print("Error encoding allNQs: \(encodingError)")
            return false
        }
    }

    
    static func moveNQ(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex {
        return
        }
        let movedNQ = allNQs[fromIndex]
        // Remove item from array
        allNQs.remove(at: fromIndex)
        // Insert item in array at new location
        allNQs.insert(movedNQ, at: toIndex)
        movedFlag.sharedInstance.flag += 1
        Items.sharedInstance.noIncorrect = 0
        Items.sharedInstance.noCorrect = 0
    }
    
    
    static func deleteNQ(index: Int){
        allNQs.remove(at: index)
        movedFlag.sharedInstance.flag += 1
        Items.sharedInstance.noIncorrect = 0
        Items.sharedInstance.noCorrect = 0
        }
    
    static func addNQ(nq:NQ){
        allNQs.append(nq)
        movedFlag.sharedInstance.flag += 1
        Items.sharedInstance.noIncorrect = 0
        Items.sharedInstance.noCorrect = 0
    }
    
    
    
    


}
