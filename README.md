Welcome to the RobotLocalizationNavigation wiki!

# Robot Localization and Navigation
## Objective:
The objective of this robot localization project is to have a robot find its location, utilizing beacons distance information with set loacations to triangulate the robots position. The ultimate mission of this project is to make our robot navigate to a specific location encountering several random obstacles and also identify/ know its own position as time changes. This project is based on analyzing random errors and implementing algorithm concepts of both Kalman filtering and particle filtering for best approximations. Finally, a simulation was projected using processing GUI to track and show the real location and also errors will be simulated in navigational sensor data.

Several key mathematical concepts were implemented like the Gaussian Kernel, Parzen-Window, Density Estimation. Furthermore the project consisted of prenty of data structure algorithm learned throughout the semester; such as linked list, queues, stacks, as well as mapping in form of lists. The challenging portion of this project were producing the localization techniques, implementing the pazens window from a mathimatical model, generating random shapes, and the multilayerd mapping structure, and detecting direct line of sight and using that information to navigate. For example, a technique that works well for a certain robot in one environment may not be suitable for another robot in the same environment. So all the localization techniques, generally provide two information which are the current location of the robot in some environment and the current orientation of the robot in the same environment. If the robot is uncertain, that information needs to be combined in an optimal way. Two most common filters which were effective for our robot localization were the Kalman and Particle Filters.

# Robot Localization

## Introduction:
Localization consist of several elements. Beacons with set location that broadcast their location, and the robot being able to detect the distance from the beacon. Furthermore the robot must be able to detect several beacons in order to triangulate its own location using the collected distances from nearby beacons.

## Kalman Filter:
The Kalman filter is a set of mathematical equations that provides an efficient computational (recursive) means to estimate the state of a process, in a way that minimizes the mean of the squared error. The filter supports estimations of past, present, and even future states, and it can do so even when the precise nature of the modeled system is unknown.

It uses a system's dynamics model , known control inputs to that system, and multiple sequential measurements (such as from sensors) to form an estimate of the system's varying quantities (its state) that is better than the estimate obtained by using any one measurement alone. As such, it is a common sensor fusion and data fusion algorithm.

## Particle Filter:
This type of filter is an essential tool for tracking and modeling a dynamic system like in this robot navigation project. For example, it could be used to compare and analyze our expected outcome of how the robot navigation changes in time from the given inputs and the expected state the robot at various time intervals. Particle Filtering is also closely related to Kalman filtering but very efficient in solving and bigger and challenging problems. This particle filter is an useful tool for variety of situations especially in tracking, image processing, smart environments and so forth. However we have changed our approach from the traditional monte carlo approach to using a Parzens window with a Gaussian kernel function.

### Parzens Window:
This Density Estimation is an data interpolation techniques where if an instance of the random sample x is given,Parzen-windowing estimates the PDF( Probability Density Function) from where the x originated or derived. The continuous probability function follows these properties
P(a < x < b) =abp(x) dx   which is non-negative for all real x.
To understand this Parzens window more further, we looked into a simple example. Let;s say we have a region R with is a d-dimensional hypercube h, the volume will be h ^d. Then to estimate the density at point x, we center R at x, count the samples in R and input the values in this formula: p(x)=(k/n)/v. If we have a window function, it will be: o(x-xi)/h
To count the total number of sample points, we use the p(x) equation and incoroporate  it with the estimate of dentiy p_0(x)

# Robot Navigation

## Introduction
Navigation consisted of a robots ability to navigate in a predefined and set map. However the maps obstacles will initially be generated at random location and random shapes. The robot will then go on to plan and execute a path trajectory that will get robot to set user location.

## Mapping:
Generating the map and the information gained consisted of several parts. Beginning with generating obstacles at random shapes and places while avoiding any overlaps. A combination of graph theory along with intersects detection techniques were also utilized in order to generate graph that will have the interconnections required for the robot to navigate around those obstacles, as well as avoiding any concaving vertices.

The graph data structure consisted of two layers. One layer connecting all there vertices that make up an object, and another layer for the connections to other vertices that make up other objects.

## TODO:
* Join both navigation and localization simulations.
* Use a circle point intersect method to navigate to locations without touching the actual vertex on an obstacle with the circle center centered at the robots center.
* Fix navigation vitices indexing causing crashes.

## References:

link to processing ide: https://www.processing.org \n
take a look at this source. It might help us figureout how to fix triangulation \n
http://www.telecom.ulg.ac.be/publi/publications/pierlot/Pierlot2011ANewThreeObject/index.html \n

try out the new processing feature that allows you to play with parameter while running code!! Sketch -> Tweak \n


