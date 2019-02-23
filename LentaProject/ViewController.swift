//
//  ViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 25/07/2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import WebKit
import Foundation
class ViewController: UIViewController {

    static var bannedID: String?
    static let key = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODIxNTQxNzAsImlhdCI6MTU1MDYxODE3MCwicmF5IjoiMzYyMzQzNGFjOTczYjUxOTYxZDZkZmYzNzMyYTRiZmEiLCJzdWIiOjE0MTk0MH0.eYlBO1tQhsByX5Fyzm50a3BzM070oI7FeVlgnEpakOwHCQPgkXHS0QDNTx46mn4VWNUITptTeOfLFxQWgET3Maqoi1-p60ORWfOtP1EaoTcHyxZO5i7ewp168Nusme3omK3Vb2ww_HBOmDFla3ZIwh2DDkefniZOF3CRs-jyPbfl-kYLTa9ZR0hrAfBKmcnjkxHddl-j2WKrnrJG6kxij88C7Rlmav1r_6J9YY0v-ow5yHZcit89w3Rr1wKfH_x-Y-GHN8olzivkPS4rTlTE_965NTSv6GCMn-Sd2yZpaVWw_ruxfNaTmqIPkRql0_uLdZnMzKFj_ERZtvuytxtaFg"
    @IBOutlet weak var webView: WKWebView!
   
    //Retrieve & Copy Number, Reset Account, and Update webView
    @IBAction func getRequest(_ sender: Any) {
        
        guard let url = URL(string: "https://5sim.net/v1/user/buy/activation/russia/any/lenta") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let tokenString = "Bearer " + ViewController.key
        request.setValue(tokenString, forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let _ = response, let data = data else { return }
            
            var phoneNumber: String?
            var orderID: String?
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                
                if let phoneJson = json["phone"]{
                    phoneNumber = phoneJson as? String
                }
                if let id = json["id"]{
                    orderID = "\(id)"
                }
                
                self.bannedNumber(id: ViewController.bannedID )
                ViewController.bannedID = orderID
                phoneNumber = String((phoneNumber?.dropFirst(2))!)
                UIPasteboard.general.string = phoneNumber
 let url = URL(string: "https://game.lenta.com")
                
                do{
                    DispatchQueue.main.async {
                HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
                
                WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                    records.forEach { record in
                        WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                    }}
                    }}catch{}
                sleep(1)
                self.webView.load(URLRequest(url: url!))
                
               sleep(2)
                DispatchQueue.main.async { self.webView.evaluateJavaScript("""
(function() {
    var aa = document.querySelectorAll("input[type=checkbox]");
    for (var i = 0; i < aa.length; i++){
        aa[i].click();
    }
})()
""", completionHandler: { (res, error) -> Void in
                    //Here you can check for results if needed (res) or whether the execution was successful (error)
               })
                    self.webView.evaluateJavaScript("document.getElementById('Phone').value += '\(phoneNumber ?? "")c';", completionHandler: { (res, error) -> Void in
                        //Here you can check for results if needed (res) or whether the execution was successful (error)
                    })
                
                }
                sleep(2)
                DispatchQueue.main.async {
                    self.webView.evaluateJavaScript("""
(function() {
    var aa = document.querySelectorAll("button");
    for (var i = 0; i < aa.length; i++){
        aa[1].click();
    }
})()
""", completionHandler: { (res, error) -> Void in
    //Here you can check for results if needed (res) or whether the execution was successful (error)
                    })
                }
              
                
            } catch {
                print(error)
            }
            }.resume()
    }
    
    
    struct gift: Codable {
        var code:String
       
    }
    
    
    
    //Get a link to a gift
    @IBAction func getGift(_ sender: Any) {
        
        guard let url = URL(string: "https://5sim.net/v1/user/check/16437522" ) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let tokenString = "Bearer " + ViewController.key
        request.setValue(tokenString, forHTTPHeaderField: "Authorization")
        
        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let _ = response, let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                print(json)
                
               // let product: gift = try! JSONDecoder().decode(gift.self, for: data)
                
                
                guard let gift = json["sms"] else {return}
                guard let gifturl = gift["code"] as? String else {return}

                UIPasteboard.general.string =  gifturl

                if let url = URL(string: gifturl ), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
                
            } catch {
                print(error)
            }
            }.resume()
    }
    
    //Add number to ban list
    func bannedNumber(id: String?){
        
        guard let url = URL(string: "https://5sim.net/v1/user/ban/\(id ?? "Empty")") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let tokenString = "Bearer " + ViewController.key
        request.setValue(tokenString, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let _ = response, let data = data else { return }
            
            do {
                _ = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                
            } catch {
                print(error)
            }
            }.resume()
    }
}
