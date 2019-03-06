import UIKit
import Alamofire
import Material


class RegisterViewController: UIViewController  {

    var PhoneNumber: String = ""
    var ConfirmCode: String = ""
    fileprivate var EmailField: TextField!
    fileprivate var FirstNameField: TextField!
    fileprivate var LastNameField: TextField!
    //var stackview = UIStackView()
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 50
    
    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBAction func leftBarButton(_ sender: UIBarButtonItem) {
        // действие при нажатии "назад"
        let destination = PhoneNumberController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
    @IBAction func rightBarButton(_ sender: UIBarButtonItem) {
       guard let params: [String:String] = [
            "UserName": FirstNameField.text!,
            "LastName": LastNameField.text!,
            "City": "Казань",
            "Promocode": "",
            "Email": EmailField.text ?? "",
            "Password": "Password",
            "ConfirmPassword": "Password",
            "PhoneNumber": PhoneNumber,
            "ConfirmCode": ConfirmCode
        ] else { return }
        
        request("https://helphoreca.online/api/Account/Register",  method: .post, parameters: params, encoding: URLEncoding.default).validate(statusCode: 200..<300).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let jsonObject = value as? String else { return  }
                if jsonObject.contains("success"){
                    
                    let vc = ContainerController()
                    self.present(vc, animated: true, completion: nil)
                }
                else{ errorAlert(messageText: "Что-то пошло не так", controller: self)}
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = constant
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.layout(stackView).top(self.NavBar.bounds.height + 60).left(20).right(20)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(FirstNameField)
        stackView.addArrangedSubview(LastNameField)
        stackView.addArrangedSubview(EmailField)
        //view.layout(EmailField).center(offsetY: +LastNameField.bounds.height + 60).left(20).right(20)
        }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
    
    extension RegisterViewController {
        fileprivate func prepareEmailField() {
            EmailField = TextField()
            EmailField.placeholder = "Email"
            EmailField.detail = "Получить промокод на 100р"
            EmailField.isClearIconButtonEnabled = true
           
            EmailField.isPlaceholderUppercasedWhenEditing = true
            EmailField.dividerNormalColor = Color.blueGrey.base
            // Set the text inset
            //  EmailField.textInset = 20
            
            let leftView = UIImageView()
            leftView.image = Icon.email
            EmailField.leftView = leftView
            
        }
        
        fileprivate func prepareFirstNameField() {
            FirstNameField = TextField()
            FirstNameField.placeholder = "Имя"
            FirstNameField.detail = "Введите ваше имя"
            FirstNameField.isClearIconButtonEnabled = true
          
            FirstNameField.isPlaceholderUppercasedWhenEditing = true
            FirstNameField.dividerNormalColor = Color.pink.base
  
            let leftView = UIImageView()
            leftView.image = Icon.pen
            FirstNameField.leftView = leftView

        }
        fileprivate func prepareSecondNameField() {
            LastNameField = TextField()
            LastNameField.placeholder = "Фамилия"
            LastNameField.detail = "Введите вашу фамилию"
            LastNameField.isClearIconButtonEnabled = true
           
            LastNameField.isPlaceholderUppercasedWhenEditing = true
            LastNameField.dividerNormalColor = Color.pink.base

            let leftView = UIImageView()
            leftView.image = Icon.pen
            LastNameField.leftView = leftView
            
        
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



