
import UIKit
import Mapbox

class MapViewController: UIViewController {
    
    @IBOutlet weak var startPolygonButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    fileprivate var mapView: MGLMapView!
    fileprivate var firstLoad = true
    fileprivate var locManager = LocationManager.instance
    fileprivate var singlePress: UITapGestureRecognizer!
    fileprivate var polygonCoords = [CLLocationCoordinate2D]()
    fileprivate var polygons = [[CLLocationCoordinate2D]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapbox()
        self.customizeInterface()
        self.locManager.delegate = self
        self.locManager.initialize()
    }
    
    fileprivate func setupMapbox() {
        let url = URL(string: "mapbox://styles/mapbox/satellite-streets-v10")
        self.mapView = MGLMapView(frame: self.view.bounds, styleURL: url)
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mapView.delegate = self
        self.view.insertSubview(self.mapView, at: 0)
    }
    
    fileprivate func customizeInterface() {
        
        self.startPolygonButton.translucentRounded()
        self.changePolygonButton(true)
        
        self.clearButton.translucentRounded()
        self.clearButton.setTitle("map_clearButton".localized(), for: .normal)
        
    }
    
    fileprivate func changePolygonButton(_ isNew: Bool) {
        
        self.startPolygonButton.setTitle("map_startPolygonButton_\((isNew ? "start" : "finish"))".localized(), for: .normal)
        
        guard isNew else {
            self.startPolygonButton.removeTarget(self, action: #selector(self.newPolygon(_:)), for: .touchUpInside)
            self.startPolygonButton.addTarget(self, action: #selector(self.finishPolygon(_:)), for: .touchUpInside)
            return
        }
        
        self.startPolygonButton.removeTarget(self, action: #selector(self.finishPolygon(_:)), for: .touchUpInside)
        self.startPolygonButton.addTarget(self, action: #selector(self.newPolygon(_:)), for: .touchUpInside)
        
    }
    
    fileprivate func setMapRegion(_ coordinate: CLLocationCoordinate2D) {
        self.mapView.setCenter(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), zoomLevel: 12, animated: true)
    }
    
    @IBAction func newPolygon(_ sender: UIButton) {
        self.changePolygonButton(false)
        self.addGestures()
        Alert.banner("map_startPolygonAction".localized(), state: .success, duration: 6.0)
    }
    
    fileprivate func addGestures() {
        self.singlePress = UITapGestureRecognizer(target: self, action: #selector(self.addPolygonCoord))
        self.mapView.addGestureRecognizer(singlePress)
    }
    
    fileprivate func removeGestures() {
        
        guard let press = self.singlePress else {
            return
        }
        
        self.mapView.removeGestureRecognizer(press)
        
    }
    
    @objc fileprivate func addPolygonCoord(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.mapView)
        let coordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        self.polygonCoords.append(coordinate)
        self.removeAnnotations()
        self.drawShape()
        AudioKit.vibrate()
    }
    
    @objc fileprivate func drawShape() {
        
        _ = self.polygons.map {
            let shape = MGLPolygon(coordinates: $0, count: UInt($0.count))
            self.mapView.addAnnotation(shape)
        }
        
        let shape = MGLPolygon(coordinates: self.polygonCoords, count: UInt(self.polygonCoords.count))
        self.mapView.addAnnotation(shape)
        
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        self.reset()
        self.polygons = [[CLLocationCoordinate2D]]()
        self.removeAnnotations(true)
    }
    
    fileprivate func reset() {
        self.polygonCoords = [CLLocationCoordinate2D]()
        self.removeGestures()
        self.changePolygonButton(true)
    }
    
    fileprivate func removeAnnotations(_ all: Bool = false) {
        
        _ = self.mapView.annotations?.map {
            guard !all, $0 is CustomAnn else {
                self.mapView.removeAnnotation($0)
                return
            }
        }
        
    }
    
    @objc fileprivate func finishPolygon(_ sender: UIButton) {
        self.polygons.append(self.polygonCoords)
        self.addAreaView(self.polygonCoords)
        self.reset()
    }
    
    fileprivate func addAreaView(_ polygon: [CLLocationCoordinate2D]) {
        
        let area = Area.regionArea(polygon)
        
        let point = CustomAnn()
        point.coordinate = self.polygonCoords.first!
        point.title = "\(String(describing: area.roundTo(2))) \("map_unity".localized())"
        point.subtitle = "map_polygon_area".localized()
        point.id = "area"
        self.mapView.addAnnotation(point)
        
        self.mapView.selectAnnotation(point, animated: true)
        
    }

}

extension MapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.5
    }
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return .red
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return .purple
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = CustomAnnView(reuseIdentifier: reuseIdentifier)
            annotationView!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        }
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
}

extension MapViewController: LocationManagerDelegate {
    
    func updateLocations(_ locations: [CLLocation]) {
        
        guard let coordinate = locations.first?.coordinate, self.firstLoad else {
            return
        }
        
        self.setMapRegion(coordinate)
        self.firstLoad = !self.firstLoad
        
    }
    
}
