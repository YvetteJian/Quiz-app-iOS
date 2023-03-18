//
//  NQViewController.swift
//  quiz_
//
//  Created by Qihui Jian on 11/27/22.
//

import Foundation
import UIKit

class NQEditViewController: UITableViewController , UITextFieldDelegate{
    
    var nqStore: NQStore!
    var imageStore: ImageStore!
    
   
    @IBAction func addNQ(_ sender: UIBarButtonItem) {
//        let newItem = itemStore.createItem()
//         // Figure out where that item is in the array
//         if let index = itemStore.allItems.firstIndex(of: newItem) {
//         let indexPath = IndexPath(row: index, section: 0)
//         // Insert this new row into the table
//         tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    //delete row
    override func tableView(_ tableView: UITableView,
     commit editingStyle: UITableViewCell.EditingStyle,
     forRowAt indexPath: IndexPath) {
     // If the table view is asking to commit a delete command...
     if editingStyle == .delete {
     
         // Remove the item's image from the image store
         imageStore.deleteImage(forKey: NQStore.allNQs[indexPath.row].itemKey)
         // Remove the item from the store
         NQStore.deleteNQ(index: indexPath.row)
     
         
     // Also remove that row from the table view with an animation
     tableView.deleteRows(at: [indexPath], with: .automatic)
     } }
    
    //reorder row
    override func tableView(_ tableView: UITableView,
     moveRowAt sourceIndexPath: IndexPath,
     to destinationIndexPath: IndexPath) {
     // Update the model
     NQStore.moveNQ(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    //set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NQStore.allNQs.count
    }
    
    //set content of rows
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NQViewCell", for: indexPath) as! NQCell
        
    let nq = NQStore.allNQs[indexPath.row]
        cell.QuestionLabel?.text = nq.question
        cell.AnswerLabel?.text = String(nq.answer)
    return cell
    }
    
    //srt row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showNQ"?:
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let nq = NQStore.allNQs[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.nq = nq
                detailViewController.imageStore = imageStore
            };
            
            //pass new flag to detailviewController
        case "addNQ"?:
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.newFlag = 1
            detailViewController.imageStore = imageStore
            
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     navigationItem.leftBarButtonItem = editButtonItem
    }
    
    //reload view
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    tableView.reloadData()
    }
    

    
    
}
