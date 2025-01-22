//
//  OnboardingViewController.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 22.01.2025.
//

import SwiftUI
import UIKit

private let reuseIdentifier = "Cell"

class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var slides: [OnboardingSlide] = []

    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            updateButtonTitle()
        }
    }

    @IBOutlet var nxtBtn: UIButton!
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //hide navigation bar
        self.navigationController?.isNavigationBarHidden = true

         slides = [
            OnboardingSlide(
                title: "Çalışma Mekanlarını Kolayca Keşfet",
                mainTitles: [
                    MainTitle(title: "Yakındaki mekanları gör", description: "Çalışmak için ideal mekanları harita üzerinde anında keşfet.", image: "map-location-dot-sharp-solid"),
                    MainTitle(title: "Mesleklerine göre filtrele", description: "Kendin gibi profesyonellerin tercih ettiği mekanları bul.", image: "arrow-up-a-z-duotone-solid"),
                    MainTitle(title: "Hızlıca başla", description: "Sadece adını, soyadını ve mesleğini girerek çalışmaya başla.", image: "user-plus-regular")
                ]
            ),
            OnboardingSlide(
                title: "Mekanları Paylaş ve Puanla",
                mainTitles: [
                    MainTitle(title: "Mekan ekle", description: "Çalıştığın veya önerdiğin mekanları topluluğa ekle.", image: "books-medical-regular"),
                    MainTitle(title: "Detaylı puanlama yap", description: "Mekanların internet, sessizlik ve hizmet kalitesini değerlendir.", image: "star-solid"),
                    MainTitle(title: "Açıklamalarını paylaş", description: "Mekanlarla ilgili deneyimlerini ve ipuçlarını diğer kullanıcılarla paylaş.", image: "comments-sharp-solid")
                ]
            ),
            OnboardingSlide(
                title: "Kendine Özel Çalışma Alanını Bul",
                mainTitles: [
                    MainTitle(title: "Yakındaki mekanları listele", description: "Konumuna en yakın mekanları kolayca görüntüle.", image: "map-location-dot-regular"),
                    MainTitle(title: "Sana özel mekanlar", description: "Meslek filtreleriyle daha özel mekanlarda çalış.", image: "sparkles-solid"),
                    MainTitle(title: "Topluluğun bir parçası ol", description: "Çalışma alanı topluluğuna katılarak herkes için daha iyi mekanlar oluştur.", image: "file-signature-solid")
                ]
            )
        ]

        // Page Control ayarları
        pageController.numberOfPages = slides.count
        pageController.currentPage = 0

        // Başlangıç buton ayarı
        updateButtonTitle()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.setCollectionViewLayout(OnboardingViewController.crateLayout(), animated: false)

        // Nib ile oluşturulan cell'i register etme
        let nib = UINib(nibName: "OnboardingCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")

        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        nxtBtn.setTitle("Next", for: .normal)
        
    }

    // MARK: - UICollectionView

    static func crateLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection in

            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

                item.contentInsets.trailing = 15
                item.contentInsets.leading = 15
                item.contentInsets.bottom = 15

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .paging

                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

                item.contentInsets.trailing = 15
                item.contentInsets.leading = 15
                item.contentInsets.bottom = 15

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .paging

                return section
            }
        }
    }

    // willDisplay ile current page'i takip edelim
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentPage = indexPath.item
        updateButtonTitle()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIViewController()

        print("Selected item at  section 1\(indexPath)")
        controller.view.backgroundColor = .systemRed
        controller.navigationItem.title = "Section 1, Item \(indexPath.item)"

        navigationController?.pushViewController(controller, animated: true)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return cellForSection1(collectionView: collectionView, indexPath: indexPath)
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        cell.backgroundColor = .systemYellow

        return cell
    }

    func cellForSection1(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.item])
        

        return cell
    }

    // MARK: - button action

    // Next butonu için action
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let destinationVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                navigationController?.pushViewController(destinationVC, animated: true)
            }
            
            
            print("Get Started tapped - Onboarding bitti")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            updateButtonTitle()
        }
    }

    // MARK: - Scroll Delegate Methods

    // Sadece bu scroll delegate metodunu kullanalım, diğerlerini kaldırabiliriz
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentIndex = Int(round(scrollView.contentOffset.x / width))
        pageController.currentPage = currentIndex
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let width = scrollView.frame.width
        let targetPage = Int(targetContentOffset.pointee.x / width)
        currentPage = targetPage
        updateButtonTitle()
    }

    func updateButtonTitle() {
        if currentPage == slides.count - 1 {
            nxtBtn.setTitle("Get Started", for: .normal)
            nxtBtn.tintColor = .systemTeal
        } else {
            nxtBtn.setTitle("Next", for: .normal)
            nxtBtn.tintColor = .systemBlue
        }
    }
}
