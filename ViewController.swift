//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Rohit Gurnani on 13/05/15.
//  Copyright (c) 2015 Rohit Gurnani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordinginProgress: UILabel!
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
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
        //record the user's voice
        println("hello world")
        recordinginProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
    }

    @IBAction func stopRecording(sender: UIButton) {
        //hide the label recordinginProgress
        recordinginProgress.hidden = true
        stopButton.hidden = true
    }
}

