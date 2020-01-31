//
//  ListenSpeech.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 31/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import Speech

class ListenSpeech {
     //var memoData: [Memo]!
       var currentLanguage = 0
       let languaeList = ["pl","en_GB","de","fr_FR","es_ES"]
       
       lazy var speechRecognizer: SFSpeechRecognizer? = nil
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
            else {
                return nil
            }
        }
        lazy var audioEngine: AVAudioEngine = {
            let audioEngine = AVAudioEngine()
            return audioEngine
        }()
        
        var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        var recognitionTask: SFSpeechRecognitionTask?

         func Load() {

//            // request auth
//            self.requestAuth()
//            self.recordedMessage.delegate = self
//
//            // init data
//            memoData = []
//
//            // tableview delegations
//            self.tableView.delegate = self
//            self.tableView.dataSource = self
//
//            // hide recording views
//            self.recordingView.isHidden = true
//            self.fadedView.isHidden = true
         
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
        
//        @IBAction func languageSementedControlPress(_ sender: UISegmentedControl) {
//            currentLanguage = sender.selectedSegmentIndex
//            print("lan=\(currentLanguage)")
//        }
//        @IBAction func didTapRecordButton(sender: UIButton) {
//            self.speechRecognizer = setupSpeechRecognizer()
//            if audioEngine.isRunning {
//                audioEngine.stop()
//                recognitionRequest?.endAudio()
//            } else {
//                self.startRecording()
//                self.recordingView.isHidden = false
//                self.fadedView.alpha = 0.0
//                self.fadedView.isHidden = false
//                UIView.animate(withDuration: 1.0) {
//                    self.fadedView.alpha = 1.0
//                }
//            }
//        }
//        @IBAction func stopRecording(sender: UIButton) {
//            if audioEngine.isRunning {
//                audioEngine.stop()
//                recognitionRequest?.endAudio()
//                audioEngine.inputNode.removeTap(onBus: 0)
//                self.memoData.append(Memo(memoTitle: "Nowe nagranie", memoDate: Date(), memoText: self.recordedMessage.text!))
//
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.fadedView.alpha = 0.0
//                }) { (finished) in
//                    self.fadedView.isHidden = true
//                    self.recordingView.isHidden = true
//                    self.tableView.reloadData()
//                }
//            }
//            self.speechRecognizer = nil
//        }
//
//        func startRecording() {
//
//            if let recognitionTask = self.recognitionTask {
//                recognitionTask.cancel()
//                self.recognitionTask = nil
//            }
//
//            self.recordedMessage.text = ""
//
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setCategory(AVAudioSessionCategoryRecord)
//                try audioSession.setMode(AVAudioSessionModeMeasurement)
//                try audioSession.setActive(true, with: AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation)
//            }catch {
//                print(error)
//            }
//
//            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//
//            guard let recognitionRequest = self.recognitionRequest else {
//                fatalError("Niemożliwe utworzenie bufora dźwięku") //Unable to create a speech audio buffer
//            }
//
//            recognitionRequest.shouldReportPartialResults = true
//            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
//
//                var isFinal = false
//                if let result = result {
//                    let sentence = result.bestTranscription.formattedString
//                    self.recordedMessage.text = sentence
//                    isFinal = result.isFinal
//                }
//
//                if error != nil || isFinal {
//                    self.audioEngine.stop()
//                    self.audioEngine.inputNode.removeTap(onBus: 0)
//                    self.recognitionRequest = nil
//                    self.recognitionTask = nil
//                    self.recordButton.isEnabled = true
//                }
//
//            })
//
//            let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
//            audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
//                self.recognitionRequest?.append(buffer)
//            }
//
//            audioEngine.prepare()
//            do{
//                try audioEngine.start()
//            }catch {
//                print(error)
//            }
//        }
//
//    }

//    extension ViewController: SFSpeechRecognizerDelegate {}
//
//    extension ViewController: UITableViewDelegate {}
//
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
