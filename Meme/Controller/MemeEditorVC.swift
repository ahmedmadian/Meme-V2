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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Setting Up ImagePicker
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //Disable Camera Button if it is not avaliable
        CameraBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        TopTextField.delegate = self
        BottomTextField.delegate = self
        subscribToKeyboardNotificaion()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribToKeyboardNotificaion()
    }
    
    // MARK: - Actions
    
    @IBAction func AlbumBtn_Tapped(sender: UIBarButtonItem){
        pickImageFromAlbum()
    }
    
    @IBAction func CameraButton_Tapped(sender: UIBarButtonItem){
        pickImageWithCamera()
    }
    @IBAction func CancelButton_Tapped(sender: UIBarButtonItem){
        GetViewsFirstState()
    }
    @IBAction func ShareButton_Tapped(sender: UIBarButtonItem) {
        savePhoto()
    }
    
    // MARK: Private Methods
    
    func pickImageFromAlbum() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func pickImageWithCamera(){
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func savePhoto(){
        let memedImage = generateMemedImage()
        let meme = Meme(topText: TopTextField.text!, bottomText: BottomTextField.text!, originalImage: PickedImageView.image!, memedImage: memedImage)
        
        let activityController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
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
        TopTextField.text = ""
        BottomTextField.text = ""
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
        view.frame.origin.y = -getKeyboardheight(notification)
        PickedImageView.frame.origin.y = self.view.frame.origin.y
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
    
    
    
    
}

