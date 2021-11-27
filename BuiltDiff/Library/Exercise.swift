//
//  Exercise.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-11-23.
//

import Foundation

class Exercise{
    var OriginalUser : String
    var Date : String
    var ExerciseType: String
    var Distance: String
    var Duration : String
    var Calories : String
    var ImageName : String
    
    init(originalUser:String, date:String, exerciseType:String, distance:String, duration:String, calories:String, imageName:String){
        OriginalUser = originalUser
        Date = date
        ExerciseType = exerciseType
        Distance = distance
        Duration = duration
        Calories = calories
        ImageName = imageName
    }
}
