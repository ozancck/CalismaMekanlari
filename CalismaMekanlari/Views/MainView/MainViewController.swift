//
//  MainViewController.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 22.01.2025.
//

import CoreLocation
import MapKit
import UIKit

class MainViewController: UIViewController {
    @IBOutlet var mapkit: MKMapView!
    private let locationManager = CLLocationManager()

    @IBOutlet var filterView: UIView!
    @IBOutlet var searchImage: UIImageView!
    @IBOutlet var switchImage: UIImageView!
    @IBOutlet var switchBackground: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapkit.delegate = self
        setupMapView()
        setupLocationManager()
        addSampleCoffeeShops()

        setupFilterView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    func setupFilterView() {
        switchBackground.backgroundColor = .clear
        switchBackground.layer.cornerRadius = switchBackground.frame.height / 2
        switchBackground.layer.borderWidth = 1
        switchBackground.layer.borderColor = UIColor.darkCellBackground.cgColor

        // add shadow
        filterView.layer.shadowColor = UIColor.black.cgColor
        filterView.layer.shadowOpacity = 0.08
        filterView.layer.shadowOffset = CGSize(width: 0, height: 2)
        filterView.layer.shadowRadius = 2
        filterView.layer.masksToBounds = false

        filterView.addGesture {
            self.goNewViewController()
        }
    }

    func goNewViewController() {
        let vc = storyboard?.instantiateViewController(identifier: "FilterMapViewController") as! FilterMapViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupMapView() {
        mapkit.showsCompass = false
        // mapkit.showsScale = true
        mapkit.showsUserTrackingButton = true

        mapkit.showsUserLocation = true
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Konum izni kontrolü
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }

    private func zoomToUserLocation(location: CLLocation) {
        // 10km yarıçapında zoom
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 3000, // 10km
            longitudinalMeters: 3000 // 10km
        )
        mapkit.setRegion(region, animated: true)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        zoomToUserLocation(location: location)
        // Sürekli zoom yapmasını istemiyorsak konum güncellemeyi durdurabiliriz
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
}

extension MainViewController: MKMapViewDelegate {
    private func addSampleCoffeeShops() {
        let sampleCoffeeShops = [
            CoffeePlaceAnnotation(
                id: "1",
                name: "Kötekli Kahve Durağı",
                rating: 4.5,
                coordinate: CLLocationCoordinate2D(latitude: 37.1777, longitude: 28.3722)
            ),
            CoffeePlaceAnnotation(
                id: "2",
                name: "Kampüs Coffee Lab",
                rating: 4.2,
                coordinate: CLLocationCoordinate2D(latitude: 37.1835, longitude: 28.3850)
            ),
            CoffeePlaceAnnotation(
                id: "3",
                name: "Kötekli Express Coffee",
                rating: 4.7,
                coordinate: CLLocationCoordinate2D(latitude: 37.1720, longitude: 28.3680)
            ),
            CoffeePlaceAnnotation(
                id: "4",
                name: "Merkez Coffee House",
                rating: 4.4,
                coordinate: CLLocationCoordinate2D(latitude: 37.2154, longitude: 28.3636)
            ),
            CoffeePlaceAnnotation(
                id: "5",
                name: "Menteşe Kahve",
                rating: 4.6,
                coordinate: CLLocationCoordinate2D(latitude: 37.2185, longitude: 28.3720)
            ),
            CoffeePlaceAnnotation(
                id: "6",
                name: "Muğla Coffee Roasters",
                rating: 4.8,
                coordinate: CLLocationCoordinate2D(latitude: 37.2110, longitude: 28.3590)
            ),
            CoffeePlaceAnnotation(
                id: "7",
                name: "Kötekli Study Cafe",
                rating: 4.3,
                coordinate: CLLocationCoordinate2D(latitude: 37.1745, longitude: 28.3795)
            ),
            CoffeePlaceAnnotation(
                id: "8",
                name: "Sınav Kahve",
                rating: 4.1,
                coordinate: CLLocationCoordinate2D(latitude: 37.1795, longitude: 28.3645)
            ),
            CoffeePlaceAnnotation(
                id: "9",
                name: "Merkez Kahve Atölyesi",
                rating: 4.9,
                coordinate: CLLocationCoordinate2D(latitude: 37.2095, longitude: 28.3725)
            ),
            CoffeePlaceAnnotation(
                id: "10",
                name: "Kötekli Kahve Durağı",
                rating: 4.0,
                coordinate: CLLocationCoordinate2D(latitude: 37.1755, longitude: 28.3880)
            ),
        ]

        mapkit.addAnnotations(sampleCoffeeShops)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let identifier = "CoffeeAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            if let originalImage = UIImage(named: "your-coffee-icon") {
                let size = CGSize(width: 40, height: 40)
                let renderer = UIGraphicsImageRenderer(size: size)
                let resizedImage = renderer.image { _ in
                    originalImage.draw(in: CGRect(origin: .zero, size: size))
                }

                annotationView?.image = resizedImage

                // Gölge ekleme
                annotationView?.layer.shadowColor = UIColor.black.cgColor
                annotationView?.layer.shadowOpacity = 0.3
                annotationView?.layer.shadowOffset = CGSize(width: 0, height: 2)
                annotationView?.layer.shadowRadius = 4
                annotationView?.layer.masksToBounds = false
            }

            annotationView?.centerOffset = CGPoint(x: 0, y: -15)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    // Seçilen annotation'ı özelleştirmek için
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if let annotationView = mapView.view(for: annotation) {
            // Seçilen ikonun görünümünü değiştir
            UIView.animate(withDuration: 0.3) {
                // İkonu büyüt
                annotationView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

                // Gölgeyi belirginleştir
                annotationView.layer.shadowOpacity = 0.5
                annotationView.layer.shadowRadius = 6
            }
        }

        if let coffeeAnnotation = annotation as? CoffeePlaceAnnotation {
            handleCoffeeTap(coffeePlace: coffeeAnnotation)
            mapView.deselectAnnotation(annotation, animated: false)
        }
    }

    // Seçim kaldırıldığında ikonu eski haline getir
    func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
        if let annotationView = mapView.view(for: annotation) {
            UIView.animate(withDuration: 0.3) {
                // İkonu normal boyuta getir
                annotationView.transform = .identity

                // Gölgeyi normale döndür
                annotationView.layer.shadowOpacity = 0.3
                annotationView.layer.shadowRadius = 4
            }
        }
    }

    private func handleCoffeeTap(coffeePlace: CoffeePlaceAnnotation) {
        let point = MKMapPoint(coffeePlace.coordinate)
        let rect = MKMapRect(x: point.x, y: point.y, width: 800, height: 800)
        mapkit.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 150, left: 200, bottom: 300, right: 50), animated: true)

        presentSheet()
    }

    // MARK: - sheet

    @objc func presentSheet() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // veya storyboard'ınızın adı
        let sheetViewController = storyboard.instantiateViewController(withIdentifier: "CalismaMekanlariCollection") // storyboard ID'si
        sheetViewController.modalPresentationStyle = .pageSheet

        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }

        present(sheetViewController, animated: true)
    }
    
    
    
}

class CoffeePlaceAnnotation: MKPointAnnotation {
    var id: String
    var name: String
    var rating: Double

    init(id: String, name: String, rating: Double, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.rating = rating
        super.init()
        self.coordinate = coordinate
    }
}
