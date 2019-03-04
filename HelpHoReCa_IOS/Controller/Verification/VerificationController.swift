import UIKit

class VerificationController: VerificationCodeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarButton(with: "Далее")
        setLeftBarButton(with: "Назад")
    }
    
    override func rightBarButtonDidTap() {
        super.rightBarButtonDidTap()
        authenticate()
    }
    
    override func leftBarButtonDidTap() {
        super.leftBarButtonDidTap()
        
        let destination = PhoneNumberController()
        navigationController?.pushViewController(destination, animated: true)
    }
}
