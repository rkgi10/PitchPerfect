//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Rohit Gurnani on 13/05/15.
//  Copyright (c) 2015 Rohit Gurnani. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordinginProgress: UILabel!
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func RecordAudio(sender: UIButton) {
        //todo: show text in progress
        
        println("hello world")
        recordinginProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
        //record the user's voice
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory , .UserDomainMask, true) [0] as String
        let currentDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDate)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        //todo - save the recorded audio
        //initializing the new object
        if(flag){
        recordedAudio = RecordedAudio()
        recordedAudio.filePathURL = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        
        //todo - move to the second screen that is perform a segue
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            println("recording not completed")
            recordButton.enabled = false
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording")
        {
            let playSoundsVC: PlaySoundsViewControler = segue.destinationViewController as PlaySoundsViewControler
            //let data = sender as RecordedAudio
            playSoundsVC.recievedAudio = (sender as RecordedAudio)
        }
    }

    @IBAction func stopRecording(sender: UIButton) {
        //hide the label recordinginProgress
        recordinginProgress.hidden = true
        stopButton.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false , error: nil)
    }
}

