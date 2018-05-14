//
//  ViewController.swift
//  SingleDigitTextFields
//
//  Created by Zaim Ramlan on 15/05/2018.
//  Copyright © 2018 ZaimRamlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupViewTapToDismiss()
    }
    
    // MARK: TextFields
    
    @IBOutlet var firstTF: SecureCodeTextField!
    @IBOutlet var secondTF: SecureCodeTextField!
    @IBOutlet var thirdTF: SecureCodeTextField!
    @IBOutlet var fourthTF: SecureCodeTextField!
    var textFields: [SecureCodeTextField] = []
    func setupTextFields() {
        textFields = [firstTF, secondTF, thirdTF, fourthTF]
        
        let minIndex = 0
        let maxIndex = textFields.count - 1
        
        for index in minIndex...maxIndex {
            if index != minIndex {
                textFields[index].previousTextField = textFields[index - 1]
            }
            
            if index != maxIndex {
                textFields[index].nextTextField = textFields[index + 1]
            }
            
            textFields[index].moveToNextFromCurrentTextFieldCompletion = moveToNextFromCurrentTextFieldCompletion(_:)
        }
    }
    
    func isFilledAllTextFields() -> Bool {
        for textField in textFields {
            if textField.text == nil || textField.text?.count != 1 {
                return false
            }
        }
        
        return true
    }
    
    // MARK: Keyboard Dismiss
    
    func setupViewTapToDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: SecureCodeTextField Completions

extension ViewController {
    func moveToNextFromCurrentTextFieldCompletion(_ textField: UITextField) {
        if textField.isEqual(thirdTF) && isFilledAllTextFields() {
            view.endEditing(true)
        }
    }
}
