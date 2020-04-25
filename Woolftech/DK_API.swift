//
//  File.swift
//  DK_API
//
//  Created by Philip Beckwith on 4/22/20.
//  Copyright © 2020 Philip Beckwith. All rights reserved.
//

import Foundation


class DK_API {
    //Replace this X_Auth Token ASAP! DK will probably decomission this one soon.
    let X_AUTH_TOKEN = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0NDcwNGIwZC0wYzJmLTRlNDgtOWJiNi0yYjY4MDFjOWM1NmYifQ.9IBMbDvnah-yvsAXy94kL9W8HU7Kyc-DB9ZehA3Zke4I4W_D3SrkDazAa1uKiiCxCrlPxABQ-KX-mLiQ9MHXzA"
    
    let BASE_URL:String = "https://api.diamondkinetics.com/"
    let LOG_IN_URL:String = "api/user/login?remember-me=true"
    let MEMBERSHIP_URL:String = "v2/users/groups" // @todo Needs work. The do is unclear on how to get the people in your groups....
    let BATTING_SESSION_URL:String = "v3/users/{uuid}/battingSessions"
    
    let UUID_FIELD_NAME = "{uuid}"
    let X_AUTH_FIELD_NAME = "X-AUTH-TOKEN"
    
    var userEmail:String = "demo+sb@diamondkinetics.com "
    var userPassword:String = "demo"
    var userUUID:String = ""
    var userToken:String = ""

    
    func getUserUUID(){
        let JSON = doRequest(urlRequest: createLoginRequest())
        userUUID = JSON["uuid"] as! String
        print(userUUID)
    }
    
    func getGroupMembers(){
        let JSON = doRequest(urlRequest: createMembershipsRequest())
    }
    
    func getUserBattingSessions(){
        let JSON = doRequest(urlRequest: createBattingSessionsRequest())
        
        if let JSONarray = JSON["data"] as? NSArray{
            processJSONBattingSessions(JSONarray: JSONarray)
        }
    }
    
    func createBattingSessionsRequest() -> URLRequest{
        let url = URL(string: BASE_URL+BATTING_SESSION_URL.replacingOccurrences(of:UUID_FIELD_NAME, with: userUUID))!
        var request = URLRequest(url: url)
        print(url.absoluteString)
        
        request.httpMethod = "GET"
        request.setValue(X_AUTH_TOKEN, forHTTPHeaderField: X_AUTH_FIELD_NAME)
        
        return request
    }
    
    func createMembershipsRequest() -> URLRequest{
        let url = URL(string: BASE_URL+MEMBERSHIP_URL.replacingOccurrences(of:UUID_FIELD_NAME, with: userUUID))!
        var request = URLRequest(url: url)
        print(url.absoluteString)
        
        request.httpMethod = "GET"
        request.setValue(X_AUTH_TOKEN, forHTTPHeaderField: X_AUTH_FIELD_NAME)
        
        return request
    }
    
    func createLoginRequest() -> URLRequest {
        let url = URL(string: BASE_URL+LOG_IN_URL)!
        var request = URLRequest(url: url)
        
        let parameters: [String: Any] = [
            "email": userEmail,
            "password": userPassword
        ]
        
        request.httpMethod = "POST"
        request.httpBody = getBodyData(parameters: parameters)
        
        return request
    }
    
    func getBodyData(parameters:[String:Any]) -> Data{
        var data:Data = Data()
        do {
            data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        return data
    }
    
    func getJson(JSON:[String:Any]){
        
    }

    func doRequest(urlRequest:URLRequest) -> [String:Any]{
        var request = urlRequest
        var JSONDATA:[String:Any] = [:]
        
        //ensuring we get Json back
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let group = DispatchGroup()
        group.enter()
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                group.leave()
                return
            }

            guard let data = data else {
                group.leave()
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    JSONDATA = json
                }
                else{
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                        JSONDATA["data"] = json
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
            group.leave()
        })
        task.resume()
        
        group.wait()
        return JSONDATA
    }
    
    func processJSONBattingSessions(JSONarray:NSArray){
        for eventBatch in JSONarray{
            if let JSONdictionary = eventBatch as? NSDictionary{
                processEventBatches(JSONdictonary: JSONdictionary)
            }
        }
    }
    
    func processEventBatches(JSONdictonary:NSDictionary){
        if let eventBatch = JSONdictonary["allEvents"] as? NSArray{
            for event in eventBatch {
                if let eventJSON = event as? NSDictionary{
                    processEvent(eventDictionary: eventJSON)
                }
            }
        }
        
    }
    
    func processEvent(eventDictionary:NSDictionary){
        let powerAccelMax = eventDictionary["powerAccelMax"] as! Double
        let powerMomentumImpact = eventDictionary["powerMomentumImpact"] as! Double
        let powerApplied = eventDictionary["powerApplied"] as! Double
        let speedEfficiency = eventDictionary["speedEfficiency"] as! Double
        let speedBarrelMax = eventDictionary["speedBarrelMax"] as! Double
        let speedHandsMax = eventDictionary["speedHandsMax"] as! Double
        let controlApproachAngleImpact = eventDictionary["controlApproachAngleImpact"] as! Double
        let quicknessTriggerImpact = eventDictionary["quicknessTriggerImpact"] as! Double
        let controlHandCastMax = eventDictionary["controlHandCastMax"] as! Double
        let controlDistanceInTheZone = eventDictionary["controlDistanceInTheZone"] as! Double
        let startTime = eventDictionary["startTime"] as! String
        
        //Send data to SQL DataBase
        print(powerAccelMax)
        print(powerMomentumImpact)
        print(powerApplied)
        print(speedEfficiency)
        print(speedBarrelMax)
        print(speedHandsMax)
        print(controlApproachAngleImpact)
        print(quicknessTriggerImpact)
        print(controlHandCastMax)
        print(controlDistanceInTheZone)
        print(startTime)
    }
}
