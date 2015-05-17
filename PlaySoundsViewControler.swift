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
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if var filePathURL = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
        {
            println(filePathURL)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
            //audioPlayer.prepareToPlay()
           // audioPlayer.play()
            
        
        }
        else
        {
            println("error found")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = 0.5
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = 2.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
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
