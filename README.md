- The above extension will let you create and stop pulsating animation on UIViews. Make sure your UIView is a circle.

- Animation :


![Simulator_Screen_Recording_-_iPhone_8_-_2021-09-19_at_13_50_40_SparkVideo](https://user-images.githubusercontent.com/16226329/133920656-c632ebda-24de-43e7-82ae-81c702439110.gif)

- Code :

  func createPulse() {
        let button = UIView.init(frame: .init(x: 0, y: 0, width: 200, height: 200))
        button.layer.cornerRadius = button.frame.width/2
        button.createPulse()
    }
    
    func removePulse() {
        button.removePulse()
    }

<!---
HimanDhawan/HimanDhawan is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
