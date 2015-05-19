//
//  PlaySoundsViewControler.swift
//  PitchPerfect
//
//  Created by Rohit Gurnani on 16/05/15.
//  Copyright (c) 2015 Rohit Gurnani. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewControler: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    var recievedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
       // if var filePathURL = NSURL.fileURLWithPath( NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
            if var filePathURL = recievedAudio.filePathURL
        {
            println(filePathURL)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
            //audioPlayer.prepareToPlay()
           // audioPlayer.play()
            audioFile = AVAudioFile(forReading: recievedAudio.filePathURL, error: nil)
            
        
        }
        else
        {
            println("error found")
        }

        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.enableRate = true
        audioPlayer.rate = 0.5
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.enableRate = true
        audioPlayer.rate = 2.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        //add chipmunk effect here
        //resetting everything in case the button is tapped two times
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        
        
        var audioPlayerNode = AVAudioPlayerNode()
        var changePitchEffect = AVAudioUnitTimePitch()
        
        //attaching the audioplayernode to the audio engine
        audioEngine.attachNode(audioPlayerNode)
        
        //setting the value of effect
        changePitchEffect.pitch = 1000.00
        
        //attaching pitch effect to the engine
        audioEngine.attachNode(changePitchEffect)
        
        //now connecting the nodes inside the engine to one another
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        //schedule the file to audioplayer node
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        //get the audio engine started and play the audio file
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    
    @IBAction func playDarthVaderSound(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        
        var audioPlayerNode = AVAudioPlayerNode()
        var changeTimePitch = AVAudioUnitTimePitch()
        
        changeTimePitch.pitch = -1000.00
        
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(changeTimePitch)
        
        audioEngine.connect(audioPlayerNode, to: changeTimePitch, format: nil)
        audioEngine.connect(changeTimePitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
