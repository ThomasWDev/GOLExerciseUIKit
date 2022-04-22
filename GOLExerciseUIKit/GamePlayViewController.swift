//
//  ViewController.swift
//  GOLExerciseUIKit
//
//  Created by ThomasWDev on 4/20/22.
//

import UIKit
import Foundation

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    private var gridView: GridView!
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.backgroundColor = .blue
        startButton.layer.cornerRadius = 10
        startButton.layer.masksToBounds = true
        
        let margin: CGFloat = 0.0
        let size = view.frame.width - margin * 2.0
        let frame = CGRect(x: margin, y: (view.frame.height - size) / 2.0, width: size, height: size)
        /// The grid must be at least 10 columns and 10 rows.
        gridView = GridView(gridSize: 1000, cellSize: size/1000.0)
        gridView.frame = frame
        gridView.layer.borderColor = UIColor.darkGray.cgColor
        gridView.layer.borderWidth = 2.0
        view.addSubview(gridView)
    }
    
    @objc private func makeStep() {
        gridView.board.step()
        gridView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onStartClicked(_ sender: Any) {
        if timer == nil {
            startButton.backgroundColor = .red
            startButton.setTitle("Stop", for: .normal)
            gridView.updateNextGenerationByRules()
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(makeStep), userInfo: nil, repeats: true)
        } else {
            startButton.backgroundColor = .blue
            startButton.setTitle("Start", for: .normal)
            timer.invalidate()
            timer = nil
        }
    }
}


