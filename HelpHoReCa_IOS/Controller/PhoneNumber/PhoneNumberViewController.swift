import UIKit
import SafariServices

class PhoneNumberViewController: UIViewController {
    
    let phoneNumberViewContainer = PhoneNumberViewContainer()
    let countries = Country().countries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeManager.currentTheme().mainBackgroundColor
        configurePhoneNumberContainerView()
        configureNavigationBar()
        setCountry()
    }
    
    func configurePhoneNumberContainerView() {
        view.addSubview(phoneNumberViewContainer)
        phoneNumberViewContainer.frame = view.bounds
    }
    
    // MARK: - Methods
    fileprivate func setCountry() {
        for country in countries {
            if  country["code"] == countryCode {
                phoneNumberViewContainer.countryCode.text = country["dial_code"]
                phoneNumberViewContainer.selectCountry.setTitle(country["name"], for: .normal)
            }
        }
    }
    
    fileprivate func configureNavigationBar () {
        let rightBarButton = UIBarButtonItem(title: "Далее", style: .done, target: self, action: #selector(rightBarButtonDidTap))
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func openCountryCodesList() {
        let picker = CountryCodeViewController()
        picker.delegate = self
        phoneNumberViewContainer.phoneNumber.resignFirstResponder()
        navigationController?.pushViewController(picker, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setRightBarButtonStatus()
    }
    
    func setRightBarButtonStatus() {
        if phoneNumberViewContainer.phoneNumber.text!.count < 10 || phoneNumberViewContainer.phoneNumber.text!.count > 10 || phoneNumberViewContainer.countryCode.text == " - "  {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    var isVerificationSent = false
    
    @objc func rightBarButtonDidTap () {
        
        
        if !isVerificationSent {
            sendSMSConfirmation()
        } else {
            print("verification has already been sent once")
        }
    }
    
    func sendSMSConfirmation () {
        print("tappped sms confirmation - phone number controller")
    }
}

extension PhoneNumberViewController: CountryPickerDelegate {
    
    func countryPicker(_ picker: CountryCodeViewController, didSelectCountryWithName name: String, code: String, dialCode: String) {
        phoneNumberViewContainer.selectCountry.setTitle(name, for: .normal)
        phoneNumberViewContainer.countryCode.text = dialCode
        setRightBarButtonStatus()
        picker.navigationController?.popViewController(animated: true)
    }
}
