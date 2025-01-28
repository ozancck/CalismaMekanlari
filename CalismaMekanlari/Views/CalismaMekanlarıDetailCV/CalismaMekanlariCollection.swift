//
//  CalismaMekanlariCollection.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 27.01.2025.
//

import SwiftUI
import UIKit

private let reuseIdentifier = "Cell"

class CalismaMekanlariCollection: UICollectionViewController {
    static let categoryHeaderId = "categoryHeaderId"
    let headerId = "headerId"

    
    
     init() {
         super.init(collectionViewLayout: CalismaMekanlariCollection.crateLayout())
     }
     
     
         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
     
 
    
//    required init?(coder: NSCoder) {
//        super.init(collectionViewLayout: CalismaMekanlariCollection.crateLayout())
//    }

    static func crateLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection in

            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)))

             
                item.contentInsets.bottom = 75

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(250)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .paging
                
               

                return section
            }else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

                
                

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                


                return section
                
            }else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)))
                

                item.contentInsets.trailing = 5
                item.contentInsets.leading = 5
                item.contentInsets.bottom = 15

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets.leading = 15
                section.contentInsets.trailing = 15
              


                return section
            }
            else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

                item.contentInsets.trailing = 15
                item.contentInsets.bottom = 15

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets.leading = 15

                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), elementKind: categoryHeaderId, alignment: .topLeading),
                ]

                return section
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      

        if indexPath.section == 0 {
            print("Selected item at  section 1\(indexPath)")
         
        } else {
            print("Selected item at section 5\(indexPath)")
          
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        // Nib ile oluşturulan cell'i register etme
        let nib = UINib(nibName: "CalismaMekanlariDetailHeaderCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CalismaMekanlariDetailHeaderCell")
        
        let nib2 = UINib(nibName: "CalismaMekanlariDetailBoxCell", bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: "CalismaMekanlariDetailBoxCell")
   
        
        

 
        //hide navigaton
        self.navigationController?.isNavigationBarHidden = true
        
        //ignore safe are
        collectionView.contentInsetAdjustmentBehavior = .never
        
        

        collectionView.register(Header.self, forSupplementaryViewOfKind: CalismaMekanlariCollection.categoryHeaderId, withReuseIdentifier: headerId)

        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header

        switch indexPath.section {
        case 1:
            header.label.text = "Yemekhane"
      
        default:
            header.label.text = "Birinci Section Başlığı"
        }

        return header
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 5
        }

        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return cellForSection1(collectionView: collectionView, indexPath: indexPath)
        }
        else if indexPath.section == 1 {
            return cellForSection2(collectionView: collectionView, indexPath: indexPath)
        }
        else if indexPath.section == 2 {
            return cellForSection3(collectionView: collectionView, indexPath: indexPath)
        }
        
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        //add image view like backgorund
        

        cell.backgroundColor = .systemYellow

        return cell
    }

    func cellForSection1(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // ChangePasswordCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        cell.backgroundView = imageView


        return cell
    }
    
    func cellForSection2(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // ChangePasswordCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalismaMekanlariDetailHeaderCell", for: indexPath) as! CalismaMekanlariDetailHeaderCell
     

        return cell
    }
    
    func cellForSection3(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // ChangePasswordCell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalismaMekanlariDetailBoxCell", for: indexPath) as! CalismaMekanlariDetailBoxCell
        cell.titleLbl.text = "Ortamdaki Gürültü Seviyesi"

        return cell
    }
    
    
    /*
    
    func cellForSection2(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // ChangePasswordCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCellCollection", for: indexPath) as! FoodCellCollection
        
        cell.imageview.image = UIImage(systemName: "person")
        cell.imageview.contentMode = .scaleAspectFill
        cell.imageview.backgroundColor = .red
        cell.imageview.addCornerRadius()
    
        cell.arrowImage.image = UIImage(named: "ArrowRight")
        cell.backgroundCell.backgroundColor = .cellBackground

        return cell
    }
    
    func cellForSection3(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // ChangePasswordCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteScreensButtonCell", for: indexPath) as! FavoriteScreensButtonCell
        cell.imageview.image = UIImage(systemName: "person")
        
        cell.imageview.contentMode = .scaleAspectFill
        
        cell.iconBackground.backgroundColor = .cellBackground
        
        cell.iconBackground.layer.cornerRadius =  cell.iconBackground.frame.size.width / 2
        cell.iconBackground.clipsToBounds = true
        
        cell.screenTitle.text = "Bizden Haberler"
        
        
        
      

        return cell
    }
    
    func cellForSection4(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticesFromUsCollectionCell", for: indexPath) as! NoticesFromUsCollectionCell
        cell.imageview.image = UIImage(systemName: "person")
        cell.imageview.backgroundColor = .red
        cell.imageview.contentMode = .scaleAspectFill
        cell.mainTitle.text = "Başlık"
        cell.bodyTitle.text = "Alt Başlık altdsfdsfdsfdsfsdfsdfs"
        
        return cell
    }
    
    func cellForSection5(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortCutCollectionCell", for: indexPath) as! ShortCutCollectionCell
        cell.imageview.image = UIImage(systemName: "person")
        cell.imageview.contentMode = .scaleAspectFill
        cell.imageview.backgroundColor = .red
        cell.mainTitle.text = "Başlık"
        cell.bodyTitle.text = "Alt Başlık altdsfdsfdsfdsfsdfsdfs"
        
        return cell
    }
    
     */
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }

        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: CalismaMekanlariCollection())
        }

        typealias UIViewControllerType = UIViewController
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

class Header: UICollectionReusableView {
    let label = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(label)

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // İçeriden 15 point padding (Collection view'daki diğer hücrelere uygun olarak)
        let padding: CGFloat = 15

        // Label için frame ayarı
        let labelWidth = bounds.width * 0.7
        label.frame = CGRect(
            x: padding, // Sol padding eklendi
            y: 0,
            width: labelWidth - padding, // padding'i düşürüyoruz
            height: bounds.height
        )
        

       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

