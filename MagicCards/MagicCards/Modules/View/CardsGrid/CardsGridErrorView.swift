//
//  CardsGridErrorView.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 25/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardsGridErrorView: UIView {

    // MARK: - Variables
    weak var delegate: CardsGridErrorViewDelegate?
    
    // MARK: Subviews
    
    private let wrapperView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let mainText: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        view.textAlignment = .center
        view.textColor = .white
        view.numberOfLines = 0
        view.text = "Sorry, something went wrong."
        return view
    }()
    
    private let secondaryText: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        view.textAlignment = .center
        view.textColor = .white
        view.numberOfLines = 0
        view.text = "Press the buttom bellow\n to try again."
        return view
    }()
    
    private let retryButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "baseline_refresh_white_36pt"), for: .normal)
        view.addTarget(view, action: #selector(retryFetchAction), for: .allTouchEvents)
        view.tintColor = .white
        return view
    }()
    
    // MARK: - Methods
    
    // MARK: Initializers
    
    required init(frame: CGRect = .zero, delegate: CardsGridErrorViewDelegate?) {
        super.init(frame: frame)
        let action = UITapGestureRecognizer(target: self, action: #selector(retryFetchAction))
        self.addGestureRecognizer(action)
        self.delegate = delegate
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func retryFetchAction() {
        self.delegate?.retryFetchAction()
    }
    
}

// MARK: - ViewCode

extension CardsGridErrorView: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubview(wrapperView)
        self.wrapperView.addSubview(mainText)
        self.wrapperView.addSubview(secondaryText)
        self.wrapperView.addSubview(retryButton)
    }
    
    func setupContraints() {
        self.wrapperView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().multipliedBy(0.8)
            maker.width.equalToSuperview().multipliedBy(0.8)
        }
        self.mainText.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview()
        }
        self.secondaryText.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(self.mainText.snp.bottom).offset(16)
        }
        self.retryButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(self.secondaryText.snp.bottom).offset(24)
            maker.height.width.equalTo(32)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    }
}

// MARK: - Protocol definition

protocol CardsGridErrorViewDelegate: AnyObject {
    
    func retryFetchAction()
}

