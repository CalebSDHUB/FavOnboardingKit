//
//  File.swift
//  
//
//  Created by Caleb Danielsen on 09.05.2023.
//

import UIKit
import SnapKit

final class buttonContainerView: UIView {
    var nextButtonDidTap: (() -> Void)?
    var getStartedButtonDidTap: (() -> Void)?
    
    private var viewTintColor: UIColor
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = viewTintColor.cgColor
        button.setTitleColor(viewTintColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.backgroundColor = viewTintColor
        button.layer.cornerRadius = 12
        button.layer.shadowColor = viewTintColor.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.layer.shadowRadius = 8
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nextButton, getStartedButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    
    init(tintColor: UIColor) {
        viewTintColor = tintColor
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
        }
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(getStartedButton.snp.width).multipliedBy(0.5)
        }
    }
    
    @objc private func nextButtonTapped() {
        nextButtonDidTap?()
    }
    
    @objc private func getStartedButtonTapped() {
        getStartedButtonDidTap?()
    }
}
