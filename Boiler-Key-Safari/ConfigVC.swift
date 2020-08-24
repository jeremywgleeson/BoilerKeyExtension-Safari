//
//  ConfigVC.swift
//  Boiler Key
//
//  Created by Jeremy Gleeson on 7/10/20.
//  Copyright © 2020 Jeremy Gleeson. All rights reserved.
//

import Cocoa

class ConfigVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        updateUserTab()
        tabView.delegate = self
    }

    @IBOutlet weak var tabView: NSTabView!
    
    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var pinField: NSTextField!
    @IBAction func userUpdate(_ sender: Any) {
        if !usernameField.stringValue.isEmpty {
            setUsername(val: usernameField.stringValue)
        }
        if pinField.stringValue.count == 4 {
            if let pinNum = Int(pinField.stringValue) {
                setPin(val: pinNum)
            }
        }
        updateUserTab()
        NotificationCenter.default.post(name: ViewController.updateMain, object: nil, userInfo: nil)
    }
    
    @IBOutlet weak var secretField: NSSecureTextField!
    @IBOutlet weak var counterField: NSTextField!
    @IBAction func hotpUpdate(_ sender: Any) {
        setSecret(val: secretField.stringValue)
        if let newCount = Int(counterField.stringValue) {
            setCounter(val: newCount)
        }
        updateHOTPTab()
        NotificationCenter.default.post(name: ViewController.updateMain, object: nil, userInfo: nil)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(self)
    }
    
    func updateUserTab() {
        usernameField.stringValue = getUsername()
        if getPin() != -1 {
            pinField.stringValue = String(getPin())
        } else {
            pinField.stringValue = ""
        }
    }
    func updateHOTPTab() {
        secretField.stringValue = getSecret()
        if getCounter() != -1 {
            counterField.stringValue = String(getCounter())
        } else {
            counterField.stringValue = ""
        }
    }
    
}

extension ConfigVC: NSTabViewDelegate {
    func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        let identifier = tabViewItem?.identifier as? String
        if identifier == "user" {
            updateUserTab()
        } else {
            updateHOTPTab()
        }
    }
}
