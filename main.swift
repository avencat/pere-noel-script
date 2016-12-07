//
//  main.swift
//  Noël tirage au sort
//
//  Created by Axel Vencatareddy on 29/11/2016.
//  Copyright © 2016 Axel Vencatareddy. All rights reserved.
//

import Foundation
import Cocoa

extension Array
{
  /** Randomizes the order of an array's elements. */
  mutating func shuffle()
  {
    for _ in 0..<10
    {
      sort { (_,_) in arc4random() < arc4random() }
    }
  }
}

class Person {
  let _name, _mail : String
		
  init(name: String, mail: String) {
    _name = name
    _mail = mail
  }
}

var participants = [Person(name: "User 1", mail: "user1@yopmail.com"), Person(name: "User 2", mail: "user2@yopmail.com"), Person(name: "User 3", mail: "user3@yopmail.com"), Person(name: "User 4", mail: "user4@yopmail.com"), Person(name: "User 5", mail: "user5@yopmail.com"), Person(name: "User 6", mail: "user6@yopmail.com")]

participants.shuffle()
participants.shuffle()
participants.shuffle()

func sendEmails() {
    var i = 0
    
    while i < participants.count {
        let user: Person = participants[i]
        let userTo: Person = participants[i + 1 >= participants.count ? 0 : i + 1]
        let task: Process = Process()
        let pipe: Pipe = Pipe()
        let handle = pipe.fileHandleForWriting
        
        task.launchPath = "/usr/bin/mail"
        task.arguments = ["-s", "À qui dois-tu offrir un cadeau de Noël ? 😊", user._mail]
        task.standardInput = pipe
        task.launch()
        
        handle.write("Ho ho ho ! Salut \(user._name) !\nPour ce noël, que vous allez passer entre amis, mes lutins ont décidé que vous offririez un cadeau à \(userTo._name). Joyeux Noël !!! 🎅🏻🎅🏻🎅🏻".data(using: .utf8)!)
        i += 1
    }
}

sendEmails()
