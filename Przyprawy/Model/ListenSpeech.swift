//
//  ListenSpeech.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 31/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import Speech
protocol ListenSpeechDelegate {
    func updateListenSpeechInterface(forRedyToRecord isReady: Bool)
}
class ListenSpeech {
    struct Memo {
        let memoTitle: String
        let memoDate: Date
        let memoText: String
    }
    //memoTitle: "Nowe nagranie", memoDate: Date(), memoText: self.recordedMessage.text!
    //typealias Memo = String
    var delegate: ListenSpeechDelegate?
    var memoData: [Memo] = [Memo]()
    var isEnabled = true
    var isEmpty : Bool {
        get {
            return recordedMessage.count > 0
        }
    }
    var currentLanguage = 0
    let languaeList = ["pl","en_GB","de","fr_FR","es_ES"]
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    lazy var speechRecognizer: SFSpeechRecognizer? = nil
    //----------
    var recordedMessage: String = ""
    var isRecordEnabled = true

    var languageId: String  {
        get {
         return Setup.languageId
        }
    }
    lazy var audioEngine: AVAudioEngine = {
           let audioEngine = AVAudioEngine()
           return audioEngine
       }()
    init() {
        // request auth
        self.requestAuth()
        // init data
        memoData = []
    }



    //    lazy var speechRecognizer: SFSpeechRecognizer? = {
    //        if let recognizer = SFSpeechRecognizer(locale: Locale(identifier: languaeList[currentLanguage])) {
    //            recognizer.delegate = self
    //            return recognizer
    //        }
    //        return nil
    //    }()
    func setupSpeechRecognizer() ->  SFSpeechRecognizer? {
        if let recognizer = SFSpeechRecognizer(locale: Locale(identifier: languaeList[currentLanguage])) {
            //recognizer.delegate = self
            return recognizer
        }
        else {   return nil    }
    }
    func requestAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            DispatchQueue.main.async {
                switch authStatus {
                    case .authorized:
                        print("authorized")
                    case .denied, .notDetermined, .restricted:
                         print("denied, notDetermined, restricted")
                    default :
                        print("EROR Listen speach")
                }
            }
        }
    }
//    func updateUserInterface() {
//        if isEnabled {
//            print("User interface is enabled")
//        }
//        else {
//           print("User interface is disabled")
//        }
//}
        //                self.recordingView.isHidden = false
        //                self.fadedView.alpha = 0.0
        //                self.fadedView.isHidden = false
        //                UIView.animate(withDuration: 1.0) {
        //                    self.fadedView.alpha = 1.0

        //          during stop
        //                UIView.animate(withDuration: 0.5, animations: {
        //                    self.fadedView.alpha = 0.0
        //                }) { (finished) in
        //                    self.fadedView.isHidden = true
        //                    self.recordingView.isHidden = true
        //                    self.tableView.reloadData()
        //                }

        
//        @IBAction func languageSementedControlPress(_ sender: UISegmentedControl) {
//            currentLanguage = sender.selectedSegmentIndex
//            print("lan=\(currentLanguage)")
//        }
     func didTapRecordButton() {
        self.speechRecognizer = setupSpeechRecognizer()
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            self.startRecording()
            
        }        
        delegate?.updateListenSpeechInterface(forRedyToRecord: isEnabled)
        isEnabled.toggle()
        //updateUserInterface()
    }
    func stopRecording() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
            self.memoData.append(Memo(memoTitle: "Nowe nagranie", memoDate: Date(), memoText: self.recordedMessage))
        }
        self.speechRecognizer = nil
    }

    func startRecording() {
        if let recognitionTask = self.recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        self.recordedMessage = ""
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
            //try audioSession.setActive(true, with: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        }catch {
            print(error)
        }
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()             //   Unable to create a speech audio buffer
        guard let recognitionRequest = self.recognitionRequest else {    fatalError("Niemożliwe utworzenie bufora dźwięku")      }
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            if let result = result {
                let sentence = result.bestTranscription.formattedString
                self.recordedMessage = sentence
                isFinal = result.isFinal
            }
            if error != nil || isFinal {
                self.audioEngine.stop()
                self.audioEngine.inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.isRecordEnabled = true
                //self.recordButton.isEnabled = true
            }
        })
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in   self.recognitionRequest?.append(buffer)  }
        audioEngine.prepare()
        do {    try audioEngine.start()   }
        catch {   print(error)     }
    }
// end start


//    extension ViewController: SFSpeechRecognizerDelegate {}
//    extension ViewController: UITableViewDelegate {}

//    extension ViewController: UITableViewDataSource {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return memoData.count
//        }
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
//            let memo = memoData[indexPath.row]
//            cell.titleLabel.text = memo.memoTitle
//            cell.dateLabel.text = memo.memoDate.description
//            cell.memoLabel.text = memo.memoText
//            return cell
//        }
//    }

}
