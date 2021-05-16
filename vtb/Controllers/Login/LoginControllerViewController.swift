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
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.delegate = self
        
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.delegate = self
        
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .blue
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 20
//        button.frame.size.height = 60
        
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return button
    }()
    
    private var registrationButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.blue, for: .normal)
        
        button.setTitle("Регистрация", for: .normal)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        stackView.addArrangedSubview(self.loginButton)
        
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.imageView)
        stackView.addArrangedSubview(self.loginTextField)
        stackView.addArrangedSubview(self.passwordTextField)
//        stackView.addArrangedSubview(self.buttonStackView)
        stackView.addArrangedSubview(self.loginButton)
        stackView.addArrangedSubview(self.registrationButton)
        
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
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
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        registrationButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        
        scrollView.contentInset.top = 100
        scrollView.contentSize.height = stackView.frame.height
        
        UIResponder
            .keyboardWillHideNotification
            .observe(in: self, selector: #selector(keyboardWillHide))
        UIResponder
            .keyboardDidShowNotification
            .observe(in: self, selector: #selector(keyboardDidShow))
        
        loginButton.isEnabled = false
        loginButton.backgroundColor = .blue.withAlphaComponent(0.6)
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = .zero
    }
    
    @objc
    private func keyboardDidShow(_ notification: Notification) {
        guard let info = notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        scrollView.contentInset.bottom = info.cgRectValue.height
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }

    @objc
    private func login() {
        self.view.showActivity()
        self.view.resignFirstResponder()
        
        guard let login = loginTextField.text,
           !login.isEmpty,
           let password = passwordTextField.text,
           !password.isEmpty else {
            self.alert(message: "Заполните данные")
            return
        }
        
        Request.shared.login(login: login, password: password) { [weak self] response in
            if let json = response.json as? [String: Any],
               let token = json["access_token"] as? String {
                AppData.token = token
                AppData.isRegistered = true
                UIApplication.mainDelegate.showRoot()
            } else {
                self?.alert(message: response.errorCode?.message)
                self?.view.hideActivity()
            }
        }
    }
    
    private func alert(message: String?) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let login = loginTextField.text,
           !login.isEmpty,
           let password = passwordTextField.text,
           !password.isEmpty {
            self.loginButton.isEnabled = true
            loginButton.backgroundColor = .blue
        }
        
        return true
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
    
    @Storage(key: "token", defaultValue: "")
    static var token: String
    
    @Storage(key: "insure", defaultValue: [])
    static var insures: [Insure]
}

public extension Notification.Name {
    func observe(in observer: Any,
                 using center: NotificationCenter = .default,
                 selector: Selector,
                 object: Any? = nil) {
        center.addObserver(observer, selector: selector, name: self, object: object)
    }
}
