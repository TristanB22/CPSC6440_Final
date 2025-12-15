# CPSC6440_Final
The code for the final project of Yale's CPSC6440 class F'25. The project was written by Tristan Brigham, Teo Dimov, and Oleg Laskov.

This project seeks to build a model that is able to create optimal portfolio weights based on the attributes of wallets and their trading patterns on Polymarket. We take a geometric approach to graph construction in constructing graphs of co-trading relationships between wallets. 

We then use a graph neural network in order to learn how to create optimal portfolios to guarantee forward returns. 

## Running the Program

In order to run the curvature investigation notebook, you will need to start by downloading the data from the [Google Drive link](https://drive.google.com/file/d/1KL0Xn7atcFpEbtqs1gRQ6Q_hsl_zRz0j/view?usp=sharing). This file contains 10 million Polymarket trades that happened during December, 2025. 

This file should be placed in the notebooks folder along with the main notebook for this project. It will automatically read the trades in and run the program, making a GNN that will be able to compute the optimal portfolio weights. 

You should follow a similar process in order to run the market analysis notebook. In order to run that program, the user needs to download the example data from [the Google Drive link for the mappings](https://drive.google.com/file/d/1qtbiaHVd7OMDhzQQz4jav0z-MVcf9MS3/view?usp=sharing) and from [the Google Drive link for the trades](https://drive.google.com/file/d/15p-1E2m1YWf-hwUtUk5dCOmpkSI_Sq4k/view?usp=sharing) and put it in the same folder as the notebook that is being run. This ensures that the data can be processed and used in the notebook. 

## Results

We found through this process that natively geometric approaches to making the features of the graph that we ended up training on was the best approach for generating strong returns. Without the curvature features, the model consistently underperformed compared to when we did include them. 

## Acknowledgements
In the course of this project, we used the online specs for all packages that we used in the project. 