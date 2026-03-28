//
//  ViewController.swift
//  Travelbook
//
//  Created by Zeki Mac on 28.03.2026.
//
// kCLLocationAccuracyBest => çok kesin konumu bulur ama çok yorar

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var contentText: UITextField!
    
    var locationManager = CLLocationManager()
    var chosenLatitude:Double?
    var chosenLongitude:Double?
    var chosenId:UUID?
    var annotationTitle=""
    var annotationSubtitle=""
    var annotationLatitude=Double()
    var annotationLongitude=Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //çok kesin konumu bulur ama çok yorar
        locationManager.requestWhenInUseAuthorization() // sürekli konumu almasın diye
        locationManager.startUpdatingLocation()
        
        btnSave.isEnabled=false
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if chosenId != nil {
            fetchData()
            btnSave.isHidden=true
        }else{
            btnSave.isHidden=false
        }
    }
    
    func fetchData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Places")
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", chosenId!.uuidString)
        do{
            let results = try context.fetch(fetchRequest)
            if results.count>0{
                for item in results as! [NSManagedObject]{
                    if let title = item.value(forKey: "title") as? String{
                        annotationTitle=title
                    }
                    if let subtitle = item.value(forKey: "subtitle") as? String{
                        annotationSubtitle=subtitle
                    }
                    if let latitude = item.value(forKey: "latitude") as? Double{
                        annotationLatitude=latitude
                    }
                    if let longitude = item.value(forKey: "longitude") as? Double{
                        annotationLongitude=longitude
                    }
                    let annotation=MKPointAnnotation()
                    annotation.title=annotationTitle
                    annotation.subtitle=annotationSubtitle
                    let coordinate=CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                    annotation.coordinate=coordinate
                    mapView.addAnnotation(annotation)
                    nameText.text=annotationTitle
                    contentText.text=annotationSubtitle
                    
                    locationManager.stopUpdatingLocation()
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5) // Zoomlama
                    let region = MKCoordinateRegion(center: coordinate, span: span) // istediğimiz konuma gönderebiliriz
                    mapView.setRegion(region, animated: true)
                    
                }
            }
            
        }catch {
            print("Error")
        }
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let locationCoordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationCoordinate
            annotation.title = nameText.text
            annotation.subtitle = contentText.text
            self.mapView.addAnnotation(annotation)
            chosenLatitude=locationCoordinate.latitude
            chosenLongitude=locationCoordinate.longitude
            btnSave.isEnabled=true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if chosenId == nil {
            let location=CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // Zoomlama
            let region = MKCoordinateRegion(center: location, span: span) // istediğimiz konuma gönderebiliriz
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Places", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        newItem.setValue(nameText.text, forKey: "title")
        newItem.setValue(contentText.text, forKey: "subtitle")
        newItem.setValue(chosenLatitude, forKey: "latitude")
        newItem.setValue(chosenLongitude, forKey: "longitude")
        newItem.setValue(UUID(), forKey: "uuid")
        
        do{
            try context.save()
            print("Success")
        }catch {
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let reuseId="myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        
        if pinView == nil{
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout=true
            pinView?.tintColor = UIColor.black
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation=annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if chosenId != nil {
            var requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            openNavigation(enlem: annotationLatitude, boylam: annotationLongitude, mekanAdi: annotationTitle)
        }
    }
    
    func openNavigation(enlem: CLLocationDegrees, boylam: CLLocationDegrees, mekanAdi: String = "Hedef") {
        let urlString = "http://maps.apple.com/?daddr=\(enlem),\(boylam)&dirflg=d"
        
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
