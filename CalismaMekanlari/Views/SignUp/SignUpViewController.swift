import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var surnameTF: UITextField!
    @IBOutlet var jobTF: UITextField!
    @IBOutlet var nxtBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        startFloatingBubbles()
    }

    private func setupUI() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Bilgilerinizi Giriniz"
        navigationController?.navigationBar.backItem?.title = "Geri"
        navigationController?.navigationBar.tintColor = .label

        let buttonText = NSAttributedString(
            string: "BAŞLA",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]
        )
        nxtBtn.setAttributedTitle(buttonText, for: .normal)
        nxtBtn.isEnabled = false
        nxtBtn.tintColor = .systemGray
        // bold button text

        nameTF.placeholder = "Adınız"
        surnameTF.placeholder = "Soyadınız"
        jobTF.placeholder = "Mesleğiniz"
    }

    private func setupDelegates() {
        nameTF.delegate = self
        surnameTF.delegate = self
        jobTF.delegate = self
    }

    private func checkFields() {
        let isValid = !(nameTF.text?.isEmpty ?? true) &&
            !(surnameTF.text?.isEmpty ?? true) &&
            !(jobTF.text?.isEmpty ?? true)

        UIView.animate(withDuration: 0.3) {
            self.nxtBtn.isEnabled = isValid
            self.nxtBtn.tintColor = isValid ? .systemTeal : .systemGray
        }
    }

    // TextFieldDelegate metodu
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkFields()
    }

    // Mevcut metodlar...
    @IBAction func NxtBtn_clicked(_ sender: Any) {
        saveUserDefault()
        goMainController()
        
        
        
    }

    func startFloatingBubbles() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
            self?.addBubble()
        }
    }
    
    func goMainController() {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
       if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first {
           window.rootViewController = mainTabBarController
           window.makeKeyAndVisible()
       }
    }
    
    func saveUserDefault() {
        let defaults = UserDefaults.standard
        defaults.set(nameTF.text, forKey: "userName")
        defaults.set(surnameTF.text, forKey: "userSurname")
        defaults.set(jobTF.text, forKey: "userJob")
        defaults.synchronize()
    }
    
    func postApi() {
        
    }

    func addBubble() {
        let bubbleSize = CGFloat.random(in: 80 ... 160)
        let bubble = UIView(frame: CGRect(x: 0, y: 0, width: bubbleSize, height: bubbleSize))

        bubble.backgroundColor = UIColor(white: 0.70, alpha: 0.08)
        bubble.layer.cornerRadius = bubbleSize / 2
        bubble.clipsToBounds = true

        let startX = CGFloat.random(in: 0 ... view.bounds.width)
        bubble.center = CGPoint(x: startX, y: -bubbleSize)

        view.insertSubview(bubble, at: 0)

        UIView.animate(withDuration: 5.0, delay: 0, options: .curveLinear) {
            bubble.center.y = self.view.bounds.height + bubbleSize
            bubble.center.x += CGFloat.random(in: -30 ... 30)
        } completion: { _ in
            bubble.removeFromSuperview()
        }
    }
}
