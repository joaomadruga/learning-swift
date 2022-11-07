//
//  CardSelectionVC.swift
//  CardWorkout-Programmatic
//
//  Created by João Madruga on 05/11/22.
//

import UIKit

class CardSelectionVC: UIViewController {
    
    let cardImageView = UIImageView()
    let stopButton = CWButton(color: .systemRed, title: "Stop!", systemImageName: "stop.circle")
    let resetButton = CWButton(color: .systemGreen, title: "Reset", systemImageName: "arrow.clockwise")
    let rulesButton = CWButton(color: .systemBlue, title: "Rules", systemImageName: "list.bullet.clipboard")
    
    var cards: [UIImage] = CardDeck.allValues
    
    var timer: Timer!
    
    var hasStarted: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        startTimer()
    }
    
    func configureUI() {
        configureCardImageView()
        configureStopButton()
        configureResetButton()
        configureRulesButton()
    }
    
    func configureCardImageView() {
        view.addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.image = UIImage(named: "AS")
        
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 250),
            cardImageView.heightAnchor.constraint(equalToConstant: 350),
            cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75)
        ])
    }
    
    func configureStopButton() {
        view.addSubview(stopButton)
        
        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 260),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 30)
            ])
        
        stopButton.addTarget(self, action: #selector(runStopButton), for: .touchUpInside)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(showRandomImage), userInfo: nil, repeats: true)
    }
    
    @objc func showRandomImage() {
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AS")
    }
    
    @objc func runStopButton(_ sender: UIButton) {
        stopButton.configuration?.image = UIImage(systemName: "restart")
        stopButton.configuration?.attributedTitle = AttributedString("Start!", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .bold)]))
        timer.invalidate()
        if (!hasStarted) {
            startTimer()
            stopButton.configuration?.attributedTitle = AttributedString("Stop!", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .bold)]))
            stopButton.configuration?.image = UIImage(systemName: "stop.circle")
        }
        hasStarted = !hasStarted
    }
    
    @objc func restartButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        startTimer()
        stopButton.configuration?.attributedTitle = AttributedString("Stop!", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .bold)]))
        stopButton.configuration?.image = UIImage(systemName: "stop.circle")
        hasStarted = !hasStarted
    }
    
    func configureResetButton() {
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalToConstant: 115),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.leftAnchor.constraint(equalTo: stopButton.leftAnchor),
            resetButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
        
        resetButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
    }
    
    func configureRulesButton() {
        view.addSubview(rulesButton)
        rulesButton.addTarget(self, action: #selector(presentRulesVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rulesButton.widthAnchor.constraint(equalToConstant: 115),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.rightAnchor.constraint(equalTo: stopButton.rightAnchor),
            rulesButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func presentRulesVC() {
        present(RulesVC(), animated: true)
    }
}
