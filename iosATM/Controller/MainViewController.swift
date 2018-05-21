//
//  MainViewController.swift
//  iosATM
//
//  Created by Daniel Vega on 5/17/18.
//  Copyright © 2018 Daniel Vega. All rights reserved.
//
import UIKit
import MapKit
import SwiftLocation
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mainMap: MKMapView!
    private var atmList:ATMlist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //map delegates
        self.mainMap.delegate = self
        self.mainMap.showsUserLocation = true
        //Get Current Location
        Locator.currentPosition(accuracy: .room, onSuccess: {
            location in self.centerMapCurrentLocation(location: location); },
                                onFail: { _,_ in print("failed to get the current location"); })
        self.getAtmInformation()
    }
    
    func getAtmInformation() {
        //show activity indicator
        let sv = UIViewController.displaySpinner(onView: self.view)
        //Get ATM location's list
        let dm = HTTPHelper()
        dm.getAtmList { (list, error) in
            if !error {
                //remove activity indicator
                UIViewController.removeSpinner(spinner: sv)
                //show information on map
                self.setAtmLocationsOnMap(atmList: list)
            }else{
                //if we can get data => show message to user.
                let alert = UIAlertController(title: "Can't reach server", message: "Please try again later", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.getAtmInformation()}))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKMarkerAnnotationView
        if pinView == nil {
            //create my own MarkerView
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            let customPointAnnotation = annotation as! CustomPinAnnotation
            pinView?.markerTintColor = customPointAnnotation.pinColor
            pinView?.glyphText = customPointAnnotation.pinText
            
            //create image with gesture recognize
            let calloutImage = UIImageView.init(image: customPointAnnotation.pinCallOutImage)
            let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAtmDetails(tapGestureRecognizer:)))
            calloutImage.isUserInteractionEnabled = true
            //use gesture name to pass atm ID
            imageGestureRecognizer.name = customPointAnnotation.id.description
            calloutImage.addGestureRecognizer(imageGestureRecognizer)
            pinView!.rightCalloutAccessoryView = calloutImage
            
            //pinView!.rightCalloutAccessoryView = UIImageView.init(image: customPointAnnotation.pinCallOutImage)
            pinView!.canShowCallout = true
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    @objc func showAtmDetails(tapGestureRecognizer: UITapGestureRecognizer) {
        let senderATM:Atm!
        let atmID:Int = Int(tapGestureRecognizer.name!)!
        //get atm instance from atmID
        if let foundATM = atmList.getAtmList().first(where: { $0.getId() == atmID }) {
            senderATM = foundATM
        } else {
            senderATM = nil
        }
        self.performSegue(withIdentifier: "showAtmDetails", sender: senderATM)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAtmDetails" {
            if let atm = sender as? Atm {
                let controller = segue.destination as! AtmDeailViewController
                controller.atm = atm
            }
        }
    }
    
    func centerMapCurrentLocation(location:CLLocation) {
        //center Map based on my current location.
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mainMap.setRegion(region, animated: true)
    }
    
    func setAtmLocationsOnMap(atmList:ATMlist) {
        self.atmList = atmList
        for atm in atmList.getAtmList() {
            let pinColor:UIColor!
            switch atm.getStatus() {
            case "exploded":
                pinColor = UIColor.red
                break
            case "normal":
                pinColor = UIColor.init(red: 51/255, green: 204/255, blue: 51/255, alpha: 1)
                break
            case "out of order":
                pinColor = UIColor.yellow
                break
            default:
                pinColor = UIColor.init(red: 51/255, green: 204/255, blue: 51/255, alpha: 1)
            }
            
            let annotation = CustomPinAnnotation(id: atm.getId(), pinColor: pinColor, pinImage: UIImage(named: atm.getNetwork())!, pinText: atm.getNetwork())
            annotation.coordinate = CLLocationCoordinate2D(latitude: atm.getLatitude(), longitude: atm.getLongitude())
            annotation.title = atm.getAddress()
            if atm.getHasMoney() {
                if atm.getAcceptDeposits() {
                    annotation.subtitle = "Has money | Deposits"
                } else {
                    annotation.subtitle = "Has money"
                }
            } else if atm.getAcceptDeposits() {
                annotation.subtitle = "Deposits"
            }
            
            self.mainMap.addAnnotation(annotation)
        }
    }
}
