clc; clear all;

num_samples=200000;
T=24; % horizon length
Ts=5;
Vmax=100; 
Vmin=30;
Emax=10;
Emin=1;
Umax=20;
Umin=0;
tau=1;
Fmax=20;
Fmin=0;
Nsw1=5;
Nsw2=5;
Nsw3=5;
Nsw4=5;

NumVect=6*4-2;
%%%%Parameter Logging
param.T=T;
param.Ts=Ts;
param.Vmax=Vmax;
param.Vmin=Vmin;
param.Emax=Emax;
param.Umax=Umax;
param.Umin=Umin;
param.tau=tau;
param.Fmax=Fmax;
param.Fmin=Fmin;
param.Nsw1=Nsw1;
param.Nsw2=Nsw2;
param.Nsw3=Nsw3;
param.Nsw4=Nsw4;
param.NumVect=NumVect;

delete feasible_input_log.csv
delete feasible_output_log.csv
delete DNN_train_input.csv
delete DNN_train_output.csv
delete DNN_test_input.csv
delete DNN_test_output.csv

num_feasible_samples=0;
tic
for sampling_index=1:num_samples
Vmin2=Vmin+10;    
    
V1_0=(Vmax-Vmin2)*rand(1,1) + Vmin2;
V2_0=(Vmax-Vmin2)*rand(1,1) + Vmin2;

   
Z1_0=randi([0,1],1);
Z2_0=randi([0,1],1);
Z3_0=randi([0,1],1);
Z4_0=randi([0,1],1);

D_past=randi([0,1],T,1);
S0=sum(D_past(1:Ts));
Eprize= (Emax-Emin)*rand(T,1) + Emin;

User_Demand1= (Umax-Umin)*rand(T-1,1) + Umin;
User_Demand2= (Umax-Umin)*rand(T-1,1) + Umin;   
User_Demand3= (Umax-Umin)*rand(T-1,1) + Umin;   
User_Demand4= (Umax-Umin)*rand(T-1,1) + Umin;   


DNN_input=[V1_0 V2_0 Z1_0 Z2_0 Z3_0 Z4_0 S0 D_past' Eprize' User_Demand1' User_Demand2' User_Demand3' User_Demand4'];
  
   
[result,z_index]=OPS_SOLVER_multi_pump(V1_0, V2_0, Z1_0, Z2_0, Z3_0, Z4_0, S0, D_past', Eprize', ...
    User_Demand1', User_Demand2', User_Demand3', User_Demand4',param); 



%length(result.status)=7 =>result.status='OPTIMAL'
display(strcat('num_iternation =', num2str(sampling_index),': ',string(result.status)))

if length(result.status)==7
    out_log=result.x;
    z1_log=out_log(z_index(1):z_index(1)+T-1);
    z2_log=out_log(z_index(2):z_index(2)+T-1);
    z3_log=out_log(z_index(3):z_index(3)+T-1);
    z4_log=out_log(z_index(4):z_index(4)+T-1);
    z_log=[z1_log;z2_log;z3_log;z4_log];
    num_feasible_samples=num_feasible_samples+1;
    dlmwrite('feasible_input_log.csv',DNN_input,'delimiter',',','-append');
    dlmwrite('feasible_output_log.csv',z_log','delimiter',',','-append');
end
end
train_data_generation_time=toc;


% training_index=round(0.8*num_feasible_samples);
% stored_input=dlmread('feasible_input_log.csv');
% stored_output=dlmread('feasible_output_log.csv');
% 
% dlmwrite('DNN_train_input.csv',stored_input(1:training_index,:),'delimiter',',','-append');
% dlmwrite('DNN_test_input.csv',stored_input(training_index+1:end,:),'delimiter',',','-append');
% 
% dlmwrite('DNN_train_output.csv',stored_output(1:training_index,:),'delimiter',',','-append');
% dlmwrite('DNN_test_output.csv',stored_output(training_index+1:end,:),'delimiter',',','-append');

display('----------------------------------------------------------------');
display('----------------------------------------------------------------');
display(strcat('number of feasible samples=',num2str(num_feasible_samples)));
% display(strcat('number of training samples=',num2str(training_index)));
% display(strcat('number of test samples=',num2str(num_feasible_samples-training_index)));
display(strcat('time for data generation=',num2str(train_data_generation_time)));
display('----------------------------------------------------------------');
display('----------------------------------------------------------------');





















