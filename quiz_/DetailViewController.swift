//
//  DetailViewController.swift
//  quiz_
//
//  Created by Qihui Jian on 11/29/22.
//

import Foundation
import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var newFlag = 0
    var savedFlag = 0
    
    @IBOutlet var questionTextField: UITextField!
    
  
    @IBOutlet var answerTextField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil,
         message: nil,
        preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
         
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
         let photoLibraryAction
         = UIAlertAction(title: "Photo Library", style: .default) { _ in
             let imagePicker = self.imagePicker(for: .photoLibrary)
             imagePicker.modalPresentationStyle = .popover
             imagePicker.popoverPresentationController?.barButtonItem = sender
             self.present(imagePicker, animated: true, completion: nil)
         }
         alertController.addAction(photoLibraryAction)

         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    var nq: NQ!
    
    //formatting date
    let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
    }()
    
    let numberFormatter:  NumberFormatter = {
        let formatter  = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
           return formatter
       }()
    
    //if it is creating then no datelabel
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        if newFlag == 0{ questionTextField.text = nq.question
            answerTextField.text = String(nq.answer)
            dateLabel.text = dateFormatter.string(from: nq.date)
            imageView.image = imageStore.image(forKey: nq.itemKey)
        }
        else{
            dateLabel.text = ""
        }
    }
    
    //save the edited data
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)

           if newFlag == 0{
               nq.question = questionTextField.text ?? ""
               if let answer = answerTextField.text, let value = numberFormatter.number(from: answer){
                   nq.answer = value.floatValue
               }else{
                   nq.answer = 0
               }
           }else{
               let newQ = questionTextField.text ?? ""
               let newA: Float
               if let answer = answerTextField.text, let value = numberFormatter.number(from: answer){
                   newA = value.floatValue
               }else{
                   newA = 0
               }

               let newNQ = NQ(question:newQ, answer:newA, date: Date())
               nq = newNQ
               //if there is already nq, which means that the new nq has already been created in nqStore with photo
               if savedFlag == 0{
                   NQStore.addNQ(nq: newNQ)
                   print(NQStore.allNQs)
               }
           }
            imageView.image = imageStore.image(forKey: nq.itemKey)
        
        
       }
    
    //Dismissing the keyboard upon tapping Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType)
     -> UIImagePickerController {
     let imagePicker = UIImagePickerController()
     imagePicker.sourceType = sourceType
     imagePicker.delegate = self
     return imagePicker
         
    }
    
    var imageStore: ImageStore!
    
  
    func imagePickerController(_ picker: UIImagePickerController,
     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
     // Get picked image from info dictionary
     let image = info[.originalImage] as! UIImage
        
        //if there is no nq , which means that it is creating new question, if user choose a photo , it wil be saved.
        if newFlag == 1{
            let newQ = questionTextField.text ?? ""
            let newA: Float
            if let answer = answerTextField.text, let value = numberFormatter.number(from: answer){
                newA = value.floatValue
            }else{
                newA = 0
            }
            let newNQ = NQ(question:newQ, answer:newA, date: Date())
            nq = newNQ
            NQStore.addNQ(nq: newNQ)
            savedFlag = 1
        }
     imageStore.setImage(image, forKey: nq.itemKey);
        //refresh all pages
     movedFlag.sharedInstance.flag += 1
     // Put that image on the screen in the image view
     imageView.image = image
     // Take image picker off the screen - you must call this dismiss method
     dismiss(animated: true, completion: nil)
    }
}
