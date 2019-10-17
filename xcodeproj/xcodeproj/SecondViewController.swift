
//  SecondViewController.swift
//  xcodeproj
//
//  Created by Bazil Philani GUMEDE on 2019/10/14.
//  Copyright © 2019 Bazil Philani GUMEDE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


var longitude = 28.040020
var latitude = -26.205080

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var Mapview: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    
        let initialCoordinate = CLLocation(latitude: -26.205080, longitude: 28.040020)
        let regionRadius: CLLocationDistance = 1000
        func CenterMapOnLocation(location: CLLocation)
        {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            Mapview.setRegion(coordinateRegion, animated: true)
        }
        CenterMapOnLocation(location: initialCoordinate)
    
  
            let Inipin = iniPin(latitude: latitude, longitude: longitude, locationName: "Wethinkcode", title: "42", coordinate: CLLocationCoordinate2D(
                latitude: latitude, longitude: longitude))
        Mapview.addAnnotation(Inipin)
    }
    
    func didRecieveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex{
        case 0:
            Mapview.mapType = MKMapType.standard
            break
        case 1:
            Mapview.mapType = MKMapType.satellite
            break
        case 2:
            Mapview.mapType = MKMapType.hybrid
        default:
            break
        }
    }
    
    


class iniPin: NSObject, MKAnnotation {
   
    var locationName: String?
    var title: String?
    var latitude: Double?
    var longitude: Double?
     var coordinate: CLLocationCoordinate2D
  
    init(latitude: Double, longitude:Double, locationName: String,title: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.latitude = latitude
        self.longitude = longitude
        self.locationName = locationName
        self.title = title
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
}
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation = locations[0]
//        let latDelta:CLLocationDegrees = 0.05
//        let lonDelta:CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: mylocation, span: span)
        Mapview.setRegion(region, animated: true)
        Mapview.showsUserLocation = true

        let pin = MKPointAnnotation()
        pin.coordinate.latitude = userLocation.coordinate.latitude
        pin.coordinate.longitude = userLocation.coordinate.longitude
        pin.title = "Moving"
        Mapview.addAnnotation(pin)


    }

}

