//
//  PrayerRequestViewController.swift
//  iPray
//
//  Created by Amy Lin on 22/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import UIKit

class PrayerRequestViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var prayerRequestContentTextField: UITextField!
    @IBOutlet weak var prayerRequesterTextField: UITextField!
    @IBOutlet weak var prayerRequestDatePicker: UIDatePicker!
    @IBOutlet weak var prayerReqeustAnsweredSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!

    var prayerRequest: PrayerRequestItem = PrayerRequestItem()
    var prayerRequestUuid: String = ""
    
    let kPrayerRequestContentTextFieldTag = 1
    let kPrayerRequesterTextFieldTag = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.enabled = false
        saveButton.backgroundColor = UIColor.lightGrayColor()
        
        let item = DataManager.sharedInstance.selectOneItem(prayerRequestUuid)
        self.prayerRequest.prayerRequester = item.prayerRequester
        self.prayerRequest.prayerRequestName = item.prayerRequestName
        self.prayerRequest.prayerRequestTime = item.prayerRequestTime
        self.prayerRequest.prayerRequestAnswered = item.prayerRequestAnswered
        self.prayerRequest.prayerRequestId = item.prayerRequestId
        
        prayerRequestContentTextField.text = prayerRequest.prayerRequestName
        prayerRequesterTextField.text = prayerRequest.prayerRequester
        prayerRequestDatePicker.date = prayerRequest.prayerRequestTime
        prayerReqeustAnsweredSwitch.on = prayerRequest.prayerRequestAnswered
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).stringByReplacingCharactersInRange(range, withString: string) as String

        let shouldEnable = checkIfBothTextFieldsEmpty(newString, textField: textField)
    
        enableOrDisableButton(shouldEnable)
        return true
    }
    
    func checkIfBothTextFieldsEmpty(newString: String, textField: UITextField) -> Bool {
        if (newString == "") {
            return false
        }
        if (textField.tag == kPrayerRequestContentTextFieldTag) {
            return (prayerRequesterTextField.text != "")
        }else if (textField.tag == kPrayerRequesterTextFieldTag){
            return (prayerRequestContentTextField.text != "")
        }
        return false
    }
    
    func enableOrDisableButton(shouldEnable: Bool) {
        self.saveButton.backgroundColor = shouldEnable ? UIColor.darkGrayColor() : UIColor.lightGrayColor()
        self.saveButton.enabled = shouldEnable
    }
    
    func enableOrDisableButtonForNonTextField() {
        let shouldEnable =  (self.prayerRequestContentTextField.text != "") && (self.prayerRequesterTextField.text != "")
        enableOrDisableButton(shouldEnable)
    }

    @IBAction func saveButtonTouchUpInside(sender: UIButton) {
        prayerRequest.prayerRequestName = prayerRequestContentTextField.text!
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
        enableOrDisableButtonForNonTextField()
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        enableOrDisableButtonForNonTextField()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
