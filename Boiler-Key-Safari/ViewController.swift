//
//  ViewController.swift
//  Boiler-Key-Safari
//
//  Created by Jeremy Gleeson on 7/14/20.
//  Copyright © 2020 Jeremy Gleeson. All rights reserved.
//

import Cocoa
import SafariServices.SFSafariApplication

class ViewController: NSViewController {

    @IBOutlet var appNameLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = "Boiler-Key-Safari";
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "JG.Boiler-Key-Safari-Extension") { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.

            }
        }
    }

}
