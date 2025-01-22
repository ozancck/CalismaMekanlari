//
//  MainViewController.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 22.01.2025.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("📱 MainViewController - viewDidLoad başlıyor")
        print("🔍 NavigationController durumu: \(String(describing: navigationController))")
        print("🔍 TabBarController durumu: \(String(describing: tabBarController))")
        print("🔍 View durumu: \(String(describing: view))")
        print("🔍 View frame: \(String(describing: view.frame))")
        print("🔍 SafeArea durumu: \(String(describing: view.safeAreaLayoutGuide))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("📱 MainViewController - viewWillAppear")
        print("🔍 NavigationController durumu: \(String(describing: navigationController))")
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("📱 MainViewController - viewDidAppear")
        print("🔍 View tam ekran durumu: \(view.window?.isKeyWindow == true)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("📱 MainViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("📱 MainViewController - viewDidDisappear")
        print("🔍 View memory durumu: \(String(describing: view))")
    }
}
