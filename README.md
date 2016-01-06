# Model-of-Segregation
Schelling's Model of Segregation

This project is based on the outline described here: http://nifty.stanford.edu/2014/mccown-schelling-model-segregation/

In this simulation, red and blue people(colored squares) are randomly assigned locations on a grid (white meaning empty). 
In each round, every person that is uncomfortable will move to a random available white square on the grid. The threshold
in this simulation for determining uncomfortableness is 3 neighbors. As long as at least three neighbors are of the same
color, then that person feels comfortable and won't move.

The purpose of this simulation and model is to show how segregation is robust and can occur even though no one individual
is actively seeking it. On the local level each person desires to be comfortable. On the global level this desire creates
the aggregate behavior of segregation.

More thoughts and discussion about Schelling's Model of Segregation can be found in Chapter 4.5 of David Easly and 
Jon Kleinberg's free online book: Networks, Crowds, and Markets (http://www.cs.cornell.edu/home/kleinber/networks-book/)
