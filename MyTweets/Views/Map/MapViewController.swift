//
//  MapViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 14/08/2021.
//

import Foundation
import UIKit
import MapKit

final class MapViewController: UIViewController {
    private let mapView: MapView
    private let posts: [Post]

    private var map = MKMapView()
    
    // MARK: - Public properties
    weak var coordinator: HomeCoordinator?
    
    init(view: MapView = MapView(), posts: [Post] = []) {
        mapView = view
        self.posts = posts
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
    }
    
    override func loadView() {
        view = mapView
    }
    
    private func setupMap() {
        map = MKMapView(frame: mapView.mapContainer.bounds)
        mapView.mapContainer.addSubview(map)
        
        setupMarkers()
    }
    
    private func setupMarkers() {
        posts.forEach { post in
            let marker = MKPointAnnotation()
            let location = post.location
            
            marker.coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                       longitude: location.longitude)
            
            marker.title = post.text
            marker.subtitle = post.author.names
            
            map.addAnnotation(marker)
        }
    }
}
