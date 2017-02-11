//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by HaYoung on 2017. 2. 4..
//  Copyright © 2017년 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    var photoName: String!
    var photoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photoName = photoName {
            imageView.image = UIImage(named: photoName)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ZoomedPhotoViewController {
            controller.photoName = self.photoName
        }
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        nameTextField.endEditing(true)
    }
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        adjustInsetForKeyboardShow(show: true, notification: notification)
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        adjustInsetForKeyboardShow(show: false, notification: notification)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickImage(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "zoomImage", sender: self)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
