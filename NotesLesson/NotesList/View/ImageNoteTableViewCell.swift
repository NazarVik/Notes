//
//  ImageNoteTableViewCell.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 21.05.23.
//

import UIKit

final class ImageNoteTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGreen
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let attachmentView: UIImageView = {
        let view = UIImageView()
        
        view.layer.cornerRadius = 10
        view.image = UIImage(named: "mockImage")
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title label text"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    //MARK: - Initializations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - methods
    func set(note: Note, image: UIImage) {
        titleLabel.text = note.title
        attachmentView.image = image
    }
    
    //MARK: - Private methods
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(attachmentView)
        containerView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            
            attachmentView.snp.makeConstraints { make in
                make.leading.top.trailing.equalToSuperview().inset(5)
                make.height.equalTo(100)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(attachmentView.snp.bottom).offset(10)
                make.leading.trailing.bottom.equalToSuperview().inset(10)
            }
        }
    }
}

