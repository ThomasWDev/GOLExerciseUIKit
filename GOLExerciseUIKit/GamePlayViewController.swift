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
    @IBOutlet weak var changeSizeButton: UIButton!
    
    private var boardView: BoardView!
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.backgroundColor = .blue
        startButton.layer.cornerRadius = 10
        startButton.layer.masksToBounds = true
        changeSizeButton.layer.cornerRadius = 10
        changeSizeButton.layer.masksToBounds = true
        changeSizeButton.backgroundColor = .blue
        
        buildBoardView(10)
        
    }
    
    @objc private func makeStep() {
        boardView.board.step()
        boardView.setNeedsDisplay()
    }
    
    private func buildBoardView(_ boardSize: Int64) {
        
        boardView?.removeFromSuperview()
        /// The grid must be at least 10 columns and 10 rows.
        let margin: CGFloat = 10.0
        let size = view.frame.width - margin * 2.0
        let frame = CGRect(x: margin, y: (view.frame.height - size) / 2.0, width: size, height: size)
        boardView = BoardView(gridSize: Int64(boardSize), cellSize: size/CGFloat(boardSize))
        boardView.frame = frame
        view.addSubview(boardView)
        boardView.layer.borderColor = UIColor.darkGray.cgColor
        boardView.layer.borderWidth = 2.0
    }
    
    private func autoRun() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makeStep), userInfo: nil, repeats: true)
    }
    
    private func stopAutoRun() {
        timer.invalidate()
        timer = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onStartClicked(_ sender: Any) {
        if timer == nil {
            startButton.backgroundColor = .red
            startButton.setTitle("Stop", for: .normal)
            changeSizeButton.isUserInteractionEnabled = false
            changeSizeButton.backgroundColor = .gray
            boardView.makeBoard()
            autoRun()
            
        } else {
            startButton.backgroundColor = .blue
            startButton.setTitle("Start", for: .normal)
            changeSizeButton.isUserInteractionEnabled = true
            changeSizeButton.backgroundColor = .blue
            stopAutoRun()
        }
    }
    
    @IBAction func onChangeSizeClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Board Size", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter size"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            if let sizeValue = textField.text {
                if let iSize = Int64(sizeValue) {
                    self.boardView.board.matricsSize = iSize
                    self.buildBoardView(iSize)
                }
            }
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}


