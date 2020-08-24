//
//  MainVC.swift
//  Boiler Key
//
//  Created by Jeremy Gleeson on 7/10/20.
//  Copyright © 2020 Jeremy Gleeson. All rights reserved.
//

import Cocoa
import LocalAuthentication

class MainVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: ViewController.updateMain, object: nil)

        setupButton.target = self
        if isSetup() {
            setupIndicator.image = succStat
            setupButton.title = "Reset"
            setupButton.action = #selector(self.reset)
        }
        else {
            setupIndicator.image = failStat
            setupButton.title = "Setup"
            setupButton.action = #selector(self.setup)
        }
    }
    
    
    
    func confirmDialog(question: String, text: String, button: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: button)
        alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
    }

    //let answer = dialogOKCancel(question: "Ok?", text: "Choose your answer.")
    
    @IBOutlet weak var setupIndicator: NSButton!
    @IBOutlet weak var setupButton: NSButton!
    @IBAction func configButton(_ sender: Any) {
//        tryOpenConf()
        openConf()
    }
    
    @objc func tryOpenConf() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "edit its configuration"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.openConf()
                        return
                    } else {
                        let _ = self.confirmDialog(question: "Authentication failed", text: "Sorry!", button: "Ok")
                    }
                }
            }
        } else {
            let _ = confirmDialog(question: "Touch ID not available", text: "Your device is not configured for Touch ID.", button: "Ok")
        }
        // get password here
    }
    
    @objc func openConf() {
        performSegue(withIdentifier: "openConfig", sender: self)
    }
    
    @objc func reset() {
        if confirmDialog(question: "Reset?", text: "Are you sure you would like to reset your configuration?", button: "Reset") {
            resetConfig()
            NotificationCenter.default.post(name: ViewController.updateMain, object: nil, userInfo: nil)
            setup()
        }
    }
    
    @objc func setup() {
        performSegue(withIdentifier: "openSetup", sender: self)
    }
    
    @objc func dataChanged(_ notification: Notification) {
        setupIndicator.image = emptyStat
        if isSetup() {
            setupIndicator.image = succStat
            setupButton.title = "Reset"
            setupButton.action = #selector(self.reset)
        }
        else {
            setupIndicator.image = failStat
            setupButton.title = "Setup"
            setupButton.action = #selector(self.setup)
        }
    }
}
