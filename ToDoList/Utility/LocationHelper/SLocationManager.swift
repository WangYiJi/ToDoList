//
//  SLocationManager.swift
//  CBDDriver
//
//  Created by Alex on 12/02/2018.
//  Copyright © 2018 chebada. All rights reserved.
//

import Foundation
import CoreLocation
protocol lmPro:NSObjectProtocol {
    func getCityName(string:String)
}

class SLocationManger:NSObject ,CLLocationManagerDelegate {
    
    static let shard = SLocationManger()
    private static var lm:CLLocationManager?
    private var location:CLLocation?
    weak var selfPro:lmPro?
    var cityName:String?
    private override init() {
        super.init()
        if SLocationManger.lm == nil {
            SLocationManger.lm = CLLocationManager.init()
            SLocationManger.lm?.delegate = self
        }
    }
    
    //updating location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            SLocationManger.shard.location = locations.last
            manager.stopUpdatingLocation()
            let geoCoder:CLGeocoder = CLGeocoder()

            geoCoder.reverseGeocodeLocation(SLocationManger.shard.location!, completionHandler: { (placeMarks, error) in
                if error == nil && placeMarks != nil {
                    let placeMarkItem:CLPlacemark = placeMarks![0] as CLPlacemark
                    let cityName:String = placeMarkItem.locality!
                    if cityName.count > 0 {
                        SLocationManger.shard.cityName = placeMarkItem.locality
                    }
                }
            })
        }
    }
    
    func startUpdateLocation() {
        SLocationManger.lm?.startUpdatingLocation()
    }
    
    func stopUpdateLocation() {
        SLocationManger.lm?.stopUpdatingLocation()
    }
    
    
}
