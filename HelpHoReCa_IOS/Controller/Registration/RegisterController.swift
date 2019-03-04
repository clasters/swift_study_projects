import UIKit
import Alamofire


class RegisterController: UIViewController  {

    var PhoneNumber: String = ""
    var ConfirmCode: String = ""
    
    @IBOutlet weak var firsNameTF: UITextField!
    @IBOutlet weak var Navigation: UINavigationItem!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var promoCodeTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        let params: [String:String] = [
            "UserName": firsNameTF.text!,
            "LastName": lastNameTF.text!,
            "City": cityTF.text!,
            "Promocode": promoCodeTF.text!,
            "Email": emailTF.text!,
            "Password": passwordTF.text!,
            "ConfirmPassword": confirmPasswordTF.text!,
            "PhoneNumber": PhoneNumber,
            "ConfirmCode": ConfirmCode
        ]
        
        request("https://helphoreca.online/api/Account/Register",  method: .post, parameters: params, encoding: URLEncoding.default).validate(statusCode: 200..<300).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let jsonObject = value as? String else { return  }
                if jsonObject.contains("success"){

                  let vc = ContainerController()
                  self.present(vc, animated: true, completion: nil)
                    
                }else{
                    errorAlert(messageText: "Ошибка", controller: self)
                }
            case .failure(let error):
                errorAlert(messageText: error.localizedDescription, controller: self)
                return
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeManager.setTheme(theme: .Light)
        
        let theme = ThemeManager.currentTheme()
        ThemeManager.applyTheme(theme: theme)
        
    }
   
 
  
}

struct Post {
    
    var id: Int
    var title: String
    var body: String
    var userId: String
    
    init?(json: [String: Any]) {
        
        guard
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let body = json["body"] as? String,
            let userId = json["userId"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
    }}



