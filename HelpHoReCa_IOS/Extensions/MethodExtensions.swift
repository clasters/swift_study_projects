import UIKit

func basicErrorAlertWith (title: String, message: String, controller: UIViewController) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
    controller.present(alert, animated: true, completion: nil)
}



func errorAlert(messageText: String, controller: UIViewController) {
    let alert = UIAlertController(title: "Что-то пошло не так", message: messageText, preferredStyle: UIAlertController.Style.alert)
    
    // add the actions (buttons)
    alert.addAction(UIAlertAction(title: "Продолжить", style: UIAlertAction.Style.default, handler: nil))
    alert.addAction(UIAlertAction(title: "Написать в тех.поддержку", style: UIAlertAction.Style.cancel, handler: nil))
    
    // show the alert
    controller.present(alert, animated: true, completion: nil)
}
