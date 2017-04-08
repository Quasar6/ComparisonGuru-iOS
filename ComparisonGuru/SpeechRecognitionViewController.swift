//
//  SpeechRecognitionViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-28.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import Speech

class SpeechRecognitionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var micButton: UIButton!
    
    //MARK: - speech needed var and constant
    fileprivate let audioEngine = AVAudioEngine()
    fileprivate let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    fileprivate var recognitionTask: SFSpeechRecognitionTask?
    
    
    private var isListen:Bool = false {
        didSet{
            let image = isListen ? #imageLiteral(resourceName: "mic_highLighted") : #imageLiteral(resourceName: "mic")
            micButton.setImage(image, for: .normal)
            textLabel.text = isListen ? "I'm listening..." : "Click mic button to speak"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
        
    }
    
    @IBAction func micButtonTouched(_ sender: UIButton) {
        isListen = !isListen
        if isListen {
            askSpeechPermission()
        }
        
    }
    
    @IBAction func toolbarButtonTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension SpeechRecognitionViewController: SFSpeechRecognizerDelegate {
    
    func microphoneTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            
        }
        startRecording()
        
    }
    
    func askSpeechPermission() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    //Good to go
                    //                    self.startRecording()
                    self.microphoneTapped()
                    break
                case .denied:
                    //User said no
                    break
                case .restricted:
                    //Device isn't permitted
                    break
                case .notDetermined:
                    //Don't know yet
                    break
                }
            }
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            
            if result != nil {
                
                //update textfield
                self.textLabel.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                //active mic icon
                //                self.searchField.voiceIconTouched.isUserInteractionEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error")
        }
        
    }
}
