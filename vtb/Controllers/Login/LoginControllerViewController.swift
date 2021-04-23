//
//  LoginControllerViewController.swift
//  vtb
//
//  Created by Alina Golubeva on 19.04.2021.
//

import UIKit
import SnapKit

class LoginController: ViewController {

    private var imageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.image = #imageLiteral(resourceName: "vtb")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .blue
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return button
    }()
    
//    private var authButton: UIButton = {
//        let button = UIButton()
//        
//        button.backgroundColor = .blue
//        button.setTitle("Регистрация", for: .normal)
//        button.layer.cornerRadius = 20
//        
//        return button
//    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        stackView.addArrangedSubview(self.loginButton)
//        stackView.addArrangedSubview(self.authButton)
        
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.imageView)
        stackView.addArrangedSubview(self.loginTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        stackView.addArrangedSubview(self.buttonStackView)
        
        stackView.spacing = 16
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        loginTextField.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
    }

    @objc
    private func login() {
        DataProvider.shared.login {
            AppData.isRegistered = true
            UIApplication.mainDelegate.showRoot()
        }
    }
}

extension UIApplication {
    static var mainDelegate: AppDelegate {
        guard let delegate = self.shared.delegate as? AppDelegate else { preconditionFailure() }
        
        return delegate
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
}


@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct AppData {
    @Storage(key: "isRegistered", defaultValue: false)
    static var isRegistered: Bool
}
