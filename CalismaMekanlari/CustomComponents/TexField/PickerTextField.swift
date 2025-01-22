import UIKit

@IBDesignable
class PickerTextField: UITextField {
    
    // MARK: - Properties
    
  
    
    private var _cornerRadius: CGFloat = 12.0
    
    // Public property
 override var cornerRadius: CGFloat {
        get { return _cornerRadius }
        set {
            _cornerRadius = newValue
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 10.0
    @IBInspectable var rightPadding: CGFloat = 30.0
    
    @IBInspectable var placeholderColor: UIColor = StyleVars.labelColor.withAlphaComponent(0.5) ?? .black {
        didSet { setPlaceholder() }
    }
    
    var domainId: String = "" {
        didSet { fetchDomainValues() }
    }
    
    private var pickerData: [String] = []
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        borderStyle = .none
        font = UIFont(name: TextFonts.MediumR, size: 16)
        backgroundColor = StyleVars.cellBackground
        layer.cornerRadius = cornerRadius
        setPlaceholder()
        setupArrowIcon()
        setupInputView()
        setupToolbar()
    }
    
    // MARK: - UI Setup
    
    private func setPlaceholder() {
        guard let placeholder = placeholder else { return }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: UIFont(name: TextFonts.MediumR, size: 16) ?? .systemFont(ofSize: 16)
        ]
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    private func setupArrowIcon() {
        let arrowContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let arrow = UIImageView(image: UIImage(named: "pickerArrow"))
        arrow.contentMode = .scaleAspectFit
        arrow.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        arrowContainer.addSubview(arrow)
        rightView = arrowContainer
        rightViewMode = .always
    }
    
    private func setupInputView() {
        inputView = pickerView
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneTapped))
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        inputAccessoryView = toolbar
    }
    
    // MARK: - Layout
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
    
    // MARK: - Data Fetching
    
    private func fetchDomainValues() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
           // let domain = Utilities().readDomainValue(domainid: self.domainId)
        //    let domainValueList = domain.compactMap { $0.value } ?? []
            
            DispatchQueue.main.async {
           //     self.pickerData = domainValueList
                self.pickerView.reloadAllComponents()
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func doneTapped() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if selectedRow < pickerData.count {
            text = pickerData[selectedRow]
            // Notification gönder
          //  NotificationCenter.default.post(name: .pickerDidSelect, object: text)
        }
        resignFirstResponder()
    }
    
    @objc private func cancelTapped() {
        resignFirstResponder()
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension PickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
