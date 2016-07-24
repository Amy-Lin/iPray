//
//  PrayerRequestViewController.swift
//  iPray
//
//  Created by Amy Lin on 22/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import UIKit

class PrayerRequestViewController: UIViewController, UITextFieldDelegate {

    let kPrayerRequesterTextFieldTag = 1
    let kPrayerRequestContentTextFieldTag = 2
    
    @IBOutlet weak var prayerRequesterTextField: UITextField!
    @IBOutlet weak var prayerRequestContentTextField: UITextField!
    @IBOutlet weak var prayerRequestDatePicker: UIDatePicker!
    @IBOutlet weak var prayerReqeustAnsweredSwitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var prayerRequest: PrayerRequestItem = PrayerRequestItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.enabled = false
        saveButton.backgroundColor = UIColor.lightGrayColor()
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
    
        self.enableOrDisableButton()

        return true
    }
    
    func enableOrDisableButton() {
        let shouldEnabble = prayerRequest.prayerRequester != "" && prayerRequest.prayerRequestName != ""
        self.saveButton.backgroundColor = shouldEnabble ? UIColor.darkGrayColor() : UIColor.lightGrayColor()
        self.saveButton.enabled = shouldEnabble
    }

    @IBAction func saveButtonTouchUpInside(sender: UIButton) {
        DataManager.sharedInstance.PrayerRequestItems.append(prayerRequest)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func dateValueEditingEnd(sender: AnyObject) {
        prayerRequest.prayerRequestTime = sender.date
    }
    
    @IBAction func answeredSwitchEditingEnd(sender: AnyObject) {
        prayerRequest.prayerRequestAnswered = sender.on
    }

}
