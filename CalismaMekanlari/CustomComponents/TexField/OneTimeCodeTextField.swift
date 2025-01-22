//
//  OneTimeCodeTextField.swift
//  isteportal
//
//  Created by Ozan Çiçek on 17.01.2025.
//

import UIKit

class OneTimeCodeTextField: UITextField {
    
    var didEnterLastDigit: ((String) -> Void)?
    var defaultCharacter = ""  // Boş karakter kullanacağız
    
    private var isConfigured = false
    private var digitLabels = [UILabel]()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    func configure(with slotCount: Int = 6) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotCount)
        addSubview(labelsStackView)
        
        addGestureRecognizer(tapRecognizer)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12 // Box'lar arası mesafe
        
        for _ in 1...count {
            let label = createBoxLabel()
            stackView.addArrangedSubview(label)
            digitLabels.append(label)
        }
        
        return stackView
    }
    
    private func createBoxLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.isUserInteractionEnabled = true
        label.text = defaultCharacter
        label.textColor = .black
        
        // Box tasarımı
        label.backgroundColor = .white
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.systemGray4.cgColor
        label.layer.cornerRadius = 8
        
        // Sabit boyut için constraint
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 48),
            label.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        return label
    }
    
    @objc private func textDidChange() {
        guard let text = self.text, text.count <= digitLabels.count else { return }
        
        for i in 0..<digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
                currentLabel.backgroundColor = .white
                currentLabel.layer.borderColor = UIColor.systemBlue.cgColor // Dolu box'ın border rengi
            } else {
                currentLabel.text = defaultCharacter
                currentLabel.backgroundColor = .white
                currentLabel.layer.borderColor = UIColor.systemGray4.cgColor // Boş box'ın border rengi
            }
        }
        
        if text.count == digitLabels.count {
            didEnterLastDigit?(text)
        } else {
            didEnterLastDigit?(text)
        }
    }
}

extension OneTimeCodeTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
}

