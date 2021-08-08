//
//  NewPostLocationDelegate.swift
//  MyTweets
//
//  Created by nicolas.e.manograsso on 08/08/2021.
//

import Foundation
import CoreLocation

final class NewPostLocationDelegate: NSObject, CLLocationManagerDelegate {
    private(set) var userLocation: CLLocation?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        userLocation = location
    }
}
