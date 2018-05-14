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
        setupLabels()
        setupTextFields()
        setupViewTapToDismiss()
    }
    
    // MARK: Labels
    
    var setCodeText = "Set a 4 digit secure code."
    var codeStoredText = "Code has been stored."
    var verifyCodeText = "Enter your 4 digit secure code."
    var correctCodeText = "Code verified successfully!"
    var incorrectCodeText = "Code is incorrect, please try again."
    @IBOutlet var descriptionLabel: UILabel!
    func setupLabels() {
        descriptionLabel.text = setCodeText
    }
    
    // MARK: Buttons
    
    var isSettingCode = true
    @IBOutlet var setCodeButton: UIButton!
    @IBAction func setCodeButtonClicked(_ sender: Any) {
        isSettingCode = true
        descriptionLabel.text = setCodeText
        resetTextFields()
    }
    
    func storeCode() {
        var code = ""
        
        for textField in textFields {
            if let value = textField.text { code.append(value) }
        }
        
        UserDefaults.standard.set(code, forKey: "SecureCode")
    }

    @IBOutlet var verifyCodeButton: UIButton!
    @IBAction func verifyCodeButtonClicked(_ sender: Any) {
        let code = UserDefaults.standard.string(forKey: "SecureCode")
        let enteredCode = getEnteredCode()
        
        if let code = code, enteredCode.elementsEqual(code) {
            descriptionLabel.text = correctCodeText
        }
        else {
            descriptionLabel.text = incorrectCodeText
            resetTextFields()
        }
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

            textFields[index].textFieldDidEndEditingCompletion = textFieldDidEndEditingCompletion(_:)
            textFields[index].moveToNextFromCurrentTextFieldCompletion = moveToNextFromCurrentTextFieldCompletion(_:)
        }
    }
    
    func resetTextFields() {
        for textField in textFields {
            textField.text = ""
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
    
    func getEnteredCode() -> String {
        var enteredCode = ""
        
        for textField in textFields {
            if let code = textField.text { enteredCode.append(code) }
        }
        
        return enteredCode
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
    func textFieldDidEndEditingCompletion(_ textField: UITextField) {
        if isSettingCode && isFilledAllTextFields() {
            storeCode()
            showAlert(message: codeStoredText)
            isSettingCode = false
        }
    }
    
    func moveToNextFromCurrentTextFieldCompletion(_ textField: UITextField) {
        if textField.isEqual(thirdTF) && isFilledAllTextFields() {
            view.endEditing(true)
        }
    }
}

// MARK: Helpers

private extension ViewController {
    func showAlert(message: String) {
        let action = UIAlertAction.init(title: "OK", style: .default) { [unowned self] (_) in
            self.resetTextFields()
            self.descriptionLabel.text = self.verifyCodeText
        }
        
        let alert = UIAlertController.init(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
