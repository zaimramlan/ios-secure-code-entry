# Secure Code Entry

[![IDE](https://img.shields.io/badge/Xcode-9-blue.svg)](https://developer.apple.com/xcode/)
[![Platform](https://img.shields.io/badge/platform-iOS%2011-green.svg)](https://developer.apple.com/ios/)
[![Language](https://img.shields.io/badge/swift-4-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

An iOS app that imitates Apple's passcode entry to showcase the a single digit UITextField custom class; `SecureCodeTextField`.

<p align="center"><img src="https://github.com/zaimramlan/ios-secure-code-entry/blob/develop/Demo.gif" alt="demo" align="center" width="auto" height="500"/></p>

## Features
1. Only allow a single digit per textfield
1. Disables UITextField action menu commands to prevent copy/paste
1. Cursor auto moves to previous/next textfield after a single character text entry
1. Works with arbitrary amount of textfields on screen

## Usages
1. Copy and paste <a href="https://github.com/zaimramlan/ios-secure-code-entry/blob/develop/SecureCodeEntry/Modules/Main/SecureCodeTextField.swift" target="_blank">SecureCodeTextField.swift</a> into your project
1. Set the custom class of the `UITextField`s on your storyboard file to `SecureCodeTextField`
1. Point the current `SecureCodeTextField`'s `previousTextField` and `nextTextField` to the respective text fields. For example:
    ```swift
    let firstTF = SecureCodeTextField()
    let secondTF = SecureCodeTextField()
    let thirdTF = SecureCodeTextField()
    
    secondTF.previousTextField = firstTF
    secondTF.nextTextField = thirdTF 
    ```
1. Your textfields should now jump to previous/next textfields as desired!

## More Examples?
Look into the <a href="https://github.com/zaimramlan/ios-secure-code-entry/blob/develop/SecureCodeEntry/Modules/Main/ViewController.swift" target="_blank">ViewController.swift</a> file and you should be able to understand in the scenario where we have 4 `SecureCodeTextFields`s