//
//  SceneDelegate.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 22.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        do {
            guard let windowScene = (scene as? UIWindowScene) else { 
                print("⛔️ WindowScene oluşturulamadı")
                return 
            }
            print("✅ WindowScene oluşturuldu")
            window = UIWindow(windowScene: windowScene)
               
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            print("✅ Storyboard yüklendi")
               
            if UserDefaults.standard.string(forKey: "userName") != nil {
                print("✅ UserDefaults bulundu: \(UserDefaults.standard.string(forKey: "userName") ?? "")")
                print("⚙️ TabBarController oluşturulmaya başlıyor...")
                
                let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                print("✅ TabBarController başarıyla oluşturuldu: \(mainTabBarController)")
                
                window?.rootViewController = mainTabBarController
                print("✅ RootViewController başarıyla set edildi")
            } else {
                print("⚠️ UserDefaults bulunamadı")
                let onBoardView = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
                window?.rootViewController = onBoardView
            }
               
            window?.makeKeyAndVisible()
            print("✅ Window görünür yapıldı")
            
        } catch {
            print("❌ KRITIK HATA: \(error.localizedDescription)")
            print("❌ HATA DETAYI: \(error)")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("⚠️ Scene bağlantısı koptu")
        print("🔍 Window durumu: \(String(describing: window))")
        print("🔍 RootViewController durumu: \(String(describing: window?.rootViewController))")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("🚀 Scene aktif oldu")
        print("🔍 Window durumu: \(String(describing: window))")
        print("🔍 RootViewController durumu: \(String(describing: window?.rootViewController))")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("⚠️ Scene inactive olacak")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("🔄 Scene ön plana gelecek")
        print("🔍 Window durumu: \(String(describing: window))")
        print("🔍 RootViewController durumu: \(String(describing: window?.rootViewController))")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("⏬ Scene arka plana geçti")
    }
}
