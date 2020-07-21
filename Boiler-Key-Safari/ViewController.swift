//
//  ViewController.swift
//  Boiler-Key-Safari
//
//  Created by Jeremy Gleeson on 7/14/20.
//  Copyright © 2020 Jeremy Gleeson. All rights reserved.
//

import Cocoa
import KeychainAccess

class ViewController: NSViewController {
    
    let keychain = Keychain(service: "boiler-key-safari", accessGroup: "JG.Boiler-Key-Safari")
    
    static let updateMain = Notification.Name("updateMain")
    
    let emptyStat = NSImage(named: "NSStatusNone")
    let succStat = NSImage(named: "NSStatusAvailable")
    let failStat = NSImage(named: "NSStatusUnavailable")
    
    func isSetup() -> Bool {
        if getCounter() == -1 {
            return false
        }
        if getSecret().isEmpty {
            return false
        }
//        print("secret: ", getSecret())
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

    func setSecret(val: String) {
        do {
            try keychain.set(val, key: "secret")
        }
        catch let error {
            print(error)
        }
    }
    
    func getUsername() -> String {
        let username = try? keychain.get("username")
        if let uUser = username {
            return uUser
        }
        return ""
    }

    func setUsername(val: String) {
        do {
            try keychain.set(val, key: "username")
        }
        catch let error {
            print(error)
        }
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

    func setPin(val: Int) {
        do {
            try keychain.set(String(val), key: "pin")
        }
        catch let error {
            print(error)
        }
    }
    /*
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
        setCounter(val: -1)
        setSecret(val: "")
        setUsername(val: "")
        setPin(val: -1)
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            userDefaults.removeObject(forKey: defaultsKeys.counter)
            userDefaults.removeObject(forKey: defaultsKeys.secret)
            userDefaults.removeObject(forKey: defaultsKeys.username)
            userDefaults.removeObject(forKey: defaultsKeys.pin)
            userDefaults.synchronize()
        }
    }

    func getCounter() -> Int {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            if let counterInt = Int(userDefaults.string(forKey: defaultsKeys.counter) ?? "-1") {
                return counterInt
            }
        }
        return -1

    }

    func setCounter(val: Int) {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            userDefaults.set(String(val), forKey: defaultsKeys.counter)
            userDefaults.synchronize()
        }
    }

    func getSecret() -> String {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            if let secretStr = userDefaults.string(forKey: defaultsKeys.secret) {
                return secretStr
            }
        }
        return ""
    }

    func setSecret(val: String) {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            userDefaults.set(val, forKey: defaultsKeys.secret)
            userDefaults.synchronize()
        }
    }

    func getUsername() -> String {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            if let username = userDefaults.string(forKey: defaultsKeys.username) {
                return username
            }
        }
        return ""
    }

    func setUsername(val: String) {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            userDefaults.set(val, forKey: defaultsKeys.username)
            userDefaults.synchronize()
        }
    }

    func getPin() -> Int {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            if let pin = Int(userDefaults.string(forKey: defaultsKeys.pin) ?? "-1") {
                return pin
            }
        }
        return -1
    }

    func setPin(val: Int) {
        if let userDefaults = UserDefaults(suiteName: "group.boiler-key.test") {
            userDefaults.set(String(val), forKey: defaultsKeys.pin)
            userDefaults.synchronize()
        }
    }
 */
}


//import Cocoa
//import SafariServices.SFSafariApplication
//
//class ViewController: NSViewController {
//
//    @IBOutlet var appNameLabel: NSTextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.appNameLabel.stringValue = "Boiler-Key-Safari";
//    }
//
//    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
//        SFSafariApplication.showPreferencesForExtension(withIdentifier: "JG.Boiler-Key-Safari-Extension") { error in
//            if let _ = error {
//                // Insert code to inform the user that something went wrong.
//
//            }
//        }
//    }
//
//}
