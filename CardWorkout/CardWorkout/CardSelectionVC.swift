//
//  CardSelectionVC.swift
//  CardWorkout
//
//  Created by João Madruga on 05/11/22.
//

import UIKit

class CardSelectionVC: UIViewController {

    @IBOutlet var cardImageView: UIImageView!
    
    @IBOutlet var stopButton: UIButton!
    
    var cards: [UIImage] = Card.allValues
    
    var timer: Timer!
    
    var hasStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(showRandomImage), userInfo: nil, repeats: true)
    }
    
    @objc func showRandomImage() {
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AS")
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopButton.configuration?.attributedTitle = AttributedString("Start!", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .bold)]))
        stopButton.setImage(UIImage(systemName: "restart"), for: .normal)
        timer.invalidate()
        if (!hasStarted) {
            startTimer()
            stopButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            stopButton.configuration?.attributedTitle = AttributedString("Stop!", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .bold)]))
        }
        hasStarted = !hasStarted
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        startTimer()
        stopButton.configuration?.attributedTitle = AttributedString("Stop!", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .bold)]))
        stopButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
        hasStarted = !hasStarted
    }
}
