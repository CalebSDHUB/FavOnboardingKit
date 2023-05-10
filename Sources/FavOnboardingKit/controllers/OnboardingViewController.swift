//
//  File.swift
//  
//
//  Created by Caleb Danielsen on 09.05.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    var nextButtonDidTap: ((Int) -> Void)?
    var getStartedButtonTap: (() -> Void)?
    
    private let slides: [Slide]
    private let tintColor: UIColor
    private let themeFont: UIFont
    
    private lazy var transitionView: TransitionView = {
        let view = TransitionView(slides: slides, tintColor: tintColor, themeFont: themeFont)
        return view
    }()
    
    private lazy var buttonContailerView: buttonContainerView = {
        let view = buttonContainerView(tintColor: tintColor)
            view.nextButtonDidTap = { [weak self] in
                guard let self = self else { return }
                self.nextButtonDidTap?(self.transitionView.index)
                self.transitionView.handleTap(direction: .right)
        }
        view.getStartedButtonDidTap = getStartedButtonTap
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            transitionView,
            buttonContailerView
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(slides: [Slide], tintColor: UIColor, themeFont: UIFont) {
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    public func stopAnimation() {
        transitionView.stop()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        buttonContailerView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        transitionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewDidTap(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        let midPoint = view.frame.size.width / 2
        if point.x > midPoint {
            transitionView.handleTap(direction: .right)
        } else {
            transitionView.handleTap(direction: .left)
        }
    }
}
