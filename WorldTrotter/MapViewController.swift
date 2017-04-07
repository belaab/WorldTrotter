// IB
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    //var myPosition = CLLocationCoordinate2D()
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBAction func startGPS(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
    
        
        let standardString = NSLocalizedString("Standard", comment: "standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "hybrid map view")
        let satelliteString = NSLocalizedString("satellite", comment: "satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 120)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let locCoor = CLLocationCoordinate2D(latitude: 50.0660719, longitude: 19.91942519999)
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = locCoor
        annotaion.title = "My university"
        mapView.addAnnotation(annotaion)
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let numfor = NumberFormatter()
        numfor.numberStyle = .decimal
        numfor.minimumFractionDigits = 0
        numfor.maximumFractionDigits = 4
        return numfor
    }()
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        
        let latestLocation: CLLocation = newLocations.last!
        
        print("Got location:\(numberFormatter.string(from: NSNumber(value: latestLocation.coordinate.latitude)),  (numberFormatter.string(from: NSNumber(value: latestLocation.coordinate.longitude))))")
        
        //myPosition = latestLocation.coordinate
        
        lblLocation.text = "\((numberFormatter.string(from: NSNumber(value: latestLocation.coordinate.latitude))!)), \((numberFormatter.string(from: NSNumber(value: latestLocation.coordinate.longitude))!))"

        //myPosition = latestLocation.coordinate
        //locationManager.stopUpdatingLocation()

        
        let span = MKCoordinateSpanMake(0.05, 0.05) //zoom level
        let region = MKCoordinateRegion(center: latestLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)

        
    }
    
}






