//
//  ViewController.swift
//  HelpHoReCa_IOS
//
//  Created by Mark on 09/02/2019.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
//struct Post: Codable {
//    var ID : String
//    var Role : String
//    var City : String
//    var TypePrice : String
//    var Date : String
//    var Summ : String
//    var Fio : String
//    var Person : String
//    var TypeTask : String
//    var AddressTask : String
//    var CountViews : Int
//    var Status : String
//    var ResponceUser : String
//    var IsHot : Bool
//    var FreezeBalance : Bool
//    var UnreadMessage : Bool
//
//}
class ViewController: UIViewController {
//
    @IBOutlet weak var LoginTF: UIStackView!
    @IBOutlet weak var PasswordTF: UIStackView!
//
    @IBAction func Auth_Click(_ sender: UIButton) {
//
   }
//
//
//    enum Result<Value> {
//        case success(Value)
//        case failure(Error)
//    }
//
//    func getPosts(for ID: Int, completion: ((Result<[Post]>) -> Void)?) {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "helphoreca.online"
//        urlComponents.path = "/api/Account/Check"
//        let userIdItem = URLQueryItem(name: "ID", value: "\(ID)")
//        urlComponents.queryItems = [userIdItem]
//        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        let task = session.dataTask(with: request) { (responseData, response, responseError) in
//            DispatchQueue.main.async {
//                if let error = responseError {
//                    completion?(.failure(error))
//                } else if let jsonData = responseData {
//                    // Now we have jsonData, Data representation of the JSON returned to us
//                    // from our URLRequest...
//
//                    // Create an instance of JSONDecoder to decode the JSON data to our
//                    // Codable struct
//                    let decoder = JSONDecoder()
//
//                    do {
//                        // We would use Post.self for JSON representing a single Post
//                        // object, and [Post].self for JSON representing an array of
//                        // Post objects
//                        let posts = try decoder.decode([Post].self, from: jsonData)
//                        completion?(.success(posts))
//                    } catch {
//                        completion?(.failure(error))
//                    }
//                } else {
//                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
//                    completion?(.failure(error))
//                }
//            }
//        }
//
//        task.resume()
//    }
//
//    var posts = [Post]()
//
//     @IBAction func post_Click(_ sender: UIButton)  {
//        getPosts(for: 1) { (result) in
//            switch result {
//            case .success(let posts):
//                self.posts = posts
//                print("\(posts)")
//            case .failure(let error):
//                fatalError("error: \(error.localizedDescription)")
//            }
//        }
//    }
//
//

    
//WORK
struct  Post : Codable {
    let grant_type : String
    let username : String
    let password :  String

}



// We'll need a completion block that returns an error if we run into any problems
func submitPost(post: Post, completion:((Error?) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "helphoreca.online"
    urlComponents.path = "/token"

    guard let url = urlComponents.url else { fatalError("Could not create URL from components") }

    // Specify this request as being a POST method
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    //request.httpBody["grant_rype"] = "password"
    // Make sure that we include headers specifying that our request's HTTP body
    // will be JSON encoded
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"

    request.allHTTPHeaderFields = headers

    // Now let's encode out Post struct into JSON data...
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(post)
        // ... and set our request's HTTP body
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
    } catch {
        completion?(error)
    }

    // Create and run a URLSession data task with our JSON encoded POST request
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else {
            completion?(responseError!)
            return
        }

        // APIs usually respond with the data you just sent in your POST request
        if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
            print("response: ", utf8Representation)
        } else {
            print("no readable data received in response")
        }
    }
    task.resume()
}

     @IBAction func post_Click(_ sender: UIButton)  {
        let myPost =  Post( grant_type: "password", username: "+79991629204", password: "HelpHoReCa54213_WaiterJ0bs")
        submitPost(post: myPost) { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        }
    
    
    
    
    
    
    
    
    
    
    
//    //var URL = "https://helphoreca.online/token";
//
//
//
//    @IBAction func postTapped(_ sender: UIButton) {
//        guard let url = URL(string: "https://helphoreca.online/token") else {return}
//
//            var paramAuth = ["grant_type": "password", "username": "+79991629204", "password": "HelpHoReCa54213_WaiterJ0bs"]
//        // let parameters = "{\n  \"PhoneNumber\" : \"+79991629204\"\n}"
//        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        let postString = "PhoneNumber=\("+79991629204")" // which is your parameters
//        request.httpBody = postString.data(using: .utf8)
//
//
//
//        // Getting response for POST Method
//        DispatchQueue.main.async {
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    return // check for fundamental networking error
//                }
//
//                // Getting values from JSON Response
//                let responseString = String(data: data, encoding: .utf8)
//                print("responseString = \(String(describing: responseString))")
//                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
//                }catch _ {
//                    print ("OOps not good JSON formatted response")
//                }
//            }
//            task.resume()
//        }
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }


}

