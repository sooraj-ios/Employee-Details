//
//  AppActivityIndicator.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit
class ActivityIndicator: UIView {

    private var activityIndicator: UIActivityIndicatorView!
    private var backgroundView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func show() {
        if let window = UIApplication.shared.windows.first {
            self.frame = window.bounds
            window.addSubview(self)
            activityIndicator.startAnimating()
        }
    }

    func hide() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
}
