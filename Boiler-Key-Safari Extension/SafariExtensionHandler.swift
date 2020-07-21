//
//  SafariExtensionHandler.swift
//  Boiler-Key-Safari Extension
//
//  Created by Jeremy Gleeson on 7/14/20.
//  Copyright © 2020 Jeremy Gleeson. All rights reserved.
//

import SafariServices
import SwiftOTP
import LocalAuthentication
import KeychainAccess

let keychain = Keychain(service: "boiler-key-safari", accessGroup: "JG.Boiler-Key-Safari")

func isSetup() -> Bool {
    if getCounter() == -1 {
        return false
    }
    if getSecret().isEmpty {
        return false
    }
    if getUsername().isEmpty {
        return false
    }
    if getPin() == -1 {
        return false
    }
    return true
}

func resetConfig() {
    do {
        try keychain.remove("counter")
    } catch let error {
        print("error: \(error)")
    }
    do {
        try keychain.remove("secret")
    } catch let error {
        print("error: \(error)")
    }
    do {
        try keychain.remove("username")
    } catch let error {
        print("error: \(error)")
    }
    do {
        try keychain.remove("pin")
    } catch let error {
        print("error: \(error)")
    }
}

func getCounter() -> Int {
    let count = try? keychain.get("counter")
    if let uCount = count {
        if let countNum = Int(uCount) {
            return countNum
        }
    }
    return -1
}

func setCounter(val: Int) {
    do {
        try keychain.set(String(val), key: "counter")
    }
    catch let error {
        print(error)
    }
}

func getSecret() -> String {
    let secret = try? keychain.get("secret")
    if let uSecret = secret {
        return uSecret
    }
    return ""
}

func getUsername() -> String {
    let username = try? keychain.get("username")
    if let uUser = username {
        return uUser
    }
    return ""
}

func getPin() -> Int {
    let pin = try? keychain.get("pin")
    if let uPin = pin {
        if let pinNum = Int(uPin) {
            return pinNum
        }
    }
    return -1
}



func genPass() -> String {
    let secret: String = getSecret()
    if secret.isEmpty {
        return ""
    }
    let counter: Int = getCounter()
    if counter == -1 {
        return ""
    }
    let counterFormat: UInt64 = UInt64(counter)
    let pin: Int = getPin()
    if pin == -1 {
        return ""
    }

    let data = secret.data(using: .utf8)!
    let hotp = HOTP(secret: data)
    let password = hotp?.generate(counter: counterFormat)
    print(password!)

    setCounter(val: counter + 1)


    return String(pin) + "," + password!
}

class SafariExtensionHandler: SFSafariExtensionHandler {

    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        if messageName == "getLogin" {
//            print("getting username: ", getUsername())
            if !getUsername().isEmpty {
                let pass = genPass()
//                print("getting pass: ", pass)
                if !pass.isEmpty {
                    page.dispatchMessageToScript(withName: "login", userInfo: ["username": getUsername(), "password": pass])
//                    print("sent message")
                }
            }
        }
//        page.getPropertiesWithCompletionHandler { properties in
//            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
//        }
    }

//    override func toolbarItemClicked(in window: SFSafariWindow) {
//        // This method will be called when your toolbar item is clicked.
//        NSLog("The extension's toolbar item was clicked")
//
//    }
//
//    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
//        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
//        validationHandler(true, "")
//    }

    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}


//import SafariServices
//
//class SafariExtensionHandler: SFSafariExtensionHandler {
//
//    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
//        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
//        page.getPropertiesWithCompletionHandler { properties in
//            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
//        }
//    }
//
//    override func toolbarItemClicked(in window: SFSafariWindow) {
//        // This method will be called when your toolbar item is clicked.
//        NSLog("The extension's toolbar item was clicked")
//    }
//
//    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
//        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
//        validationHandler(true, "")
//    }
//
//    override func popoverViewController() -> SFSafariExtensionViewController {
//        return SafariExtensionViewController.shared
//    }
//
//}
