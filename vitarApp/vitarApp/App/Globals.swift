//
//  Globals.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 15.12.2022.
//

import Foundation

final class Globals {
    static let sharedInstance = Globals()
    private init(){}
    
    //MARK: - Settings
    var isLocalColorCalculationEnabled = false
    
    //MARK: - States
    
    var isFirstLaunch = true
    
    var isFavoriteChanged = false
    
    var isNotesChanged = false
    
    //MARK: - Helpers
    func formatDate(date:String) -> String{
        return date.replacingOccurrences(of: "-", with: "/")
    }
    
    func resizeImageRemote(imgUrl:String?, size:Int) -> String?{
        return imgUrl?.replacingOccurrences(of: "media/g", with: "media/resize/\(size)/-/g")
    }
    
    func Esrb (id:Int?) -> String{
        if let ratingId = id {
            switch ratingId {
            case 1:
                return "E"
            case 2:
                return "E10+"
            case 3:
                return "T"
            case 4:
                return "M"
            case 5:
                return "AO"
            case 6:
                return "RP"
            default:
                return "NR"
            }
        }
        return "NR"
    }
    //MARK: -
    
}

