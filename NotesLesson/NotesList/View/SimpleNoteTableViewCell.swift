//
//  SimpleNoteTableViewCell.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 21.05.23.
//

import UIKit
import SnapKit

final class SimpleNoteTableViewCell: UITableViewCell {
    //MARK: GUI variables
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightYellow
        view.layer.cornerRadius = 10
        
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
    func set(note: Note) {
        titleLabel.text = note.title 
    }
    
    //MARK: - Private methods
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            
            titleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
        }
    }
}
