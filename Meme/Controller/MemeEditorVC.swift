//
//  ViewController.swift
//  Meme
//
//  Created by Madian on 2/3/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UITextFieldDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Outlets
    @IBOutlet weak var PickedImageView: UIImageView!
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextField: UITextField!
    @IBOutlet weak var CameraBarButton: UIBarButtonItem!
    @IBOutlet weak var TobToolbar: UIToolbar!
    @IBOutlet weak var BottomToolbar: UIToolbar!
    
    var imagePicker: UIImagePickerController!
    
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3
        ]
    

    func setUpTextFields(for textField: UITextField) {
        //Setup TextField
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Bottom and Top TextField
        setUpTextFields(for: TopTextField)
        setUpTextFields(for: BottomTextField)
        
        //Setting Up ImagePicker
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //Disable Camera Button if it is not avaliable
        CameraBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        //Subscribe to Keyboard Notification
        subscribToKeyboardNotificaion()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribToKeyboardNotificaion()
    }
    
    // MARK: - Actions
    
    @IBAction func AlbumBtn_Tapped(sender: UIBarButtonItem){
        pickIMageFrom(source: .photoLibrary)
    }
    
    @IBAction func CameraButton_Tapped(sender: UIBarButtonItem){
        pickIMageFrom(source: .camera)
    }
    
    @IBAction func CancelButton_Tapped(sender: UIBarButtonItem){
        GetViewsFirstState()
    }
    @IBAction func ShareButton_Tapped(sender: UIBarButtonItem) {
        savePhoto()
    }
    
    // MARK: Private Methods
    
    func pickIMageFrom(source: UIImagePickerController.SourceType){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = source
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func savePhoto(){
        let memedImage = generateMemedImage()
        
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
       
        activityController.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                let generatedMeme = Meme(topText: self.TopTextField.text!, bottomText: self.BottomTextField.text!, originalImage: self.PickedImageView.image!, memedImage: memedImage)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.mems.append(generatedMeme)
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        self.present(activityController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage{
        //Hide Toolbar and NavBar
        TobToolbar.isHidden = true
        BottomToolbar.isHidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show tool bar and navbar
        TobToolbar.isHidden = false
        BottomToolbar.isHidden = false
        
        return memedImage
    }
    
    
    func GetViewsFirstState(){
        PickedImageView.image = nil
        TopTextField.text = "Top"
        BottomTextField.text = "Bottom"
    }
    
    //MARK: UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            PickedImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
   
    @objc func keyboardWillShow(_ notification: Notification) {
        if BottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardheight(notification)
            PickedImageView.frame.origin.y = self.view.frame.origin.y
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
        PickedImageView.frame.origin.y = self.view.frame.origin.y
    }
    
    func subscribToKeyboardNotificaion(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribToKeyboardNotificaion(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    func getKeyboardheight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        if let keyBoardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            return keyBoardSize.cgRectValue.height
        }else{
            return 0
        }
    }
   
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UINavigationController {
            if let sentMemesVs =  destinationVC.topViewController as? SavedMememsTableVC{
                sentMemesVs.addMemeToList(meme: generatedMeme!)
            }
        }
    }
    
    @IBAction func unwindsegueFromSavedMemesVC(unwindSegue: UIStoryboardSegue) {
        GetViewsFirstState()
    }
     
     */
    
}

