# Robot Localization and Navigation

## Objective
The objective of this robot localization project is Where is the current location of the robot? The ultimate mission of this project is to make our  robot navigate to a specific location encountering several random obstacles and also identify/ know its own position as time changes. This project is based on analyzing random errors and implementing algorithm concepts of both Kalman filtering and particle filtering for best approximations. Finally, a simulation was projected using processing GUI  to track and show the real location and also errors will be simulated in navigational sensor data. 
Several key mathematical concepts were implemented like the Gaussian Kernel, Parzen-Window, Density Estimation. The challenging portion of this project is producing the localization techniques. For example, a technique that works well for a certain robot in one environment may not be suitable for another robot in the same environment. So all the localization techniques, generally provide two information which are the current location of the robot in some environment and the current orientation  of the robot in the same environment. If the robot is uncertain, that information needs to be combined in an optimal way. Two most common filters which were effective for our robot localization were the Kalman and Particle Filters. 

## References

link to processing ide: https://www.processing.org \n
take a look at this source. It might help us figureout how to fix triangulation \n
http://www.telecom.ulg.ac.be/publi/publications/pierlot/Pierlot2011ANewThreeObject/index.html \n

try out the new processing feature that allows you to play with parameter while running code!! Sketch -> Tweak \n

My KF code can track displace of the robot which can be uniformly accelerated or with constant velocity.
