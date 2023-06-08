//
//  PlaceViewController.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//

import UIKit
class PlaceViewController: UIViewController {
    
    private lazy var topImage = UIImageView()
    
    private lazy var nameView = CustomTextFeildView(text: "Name", placeHolder: "Place name")
    private lazy var locationView = CustomTextFeildView(text: "Location", placeHolder: "Place location")
    private lazy var tupeView = CustomTextFeildView(text: "Type", placeHolder: "Place type")
    lazy var stackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 10, views: [topImage, nameView, locationView, tupeView])
    lazy var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationBar()
        setupConstraints()
        setupKeyboardHiding()
    }
    
    private func navigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        if let titleFont = UIFont(name: "SnellRoundhand", size: 24) {
            let titleAttributes = [NSAttributedString.Key.font: titleFont]
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        } else {
            print("Ошибка: Невозможно создать шрифт")
        }
        self.navigationItem.title = "New Places"
        
        //MARK: - rightBarButtonItem
        let titleForTitle = "Save"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: titleForTitle, style: .done, target: self, action: #selector(createTimer))
        //MARK: - rightBarButtonItem
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closed))
    }
    
    private func setupConstraints() {
        topImage.image = UIImage(named: "Photo")
        topImage.backgroundColor = .systemGray5
        topImage.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(appendAction(_:)))
        topImage.addGestureRecognizer(tapGesture)
        topImage.isUserInteractionEnabled = true
        
        view.addSubViews(scrollView)
        scrollView.addSubViews(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32), // Заполнение горизонтального пространства
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -250),
            //TODO: - Переделать
            topImage.widthAnchor.constraint(equalTo: stackView.widthAnchor),
                topImage.heightAnchor.constraint(equalTo: topImage.widthAnchor)
        ])
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func appendAction(_ sender: UITapGestureRecognizer){
        
        let photoIcon = UIImage(named: "photo")
        let cameraIcon = UIImage(named: "camera")
        let alert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default){ _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default){ _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(camera)
        alert.addAction(photo)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        stackView.frame.origin.y = stackView.frame.origin.y - 60
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        stackView.frame.origin.y = stackView.frame.origin.y + 60
    }
    
    @objc private func createTimer() {
        print(#function)
    }
    
    @objc private func closed() {
        dismiss(animated: true)
    }
    
}

extension PlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.topImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.topImage.contentMode = .scaleAspectFill
        self.topImage.clipsToBounds = true
        dismiss(animated: true)
    }
}
