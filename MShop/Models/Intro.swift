//
//  Intro.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 11/06/2022.
//

import SwiftUI

// Intro Model and Sample Intro's
struct Intro: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
    var color: Color
}

var intros: [Intro] = [
    
    Intro(image: "Welcome1", title: "Find your favourite 'gem'", description: "'Gem' which is a combination of brand, fashion, price and quality.", color: Color("Purple")),
    Intro(image: "Welcome2", title: "Find the best price", description: "Exciting merchandise at amazing prices all the time.", color: Color("Orange")),
    Intro(image: "Welcome3", title: "Are you ready to dive in?", description: "Whatever your style is – classic, understated, or extravagant - You will find something fun and special, welcome on board.\n\nClick 'Skip' button.", color: Color("Blue"))
]
