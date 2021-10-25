//
//  ViewController.swift
//  mabpox-convert-issue
//
//  Created by Yevhen Pyvovarov on 22.10.2021.
//

import MapboxMaps

class ViewController: UIViewController {

    // Coordinates we will translate into view point
    let coordinatesToCheck = CLLocationCoordinate2D(latitude: 50.450_1, longitude: 30.523_4)

    // Camera with non zero pitch nearby coordinatesToCheck
    var cameraRepresentingIssue: CameraOptions {
        CameraOptions(center: .init(latitude: 50.434_1, longitude: 30.491),
                      zoom: 14.4,
                      bearing: 253.25,
                      pitch: 58.625)
    }

    // Camera with zero pitch nearby coordinatesToCheck
    var cameraRepresentingCorrectBehaviour: CameraOptions {
        let newPitch: CGFloat = 0

        let camera = CameraOptions(center: self.cameraRepresentingIssue.center,
                                   zoom: self.cameraRepresentingIssue.zoom,
                                   bearing: self.cameraRepresentingIssue.bearing,
                                   pitch: newPitch)

        return camera
    }

    // Map View
    private lazy var mapView: MapView = {
        let resourceOptions = ResourceOptions(accessToken: "FIXME")
        let cameraOptions = CameraOptions(center: self.coordinatesToCheck, zoom: 13, bearing: 0, pitch: 30)
        let mapOptions = MapInitOptions(resourceOptions: resourceOptions, cameraOptions: cameraOptions)
        let mapView = MapView(frame: view.bounds, mapInitOptions: mapOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add map view to view
        view.addSubview(self.mapView)

        // Set camera with zero pitch nearby & convert coordinatesToCheck to point at mapView
        self.mapView.camera.fly(to: self.cameraRepresentingCorrectBehaviour, duration: 0) { _ in
            let point1 = self.mapView.mapboxMap.point(for: self.coordinatesToCheck)

            // Correct calculated point
            print("Correct calculated point:  \(point1)")

            // Set camera with non zero pitch nearby & convert coordinatesToCheck to point at mapView
            self.mapView.camera.fly(to: self.cameraRepresentingIssue, duration: 0) { _ in
                let point2 = self.mapView.mapboxMap.point(for: self.coordinatesToCheck)

                // Some huge negative numbers
                print("Incorrect calculated point \(point2)")
            }
        }
    }
}
