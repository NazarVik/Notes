//
//  NoteViewController.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 23.05.23.
//

import UIKit
import SnapKit

final class NoteViewController: UIViewController {
    //MARK: GUI Variables
    private let attachmentView: UIImageView = {
        let view = UIImageView()
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    //MARK: - properties
    var viewModel: NoteViewModelProtocol?
    private let imageHeight = 200
    private var imageName: String?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Private methods
    private func configure() {
        textView.text = viewModel?.text
        attachmentView.image = viewModel?.image
    }
    
    //MARK: - Private methods
    @objc
    private func saveAction() {
        viewModel?.save(with: textView.text,
                        and: attachmentView.image,
                        imageName: imageName)
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func deleteAction() {
        viewModel?.delete()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func addImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(attachmentView)
        view.addSubview(textView)
        view.backgroundColor = .white
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        textView.layer.borderWidth = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0
        
        setupConstraints()
        setupBars()
    }
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            let height = attachmentView.image != nil ? imageHeight : 0
            make.height.equalTo(height)
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-10)
        }
    }
    
    private func updateImageHeight() {
        attachmentView.snp.updateConstraints { make in
            make.height.equalTo(imageHeight)
        
        }
    }
    // убираем клавиатуру по нажатию на экран
    @objc
    private func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    private func setupBars() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash,
                                          target: self,
                                          action: #selector(deleteAction))
        
        let photoButton = UIBarButtonItem(barButtonSystemItem: .camera,
                                          target: self,
                                          action: #selector(addImage))
        
        let space = UIBarButtonItem(systemItem: .flexibleSpace)
        
        setToolbarItems([trashButton, space, photoButton, space], animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAction))
    }
}

extension NoteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage,
              let url = info[.imageURL] as? URL  else { return }
        imageName = url.lastPathComponent
        attachmentView.image = selectedImage
        updateImageHeight()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
