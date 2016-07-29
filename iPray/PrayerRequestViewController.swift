//
//  PrayerRequestViewController.swift
//  iPray
//
//  Created by Amy Lin on 22/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import UIKit

class PrayerRequestViewController: UIViewController, UITextFieldDelegate {

    let kPrayerRequestContentTextFieldTag = 1
    let kPrayerRequesterTextFieldTag = 2
    
    @IBOutlet weak var prayerRequestContentTextField: UITextField!
    @IBOutlet weak var prayerRequesterTextField: UITextField!
    @IBOutlet weak var prayerRequestDatePicker: UIDatePicker!
    @IBOutlet weak var prayerReqeustAnsweredSwitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIButton!

    var prayerRequest: PrayerRequestItem = PrayerRequestItem()
    var prayerRequestUuid: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.enabled = false
        saveButton.backgroundColor = UIColor.lightGrayColor()
        
        self.prayerRequest = DataManager.sharedInstance.selectOneItem(prayerRequestUuid)
        self.prayerRequesterTextField.text = self.prayerRequest.prayerRequester
        self.prayerRequestContentTextField.text = self.prayerRequest.prayerRequestName
        self.prayerRequestDatePicker.date = self.prayerRequest.prayerRequestTime
        self.prayerReqeustAnsweredSwitch.on = self.prayerRequest.prayerRequestAnswered

    }
   
    func textFieldDidBeginEditing(textField: UITextField) {

    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        
        let newString = (userEnteredString! as NSString).stringByReplacingCharactersInRange(range, withString: string) as String

        switch textField.tag {
        case kPrayerRequesterTextFieldTag:
            prayerRequest.prayerRequester = newString
        case kPrayerRequestContentTextFieldTag:
            prayerRequest.prayerRequestName = newString
        default:
            NSLog("Error: Unknown tag!");
        }
    
        
        enableOrDisableButton()

        return true
    }
    
    func enableOrDisableButton() {
        let shouldEnable = prayerRequest.prayerRequester != "" && prayerRequest.prayerRequestName != ""
        self.saveButton.backgroundColor = shouldEnable ? UIColor.darkGrayColor() : UIColor.lightGrayColor()
        self.saveButton.enabled = shouldEnable
    }

    @IBAction func saveButtonTouchUpInside(sender: UIButton) {
        prayerRequest.prayerRequestTime = prayerRequestDatePicker.date
        prayerRequest.prayerRequestAnswered = prayerReqeustAnsweredSwitch.on
        if ( prayerRequestUuid == "") {
            prayerRequest.prayerRequestId = NSUUID().UUIDString
            DataManager.sharedInstance.prayerRequestItems.append(prayerRequest)
        } else {
            prayerRequest.prayerRequestId = prayerRequestUuid
            DataManager.sharedInstance.updateOneItem(prayerRequest)
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func dateValueChanged(sender: AnyObject) {
        enableOrDisableButton()
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        enableOrDisableButton()
    }

}
