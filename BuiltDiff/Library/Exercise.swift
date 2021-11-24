//
//  Exercise.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-11-23.
//

import Foundation

class Exercise{
    var Date : String
    var ExerciseType: String
    var Distance: String
    var Duration : String
    var ImageName : String

    init(date : String, exerciseType: String, distance: String, duration : String, imageName : String){
        Date = date
        ExerciseType = exerciseType
        Distance = distance
        Duration = duration
        ImageName = imageName
    }
}
