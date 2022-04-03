//
//  ViewController.swift
//  TimerAnimated
//
//  Created by Alexander Avdacev on 3.04.22.
//

import UIKit

class ViewController: UIViewController {

    let lessonLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello my friend"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 84)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Start", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let pauseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Pause", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var  timer = Timer()
    var durationTimer = 3
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    var shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(durationTimer)"
        view.backgroundColor = .white
        setConstraints()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
//        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    
    @objc func startButtonTapped() {
        if durationTimer == 0 {
            durationTimer = 3
            timerLabel.text = "\(durationTimer)"
        }
        basicAnimations ()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
       
       
    }
//    @objc func pauseButtonTapped() {
//
//        timer.invalidate()
//        DispatchQueue.main.async(){
////            self.shapeView.layer.removeAllAnimations()
////            self.shapeView.layoutIfNeeded()
//            self.shapeView.layer.sublayers?.forEach {
//                        $0.speed = 0
//                        $0.removeAllAnimations()
//                        //$0.removeFromSuperlayer()
//                    }
//
//        }
//        UIViewPropertyAnimator(duration: 2, dampingRatio: 0.4, animations: {
//            view.backgroundColor = .blue
//        })
//        animator.stopAnimation(true)
//    }
    
    @objc func timerAction() {
        if durationTimer > 0 {
            durationTimer -= 1
        }else {
            timer.invalidate()
            durationTimer = 3
        }
        timerLabel.text = "\(durationTimer)"
        
    }
    
    func animationCircular() {
        
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimations () {
       // let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation,forKey: "basicAnimation")
    }
    
    func setConstraints() {
        view.addSubview(lessonLabel)
        view.addSubview(startButton)
        view.addSubview(pauseButton)
        view.addSubview(shapeView)
        shapeView.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            lessonLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            lessonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lessonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 300),
            shapeView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            pauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: 70),
            pauseButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

}

