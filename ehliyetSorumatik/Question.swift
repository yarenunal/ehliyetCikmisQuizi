//
//  Question.swift
//  ehliyetSorumatik
//
//  Created by Yaren on 9.08.2025.
//
import Foundation

struct Question: Codable, Identifiable {
    let id: Int
    let image: String?           // Opsiyonel, çünkü her soru görsel içermiyor
    let question: String
    let options: [String: String]
    let answer: String
}



