//
//  DetailViewController.swift
//  StackToShop
//
//  Created by 김찬교 on 2024/01/01.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    
    //MARK: - UI구현
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageContainView: UIView = {
        let view = UIView()
        view.addSubview(mainImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "이       름:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var nameStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "가       격:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let costTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .numberPad
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var costStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [costLabel, costTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let expectedmethodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "구매링크:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let expectedmethodTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var expectedmethodStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [expectedmethodLabel, expectedmethodTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let whenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "기       한:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let whenTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var whenStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [whenLabel, whenTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setTitle("UPDATE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame.size.height = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [imageContainView, nameStackView, costStackView, expectedmethodStackView, whenStackView, saveButton])
        stview.spacing = 10
        stview.axis = .vertical
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let labelWidth: CGFloat = 70
    var stackViewTopConstraint: NSLayoutConstraint!
    
    // MVC ⭐️
    //var member: Member?
    
    // MVVM ⭐️
    var viewModel: WantToBuyViewModel
    
    // 뷰모델 주입
    init(viewModel: WantToBuyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Add UIDatePicker
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime // Choose the desired mode
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return picker
    }()
    
    
    //MARK: - 라이프사이클
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupMemberUI()
        setupTapGestures()
        setupNotification()
        costTextField.delegate = self
        // Set date picker as input view for whenTextField
        whenTextField.inputView = datePicker
<<<<<<< HEAD
        viewModel.costtextfield.subscribe { value in DispatchQueue.main.async {
            self.costTextField.text = value
        }
    }
=======
        bindToViewModel()
>>>>>>> main

        // Add done button to toolbar
        let toolbar = createToolbar()
        whenTextField.inputAccessoryView = toolbar
    }
    func bindToViewModel() {
        costTextField.reactive.text.bind(to: viewModel.costString)
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

        toolbar.setItems([flexSpace, doneButton], animated: false)

        return toolbar
        }

        // Method to handle changes in the date picker
        @objc func datePickerValueChanged() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Use your desired date format
            whenTextField.text = dateFormatter.string(from: datePicker.date)
        }

        // Method to handle the done button tap
        @objc func doneButtonTapped() {
            whenTextField.resignFirstResponder() // Dismiss the keyboard
        }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        setConstraints()
    }
    
    func setupMemberUI() {
        saveButton.setTitle(viewModel.buttonTitle, for: .normal)
        
        mainImageView.image = viewModel.wtbImage
        nameTextField.text = viewModel.nameString
        expectedmethodTextField.text = viewModel.expectedmethodString
//        whenTextField.text = viewModel.whenString
//        if let whenString = viewModel.whenString { # 2
//                // Use a DateFormatter to convert Date to String
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Use your desired date format
//
//                // Set the formatted date string to whenLabel.text
//                whenTextField.text = dateFormatter.string(from: whenString)
//            } else {
//                whenTextField.text = nil // or provide a default value if viewModel.whenDate is nil
//            }
//        if let whenString = viewModel.whenString { // # 3
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Use your desired date format
//
//                if let whenString = dateFormatter.string(from: whenString) {
//                    whenTextField.text = dateFormatter.string(from: whenString)
//                } else {
//                    print("Error: Unable to convert string to date.")
//                }
//            } else {
//                whenTextField.text = nil
//            }
        // Handling date formatting
//            if let whenString = viewModel.whenString {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Use your desired date format
//
//                if let formattedDate = dateFormatter.date(from: whenString) {
//                    whenTextField.text = dateFormatter.string(from: formattedDate)
//                } else {
//                    print("Error: Unable to convert string to date.")
//                }
//            } else {
//                whenTextField.text = nil
//            }
        costTextField.text = viewModel.costString
    }

    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
            mainImageView.widthAnchor.constraint(equalToConstant: 150),
            mainImageView.centerXAnchor.constraint(equalTo: imageContainView.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: imageContainView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageContainView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            costLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            expectedmethodLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            whenLabel.widthAnchor.constraint(equalToConstant: labelWidth)
        ])
        
        stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            stackViewTopConstraint,
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }
    
    //MARK: - 이미지뷰가 눌렸을때의 동작 설정
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        self.mainImageView.addGestureRecognizer(tapGesture)
        self.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        setupImagePicker()
    }
    
    func setupImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func moveUpAction() {
        stackViewTopConstraint.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func moveDownAction() {
        stackViewTopConstraint.constant = 10
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: - SAVE버튼 또는 UPDATE버튼이 눌렸을때의 동작
    @objc func saveButtonTapped() {
        print("Current text: \(nameTextField.text ?? "")")
        print("Replacement string: \(costTextField.text ?? "")")
        guard nameTextField.text != "", costTextField.text != "" else {
            print("최소한 이름, 나이는 입력해야 합니다.")
            return
        }
        
        let image = mainImageView.image
        let name = nameTextField.text
        let cost = costTextField.text ?? ""
        let expectedmethod = expectedmethodTextField.text ?? ""
//        let when = whenTextField.text ?? ""
        
        viewModel.handleButtonTapped(image: image, name: name, cost: cost, expectedmethod: expectedmethod)
        
        viewModel.backToBeforeVC(fromCurrentVC: self, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !nameTextField.frame.contains(touch.location(in: view)) else {
            // 텍스트 필드 외의 다른 부분을 터치한 경우에만 키보드를 숨깁니다.
            self.view.endEditing(true)
            return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: - 피커뷰 델리게이트
extension DetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.mainImageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지 못 불러왔음!")
        }
    }
}

//MARK: - 텍스트필드 델리게이트
extension DetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text else {
                    return true
                }
                text = text.replacingOccurrences(of: "원", with: "")
                text = text.replacingOccurrences(of: ",", with: "")

                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal

                if (string.isEmpty) {
                    // delete
                    if text.count > 1 {
                        guard let price = Int.init("\(text.prefix(text.count - 1))") else {
                            return true
                        }
                        guard let result = numberFormatter.string(from: NSNumber(value:price)) else {
                            return true
                        }

                        textField.text = "\(result)원"
                    }
                    else {
                        textField.text = ""
                    }
                }
                else {
                    // add
                    guard let price = Int.init("\(text)\(string)") else {
                        return true
                    }
                    guard let result = numberFormatter.string(from: NSNumber(value:price)) else {
                        return true
                    }

                    textField.text = "\(result)원"
                    
                    
                }
//                        print("Current text: \(textField.text ?? "")")
//                        print("Replacement string: \(textField.text ?? "")")

                return false
            }

//            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//                print("Current text: \(textField.text ?? "")")
//                print("Replacement string: \(textField.text ?? "")")
//                return true
//            }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Current text: \(textField.text ?? "")")
        print("Replacement string: \(textField.text ?? "")")
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("Current text: \(textField.text ?? "")")
        print("Replacement string: \(textField.text ?? "")")
    }
         }
