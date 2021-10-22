//
//  ViewController.swift
//  mabpox-convert-issue
//
//  Created by Yevhen Pyvovarov on 22.10.2021.
//

import Mapbox

class ViewController: UIViewController {

    // Coordinates we will translate into view point
    let coordinatesToCheck = CLLocationCoordinate2D(latitude: 50.450_1, longitude: 30.523_4)

    // Camera with non zero pitch nearby coordinatesToCheck
    var cameraRepresentingIssue: MGLMapCamera {
        MGLMapCamera(lookingAtCenter: .init(latitude: 50.445, longitude: 30.511_1),
                     altitude: 477.041,
                     pitch: 59.25,
                     heading: 268.4)
    }

    // Camera with zero pitch nearby coordinatesToCheck
    var cameraRepresentingCorrectBehaviour: MGLMapCamera {
        let camera = self.cameraRepresentingIssue
        camera.pitch = 0
        return camera
    }

    // Map View
    private lazy var mapView: MGLMapView = {
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")!
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add map view to view
        view.addSubview(self.mapView)

        // Set camera with zero pitch nearby & convert coordinatesToCheck to point at mapView
        self.mapView.setCamera(self.cameraRepresentingCorrectBehaviour, animated: false)
        let point1 = self.mapView.convert(self.coordinatesToCheck, toPointTo: self.mapView)

        // Correct calculated point
        print("Correct calculated point:  \(point1)")

        // Set camera with non zero pitch nearby & convert coordinatesToCheck to point at mapView
        self.mapView.setCamera(self.cameraRepresentingIssue, animated: false)
        let point2 = self.mapView.convert(self.coordinatesToCheck, toPointTo: self.mapView)

        // Some huge negative numbers
        print("Incorrect calculated point \(point2)")
    }
}
