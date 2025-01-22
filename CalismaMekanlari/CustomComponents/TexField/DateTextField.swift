//
//  DateTextField.swift
//  isteportal
//
//  Created by Ozan Çiçek on 5.07.2024.
//

import Foundation
import UIKit

@IBDesignable
class DatePickerTextField: UITextField {
    
 
    // Köşe yarıçapı özelliği
    private var _cornerRadius: CGFloat = 12.0
    
    // Public property
 override var cornerRadius: CGFloat {
        get { return _cornerRadius }
        set {
            _cornerRadius = newValue
            self.layer.cornerRadius = newValue
        }
    }
    
    // Sol boşluk özelliği
    @IBInspectable var leftPadding: CGFloat = 10.0
    
    // Sağ boşluk özelliği
    @IBInspectable var rightPadding: CGFloat = 30.0 // Updated for space for arrow icon
    
    // Placeholder metin rengi özelliği
    @IBInspectable var placeholderColor: UIColor = StyleVars.labelColor.withAlphaComponent(0.5) ?? .black  {
        didSet {
            setPlaceholder()
        }
    }
    
    // Date picker
    private let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.borderStyle = .none
        self.font = UIFont(name: TextFonts.MediumR, size: 16)
        self.backgroundColor = StyleVars.cellBackground
        self.layer.cornerRadius = cornerRadius
        setPlaceholder()
        
        // Setup arrow icon
        let arrow = UIImageView(image: UIImage(named: "pickerCalendar"))
        arrow.contentMode = .scaleAspectFit
        arrow.frame = CGRect(x: 0, y: 0, width: 20, height: 20) // Adjusted frame for arrow icon
        let arrowContainer = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20)) // Container to add padding
        arrowContainer.addSubview(arrow)
        self.rightView = arrowContainer
        self.rightViewMode = .always
        
        // Setup date picker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "tr_TR") // Set locale to Turkish
        self.inputView = datePicker
        
        // Setup toolbar with Done and Cancel buttons
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneTapped))
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    private func setPlaceholder() {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.foregroundColor] = placeholderColor
        
        if let font = UIFont(name: TextFonts.MediumR, size: 16) {
            attributes[.font] = font
        }
        
        if let placeholder = placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
    
    
    @objc private func doneTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        self.text = dateString
        // Notification gönder
       // NotificationCenter.default.post(name: .dateDidSelect, object: dateString)
        self.resignFirstResponder()
    }
    
    @objc private func cancelTapped() {
        self.resignFirstResponder()
    }
}
