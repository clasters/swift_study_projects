import UIKit

class SettingsController: UIViewController{
    
    // MARK - Properties
    
    var username: String?
    
    
    // MARK - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        
        if let username = username{
            print("Ваше имя \(username)")
        }else{
            print("Имя не задано")
        }
    }
    
    // MARK - Selectors
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Function
    
    func configureUI(){
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_clear_white_36pt_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
}
