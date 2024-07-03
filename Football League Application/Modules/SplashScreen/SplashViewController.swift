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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                    guard let homeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController else {
                        print("Error: Could not instantiate HomeNavigationController")
                        return
                    }
                    
                    self.view.window?.rootViewController = homeNavigationController
                    self.view.window?.makeKeyAndVisible()
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

