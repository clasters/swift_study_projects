import UIKit
import Alamofire
import Material


class RegisterViewController: UIViewController  {

    var PhoneNumber: String = ""
    var ConfirmCode: String = ""
    fileprivate var EmailField: TextField!
    fileprivate var FirstNameField: TextField!
    fileprivate var SecondNameField: TextField!
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    
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
                    
                }else{ errorAlert(messageText: "Что-то пошло не так", controller: self) }
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
        prepareSecondNameField()
        prepareEmailField()
        
        prepareFirstNameField()
        
    
        }

 
    }
    
    extension RegisterViewController {
        fileprivate func prepareEmailField() {
            EmailField = TextField()
            EmailField.placeholder = "Email"
            EmailField.detail = "Получить промокод на 100р"
            EmailField.isClearIconButtonEnabled = true
            EmailField.delegate = self
            EmailField.isPlaceholderUppercasedWhenEditing = true
            
            
            // Set the colors for the emailField, different from the defaults.
          
            // Set the text inset
                  //  EmailField.textInset = 20
            
            let leftView = UIImageView()
            leftView.image = Icon.email
            EmailField.leftView = leftView
            
            view.layout(EmailField).center(offsetY: +SecondNameField.bounds.height + 60).left(20).right(20)
        }
        
        fileprivate func prepareFirstNameField() {
            FirstNameField = TextField()
            FirstNameField.placeholder = "Имя"
            FirstNameField.detail = "Ввелите ваше имя"
            FirstNameField.isClearIconButtonEnabled = true
            FirstNameField.delegate = self
            FirstNameField.isPlaceholderUppercasedWhenEditing = true
            FirstNameField.dividerNormalColor = Color.pink.base
  
            let leftView = UIImageView()
            leftView.image = Icon.pen
            FirstNameField.leftView = leftView
            
          
            view.layout(FirstNameField).center(offsetY: -SecondNameField.bounds.height - 60).left(20).right(20)
        }
        fileprivate func prepareSecondNameField() {
            SecondNameField = TextField()
            SecondNameField.placeholder = "Фамилия"
            SecondNameField.detail = "Введите вашу фамилию"
            SecondNameField.isClearIconButtonEnabled = true
            SecondNameField.delegate = self
            SecondNameField.isPlaceholderUppercasedWhenEditing = true
            
            SecondNameField.dividerNormalColor = Color.pink.base
          
            
            
            let leftView = UIImageView()
            leftView.image = Icon.pen
            SecondNameField.leftView = leftView
            
            
            view.layout(SecondNameField).center().left(20).right(20)
        }
    }
    
    
    extension RegisterViewController: TextFieldDelegate {
        public func textFieldDidEndEditing(_ textField: UITextField) {
            (textField as? ErrorTextField)?.isErrorRevealed = false
        }
        
        public func textFieldShouldClear(_ textField: UITextField) -> Bool {
            (textField as? ErrorTextField)?.isErrorRevealed = false
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            (textField as? ErrorTextField)?.isErrorRevealed = true
            return true
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



