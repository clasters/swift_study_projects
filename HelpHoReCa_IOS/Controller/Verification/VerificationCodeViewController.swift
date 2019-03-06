import UIKit
import Alamofire
//TODO
class VerificationCodeViewController: UIViewController {
    
    let verificationContainerView = VerificationViewContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeManager.currentTheme().mainBackgroundColor
        view.addSubview(verificationContainerView)
        verificationContainerView.frame = view.bounds
        verificationContainerView.resend.addTarget(self, action: #selector(sendSMSConfirmation), for: .touchUpInside)
        verificationContainerView.verificationCodeController = self
        configureNavigationBar()
        
    }
    
    fileprivate func configureNavigationBar () {
        self.navigationItem.hidesBackButton = true
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        setRightBarButtonStatus()
    }
    
    func setRightBarButtonStatus() {
        if verificationContainerView.verificationCode.text!.count < 4 || verificationContainerView.verificationCode.text!.count > 4   {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            rightBarButtonDidTap()
        }
    }
    func setRightBarButton(with title: String) {
        let rightBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(rightBarButtonDidTap))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setLeftBarButton(with title: String) {
        let leftBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(leftBarButtonDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    //Повторно отправить код
    @objc fileprivate func sendSMSConfirmation () {
  
        verificationContainerView.resend.isEnabled = false
        let PhoneNumber = verificationContainerView.titleNumber.text!
        
        let params: [String:String] = ["PhoneNumber": PhoneNumber]
        
        request("https://helphoreca.online/api/Account/Check",  method: .post, parameters: params, encoding: URLEncoding.default).validate(statusCode: 200..<600).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let jsonObject = value as? String else { return  }
                
                if jsonObject.contains("Пользователь с таким номером телефона уже зарегестрирован"){
                    errorAlert(messageText: jsonObject, controller: self)
                    
                    
                }
            case .failure(let error):
                //TODO сделать обращение в техподдержку
                errorAlert(messageText: error.localizedDescription, controller: self)
            }
        }
    
        self.verificationContainerView.runTimer()
    }
    
    @objc func rightBarButtonDidTap () {
        
    }
    
    @objc func leftBarButtonDidTap () {
        
    }
    
    func changeNumber () {
        verificationContainerView.verificationCode.resignFirstResponder()
        let verificationID = UserDefaults.standard.string(forKey: "ChangeNumberAuthVerificationID")
        let verificationCode = verificationContainerView.verificationCode.text!
        
        print("verification code:", verificationCode)
        
        if verificationID == nil {
            self.verificationContainerView.verificationCode.shake()
            return
        }
        
    }
    
    func authenticate() {
        verificationContainerView.verificationCode.resignFirstResponder()

        // Переход на регистрацию
  
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterController") as! RegisterViewController
        vc.PhoneNumber = self.verificationContainerView.titleNumber.text!
        vc.ConfirmCode = self.verificationContainerView.verificationCode.text!
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
