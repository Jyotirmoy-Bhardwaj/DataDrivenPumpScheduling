# DataDrivenPumpSchedulingDL:
This is a binary classification problem addressed by deep learning. In this work, the objective is to design a data-driven controller, which could estimate the pump scheduling of a given water distribution network in real-time. The data-driven controller is designed from a feed-forward deep neural network,  and the necessary dataset is obtained from the state-of-the-art mixed-integer solver. One may question the necessity to design a data-driven controller even though there exists mixed-integer solvers (such as Gurobi). The primary reason is that computing an optimal pump scheduling of a large-scale water distribution network is an NP-Hard problem. Solving such problems using traditional optimization solvers is a computationally inefficient approach. Therefore, we presented a data-driven controller using deep learning, which can potentially estimate the time-ahead pump scheduling given the estimated nodal water demand. This controler is tested for various time horizons such as T = 10 hrs, T=15 Hrs, T= 20 Hrs, and T=24 Hrs). The results demonstrates that this controller can potentially estimate the time ahead pump scheduling with error < 0.001. Kindly **refer** [[1]](#1).      

# Requirements:
tensorflow <br/>
scipy <br/>
Gurobi <br/>
cvxopt <br/>
matplotlib <br/>
pandas <br/>
sklearn <br/>
opencv-python <br/>
Jupyter notebook <br/>




## References
<a id="1">[1]</a> 

