//
//  ViewController.swift
//  Football League Application
//
//  Created by mariam adly on 01/07/2024.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private let animationView = LottieAnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
               let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
        }
    private func setupAnimations(){
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: 400)
        animationView.center = view.center
        view.addSubview(animationView)
        animationView.animation = .named("sport")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }


}

