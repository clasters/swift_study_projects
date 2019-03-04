import UIKit
import Alamofire

class PhoneNumberController: PhoneNumberViewController {

    override func configurePhoneNumberContainerView() {
        super.configurePhoneNumberContainerView()
        
        phoneNumberViewContainer.instructions.text = "Пожалуйста, подтвердите код страны\nи введите свой номер телефона."
        phoneNumberViewContainer.terms.text = "Регистрируясь, вы соглашаетесь с Условиями обслуживания. Кроме того, если вы все еще не читали Политику конфиденциальности, ознакомьтесь, прежде чем зарегистрироваться."

        let attributes = [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().mainSubTitleColor]
        phoneNumberViewContainer.phoneNumber.attributedPlaceholder = NSAttributedString(string: "Ваш номер телефона", attributes: attributes)
    }
    
    override func rightBarButtonDidTap() {
        super.rightBarButtonDidTap()
        
        //POST SEND CODE
        let PhoneNumber = phoneNumberViewContainer.countryCode.text! + phoneNumberViewContainer.phoneNumber.text!
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
                // Переход на след страницу
                let destination = VerificationController()
                destination.verificationContainerView.titleNumber.text = PhoneNumber
                navigationController?.pushViewController(destination, animated: true)
        
    
 
    }
    

}
