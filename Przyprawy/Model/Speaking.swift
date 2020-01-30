//
//  Speak.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 30/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import AVFoundation

class Speaking {
    var LanguageId = "en-GB"
    let synthesier = AVSpeechSynthesizer()
    var selectedLanguage = 0
    init() {
        self.LanguageId =  Setup.currentLanguage.rawValue
        self.textToSpeach = ""
    }
    var textToSpeach: String {
        didSet {
            if textToSpeach == "" {   stopSpeaking()     }
            else {   startSpeaking()       }
        }
    }
    var contentToSpeac: [String] = []
    func startSpeaking() {
        let utterance = AVSpeechUtterance(string: textToSpeach) //contentToSpeac[selectedLanguage]
        utterance.voice = AVSpeechSynthesisVoice(language: LanguageId) // pl "en-GB" "en-US"
        synthesier.speak(utterance)
    }
    func stopSpeaking() {
        synthesier.stopSpeaking(at: .word)
    }
    func pauseSpeaking() {
       synthesier.pauseSpeaking(at: AVSpeechBoundary.immediate)
    }
    func continueSpeaking() {
        synthesier.continueSpeaking()
    }
    func printLanguageSpeakerName() {
        print("AVSpeechSynthesisVoice")
        for rek in AVSpeechSynthesisVoice.speechVoices() {
           print("\n\(rek)")
        }
    }
}
