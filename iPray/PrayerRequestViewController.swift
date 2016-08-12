//
//  PrayerRequestViewController.swift
//  iPray
//
//  Created by Amy Lin on 22/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import UIKit

class PrayerRequestViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var prayerRequestContentTextView: UITextView!
    @IBOutlet weak var prayerRequesterTextField: UITextField!
    @IBOutlet weak var prayerRequestDatePicker: UIDatePicker!
    @IBOutlet weak var prayerReqeustAnsweredSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    var prayerRequest: PrayerRequestItem = PrayerRequestItem()
    var prayerRequestUuid: String = ""
    let PLACEHOLDER_TEXT = "Here goes what you want to pray."
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        formatTextViewBorder(prayerRequestContentTextView)
        prayerRequestContentTextView.delegate = self
        
        enableOrDisableButton(false)
        
        let item = DataManager.sharedInstance.selectOneItem(prayerRequestUuid)
        self.prayerRequest.prayerRequester = item.prayerRequester
        self.prayerRequest.prayerRequestName = item.prayerRequestName
        self.prayerRequest.prayerRequestTime = item.prayerRequestTime
        self.prayerRequest.prayerRequestAnswered = item.prayerRequestAnswered
        self.prayerRequest.prayerRequestId = item.prayerRequestId
        
        if (prayerRequest.prayerRequestName == "") {
            applyTextViewPlaceholder(prayerRequestContentTextView)
        }else {
            prayerRequestContentTextView.text = prayerRequest.prayerRequestName
            prayerRequesterTextField.text = prayerRequest.prayerRequester
            prayerRequestDatePicker.date = prayerRequest.prayerRequestTime
            prayerReqeustAnsweredSwitch.on = prayerRequest.prayerRequestAnswered
        }
    }
    
    func formatTextViewBorder(textView: UITextView){
        prayerRequestContentTextView.layer.borderWidth = 1;
        prayerRequestContentTextView.layer.cornerRadius = 8;
        prayerRequestContentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    func applyTextViewPlaceholder(textView: UITextView){
        prayerRequestContentTextView.text = PLACEHOLDER_TEXT
        prayerRequestContentTextView.textColor = UIColor.lightGrayColor()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).stringByReplacingCharactersInRange(range, withString: string) as String
        
        if (newString != ""){
            enableOrDisableButton(true)
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
            enableOrDisableSaveButtonByCheckingText()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = PLACEHOLDER_TEXT
            textView.textColor = UIColor.lightGrayColor()
        }
        enableOrDisableSaveButtonByCheckingText()
    }
    
    func enableOrDisableButton(shouldEnable: Bool) {
        self.saveButton.backgroundColor = shouldEnable ? UIColor.darkGrayColor() : UIColor.lightGrayColor()
        self.saveButton.enabled = shouldEnable
    }
    
    func enableOrDisableSaveButtonByCheckingText(){
        let shouldEnable =  (self.prayerRequestContentTextView.text != "")
            && (self.prayerRequesterTextField.text != "")
            && (self.prayerRequestContentTextView.text != PLACEHOLDER_TEXT)
            && (self.prayerRequesterTextField.text != self.prayerRequesterTextField.placeholder)
        enableOrDisableButton(shouldEnable)
    }
    
    @IBAction func saveButtonTouchUpInside(sender: UIButton) {
        prayerRequest.prayerRequestName = prayerRequestContentTextView.text!.trim()
        prayerRequest.prayerRequester = prayerRequesterTextField.text!
        prayerRequest.prayerRequestTime = prayerRequestDatePicker.date
        prayerRequest.prayerRequestAnswered = prayerReqeustAnsweredSwitch.on
        if ( prayerRequestUuid == "") {
            prayerRequest.prayerRequestId = NSUUID().UUIDString
            DataManager.sharedInstance.appendOneItem(prayerRequest)
        } else {
            prayerRequest.prayerRequestId = prayerRequestUuid
            DataManager.sharedInstance.updateOneItem(prayerRequest)
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func dateValueChanged(sender: AnyObject) {
        enableOrDisableSaveButtonByCheckingText()
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        enableOrDisableSaveButtonByCheckingText()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
