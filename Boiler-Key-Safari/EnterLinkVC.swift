//
//  EnterLinkVC.swift
//  Boiler Key
//
//  Created by Jeremy Gleeson on 7/10/20.
//  Copyright © 2020 Jeremy Gleeson. All rights reserved.
//

import Cocoa

class EnterLinkVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //linkUpdate(link: "asdf")
        if !getSecret().isEmpty {
            print("Found Secret")
            linkText.isEditable = false
            self.statusImg.image = self.succStat
        }
        linkText.delegate = self
        username.stringValue = getUsername()
        if getPin() != -1 {
            pin.stringValue = String(getPin())
        } else {
            pin.stringValue = ""
        }
    }
    
    @IBOutlet weak var linkText: NSTextField!
    @IBOutlet weak var statusImg: NSImageView!
    @IBOutlet weak var username: NSTextField!
    @IBOutlet weak var pin: NSTextField!
    
    @IBAction func finishAction(_ sender: Any) {
        if !username.stringValue.isEmpty {
            if !pin.stringValue.isEmpty {
                if pin.stringValue.count == 4 {
                    if let pinNum = Int(pin.stringValue) {
                        print("Set username and pin")
                        self.setPin(val: pinNum)
                        self.setUsername(val: username.stringValue)
                        NotificationCenter.default.post(name: ViewController.updateMain, object: nil, userInfo: nil)
                        self.dismiss(self)
                    }
                }
            }
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(self)
    }
    
    
    func linkUpdate(link: String) {
        statusImg.image = emptyStat
        if link.contains("m-1b9bef70.duosecurity.com") {
            if let code = link.components(separatedBy: "/").last {
                print(code)
                if code.count == 20 {
                    print("Link code: ", code)
                    if sendReq(link: code) {
                        linkText.isEditable = false
                        self.statusImg.image = self.succStat
                        return
                    }
                }
            }
        }
        self.statusImg.image = self.failStat
    }
    
    struct FullResponse: Codable {
        let response: Response
    }

    struct Response: Codable {
        let hotp_secret: String
    }
    
    func sendReq(link: String) -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        if let url = URL(string: "https://api-1b9bef70.duosecurity.com/push/v2/activation/" + link) {
        
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            var success = false

            components.queryItems = [
                URLQueryItem(name: "app_id", value: "com.duosecurity.duomobile.app.DMApplication"),
                URLQueryItem(name: "app_version", value: "2.3.3"),
                URLQueryItem(name: "app_build_number", value: "323206"),
                URLQueryItem(name: "full_disk_encryption", value: "False"),
                URLQueryItem(name: "manufacturer", value: "Google"),
                URLQueryItem(name: "model", value: "Pixel"),
                URLQueryItem(name: "platform", value: "Android"),
                URLQueryItem(name: "jailbroken", value: "False"),
                URLQueryItem(name: "version", value: "6.0"),
                URLQueryItem(name: "language", value: "EN"),
                URLQueryItem(name: "customer_protocol", value: "1")
            ]

            var request = URLRequest(url: components.url!)
            print(components.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            
            let requestTask = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Post request error occured: \(error)")
                } else {
                
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response data string:\n \(dataString)")
                        let jsonData = dataString.data(using: .utf8)!
                        let decoder = JSONDecoder()
                        do {
                            let json = try decoder.decode(FullResponse.self, from: jsonData)
                            self.setSecret(val: json.response.hotp_secret)
                            self.setCounter(val: 0)
                            print("Secret aquired")
                            success = true
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        print("Post request could not get data")
                    }
                }
                print("Returning ", success)
                semaphore.signal()
            }
            requestTask.resume()
            semaphore.wait()
            print("Final Returning ", success)
            return success
            
        } else {
            print("Error creating url for post")
            return false
        }
    }
}

extension EnterLinkVC: NSTextFieldDelegate {
  func controlTextDidChange(_ obj: Notification) {
    print(linkText.stringValue)
    linkUpdate(link: linkText.stringValue)
  }
}
