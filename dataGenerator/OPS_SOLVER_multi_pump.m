 
function [result,z_index]=OPS_SOLVER_multi_pump(V1_0, V2_0, Z1_0, Z2_0, Z3_0, Z4_0, S0,D_past,Eprize,U1,U2,U3,U4,param)

%This is very inefficient way of coding due to a deadline!
T=param.T;
Ts=param.Ts;
Vmax=param.Vmax;
Vmin=param.Vmin;
Emax=param.Emax;
Umax=param.Umax;
Umin=param.Umin;
tau=param.tau;
Fmax=param.Fmax;
Fmin=param.Fmin;
Nsw1=param.Nsw1;
Nsw2=param.Nsw2;
Nsw3=param.Nsw3;
Nsw4=param.Nsw4;
NumVect=param.NumVect;
%%
%--------------------------------
% Structure of variable for T=4
%--------------------------------
%z0 -1
%z1 -2
%z2 -3
%z3 -4

%w0 -5
%w1 -6
%w2 -7
%w3 -8
%d0 -9
%d1 -10
%d2 -11
%d3 -12
%s0 -13
%s1 -14
%s2 -15
%s3 -16
%v0 -17
%v1 -18
%v2 -19
%v3 -20
%f0 -21
%f1 -22
%f2 -23
%f3 -24

%-----------------------------
VarNum=NumVect*T; % totoal number of variables
OneVect=ones(T,1);
ZeroVect=zeros(T,1);
% ZeroVectBig=repmat(ZeroVect,NumVect,1)';
ZeroVectBig=zeros(1,VarNum);

z1_pos=1;
w1_pos=2;
d1_pos=3;
s1_pos=4;
v1_pos=5;
f1_pos=6;

z2_pos=7;
w2_pos=8;
d2_pos=9;
s2_pos=10;
v2_pos=11;
f2_pos=12;

z3_pos=13;
w3_pos=14;
d3_pos=15;
s3_pos=16;
f3_pos=17;

z4_pos=18;
w4_pos=19;
d4_pos=20;
s4_pos=21;
f4_pos=22;

% z5_pos=23;
% w5_pos=24;
% d5_pos=25;
% s5_pos=26;
% f5_pos=27;
% 
% z6_pos=30;
% w6_pos=31;
% d6_pos=32;
% s6_pos=33;
% f6_pos=34;


z1_idx=(z1_pos-1)*T+1;
w1_idx=(w1_pos-1)*T+1;
d1_idx=(d1_pos-1)*T+1;
s1_idx=(s1_pos-1)*T+1;
v1_idx=(v1_pos-1)*T+1;
f1_idx=(f1_pos-1)*T+1;


z2_idx=(z2_pos-1)*T+1;
w2_idx=(w2_pos-1)*T+1;
d2_idx=(d2_pos-1)*T+1;
s2_idx=(s2_pos-1)*T+1;
v2_idx=(v2_pos-1)*T+1;
f2_idx=(f2_pos-1)*T+1;


z3_idx=(z3_pos-1)*T+1;
w3_idx=(w3_pos-1)*T+1;
d3_idx=(d3_pos-1)*T+1;
s3_idx=(s3_pos-1)*T+1;
f3_idx=(f3_pos-1)*T+1;


z4_idx=(z4_pos-1)*T+1;
w4_idx=(w4_pos-1)*T+1;
d4_idx=(d4_pos-1)*T+1;
s4_idx=(s4_pos-1)*T+1;
f4_idx=(f4_pos-1)*T+1;

z_index=[z1_idx;z2_idx;z3_idx;z4_idx];
% z5_idx=(z5_pos-1)*T+1;
% w5_idx=(w5_pos-1)*T+1;
% d5_idx=(d5_pos-1)*T+1;
% s5_idx=(s5_pos-1)*T+1;
% v5_idx=(v5_pos-1)*T+1;
% f5_idx=(f5_pos-1)*T+1;
% 
% 
% z6_idx=(z6_pos-1)*T+1;
% w6_idx=(w6_pos-1)*T+1;
% d6_idx=(d6_pos-1)*T+1;
% s6_idx=(s6_pos-1)*T+1;
% v6_idx=(v6_pos-1)*T+1;
% f6_idx=(f6_pos-1)*T+1;

%---------------------
%  Initialization
%---------------------

% #1
C_v1_0=ZeroVectBig;
C_v1_0(v1_idx)=1;
C_v1_0_rhs=V1_0;
C_v1_0_sense='=';

%
C_v2_0=ZeroVectBig;
C_v2_0(v2_idx)=1;
C_v2_0_rhs=V2_0;
C_v2_0_sense='=';


% #2
C_z1_0=ZeroVectBig;
C_z1_0(z1_idx)=1;
C_z1_0_rhs=Z1_0;
C_z1_0_sense='=';

C_z2_0=ZeroVectBig;
C_z2_0(z2_idx)=1;
C_z2_0_rhs=Z2_0;
C_z2_0_sense='=';

C_z3_0=ZeroVectBig;
C_z3_0(z3_idx)=1;
C_z3_0_rhs=Z3_0;
C_z3_0_sense='=';

C_z4_0=ZeroVectBig;
C_z4_0(z4_idx)=1;
C_z4_0_rhs=Z4_0;
C_z4_0_sense='=';







% #3
C_s1_0=ZeroVectBig;
C_s1_0(s1_idx)=1;
C_s1_0_rhs=S0;
C_s1_0_sense='=';

C_s2_0=ZeroVectBig;
C_s2_0(s2_idx)=1;
C_s2_0_rhs=S0;
C_s2_0_sense='=';

C_s3_0=ZeroVectBig;
C_s3_0(s3_idx)=1;
C_s3_0_rhs=S0;
C_s3_0_sense='=';

C_s4_0=ZeroVectBig;
C_s4_0(s4_idx)=1;
C_s4_0_rhs=S0;
C_s4_0_sense='=';




%-----






%---------------------
% #4 z_t+1=z_t+w_t
%---------------------
Cpattern=ZeroVectBig;
Cpattern(z1_idx)=-1;
Cpattern(z1_idx+1)=1;
Cpattern(w1_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);
    C_z1(n,:)=Cpattern;
end
C_z1_rhs=zeros(T-1,1);
C_z1_sense=repmat('=',T-1,1);
%--

Cpattern=ZeroVectBig;
Cpattern(z2_idx)=-1;
Cpattern(z2_idx+1)=1;
Cpattern(w2_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);
    C_z2(n,:)=Cpattern;
end
C_z2_rhs=zeros(T-1,1);
C_z2_sense=repmat('=',T-1,1);
%--

Cpattern=ZeroVectBig;
Cpattern(z3_idx)=-1;
Cpattern(z3_idx+1)=1;
Cpattern(w3_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);
    C_z3(n,:)=Cpattern;
end
C_z3_rhs=zeros(T-1,1);
C_z3_sense=repmat('=',T-1,1);
%--

Cpattern=ZeroVectBig;
Cpattern(z4_idx)=-1;
Cpattern(z4_idx+1)=1;
Cpattern(w4_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);
    C_z4(n,:)=Cpattern;
end
C_z4_rhs=zeros(T-1,1);
C_z4_sense=repmat('=',T-1,1);
%--



%---------------------
% #5 v_t<=v_max
%---------------------
Cpattern=ZeroVectBig;
Cpattern(v1_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_v1_R(n,:)=Cpattern;
end
C_v1_R_rhs=repmat(Vmax,T,1);
C_v1_R_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(v2_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_v2_R(n,:)=Cpattern;
end
C_v2_R_rhs=repmat(Vmax,T,1);
C_v2_R_sense=repmat('<',T,1);



%---------------------
% #6 v_t>=v_min
%---------------------
C_v1_L=C_v1_R;
C_v1_L_rhs=repmat(Vmin,T,1);
C_v1_L_sense=repmat('>',T,1);

C_v2_L=C_v2_R;
C_v2_L_rhs=repmat(Vmin,T,1);
C_v2_L_sense=repmat('>',T,1);


%---------------------
% #7 f_t<=z_t*F_max
%---------------------
Cpattern=ZeroVectBig;
Cpattern(z1_idx)=-Fmax;
Cpattern(f1_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f1_R(n,:)=Cpattern;
end
C_f1_R_rhs=ZeroVect;
C_f1_R_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(z2_idx)=-Fmax;
Cpattern(f2_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f2_R(n,:)=Cpattern;
end
C_f2_R_rhs=ZeroVect;
C_f2_R_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(z3_idx)=-Fmax;
Cpattern(f3_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f3_R(n,:)=Cpattern;
end
C_f3_R_rhs=ZeroVect;
C_f3_R_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(z4_idx)=-Fmax;
Cpattern(f4_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f4_R(n,:)=Cpattern;
end
C_f4_R_rhs=ZeroVect;
C_f4_R_sense=repmat('<',T,1);


%---------------------
% #8 f_t>=0
%---------------------
Cpattern=ZeroVectBig;
Cpattern(z1_idx)=-Fmin;
Cpattern(f1_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f1_L(n,:)=Cpattern;
end
C_f1_L_rhs=ZeroVect;
C_f1_L_sense=repmat('>',T,1);

Cpattern=ZeroVectBig;
Cpattern(z2_idx)=-Fmin;
Cpattern(f2_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f2_L(n,:)=Cpattern;
end
C_f2_L_rhs=ZeroVect;
C_f2_L_sense=repmat('>',T,1);


Cpattern=ZeroVectBig;
Cpattern(z3_idx)=-Fmin;
Cpattern(f3_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f3_L(n,:)=Cpattern;
end
C_f3_L_rhs=ZeroVect;
C_f3_L_sense=repmat('>',T,1);


Cpattern=ZeroVectBig;
Cpattern(z4_idx)=-Fmin;
Cpattern(f4_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_f4_L(n,:)=Cpattern;
end
C_f4_L_rhs=ZeroVect;
C_f4_L_sense=repmat('>',T,1);


%---------------------
% #9 v_t+1=v_t+tau*(f_t-U_t)
%---------------------
Cpattern=ZeroVectBig;
Cpattern(v1_idx)=-1;
Cpattern(v1_idx+1)=1;
Cpattern(f1_idx)=-tau;
Cpattern(f2_idx)=-tau;
Cpattern(f3_idx)=-tau;
Cpattern(f4_idx)=-tau;

Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);
    C_v1_Eq(n,:)=Cpattern;
end
C_v1_Eq_rhs=-tau*U1;
C_v1_Eq_sense=repmat('=',T-1,1);

Cpattern=ZeroVectBig;
Cpattern(v2_idx)=-1;
Cpattern(v2_idx+1)=1;
Cpattern(f1_idx)=-tau;
Cpattern(f2_idx)=-tau;
Cpattern(f3_idx)=-tau;
Cpattern(f4_idx)=-tau;

Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);
    C_v2_Eq(n,:)=Cpattern;
end
C_v2_Eq_rhs=-tau*U2;
C_v2_Eq_sense=repmat('=',T-1,1);


%---------------------
% #10 s_t<=Nsw
%---------------------
Cpattern=ZeroVectBig;
Cpattern(s1_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_s1_limit(n,:)=Cpattern;
end
C_s1_limit_rhs=repmat(Nsw1,T,1);
C_s1_limit_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(s2_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_s2_limit(n,:)=Cpattern;
end
C_s2_limit_rhs=repmat(Nsw2,T,1);
C_s2_limit_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(s3_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_s3_limit(n,:)=Cpattern;
end
C_s3_limit_rhs=repmat(Nsw3,T,1);
C_s3_limit_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(s4_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_s4_limit(n,:)=Cpattern;
end
C_s4_limit_rhs=repmat(Nsw4,T,1);
C_s4_limit_sense=repmat('<',T,1);


%--------------------------------
% #11 s_{t+1}=s_t+d_t-d_{t-T_s}
%---------------------------------
Cpattern=ZeroVectBig;
Cpattern(s1_idx)=-1;
Cpattern(s1_idx+1)=1;
Cpattern(d1_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);        
    C_s1(n,:)=Cpattern;
end
C_s1_rhs=repmat(0,T-1,1);

for n=1:T-1% logic to sub
    Cpattern=ZeroVectBig;
    past_sample_idx=n-1-Ts;
    if past_sample_idx < 0
        C_s1_rhs(n)=-D_past(-past_sample_idx);
    else
        C_s1(n,d1_idx+past_sample_idx)=1;
    end
end

C_s1_sense=repmat('=',T-1,1);


Cpattern=ZeroVectBig;
Cpattern(s2_idx)=-1;
Cpattern(s2_idx+1)=1;
Cpattern(d2_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);        
    C_s2(n,:)=Cpattern;
end
C_s2_rhs=repmat(0,T-1,1);

for n=1:T-1% logic to sub
    Cpattern=ZeroVectBig;
    past_sample_idx=n-1-Ts;
    if past_sample_idx < 0
        C_s2_rhs(n)=-D_past(-past_sample_idx);
    else
        C_s2(n,d2_idx+past_sample_idx)=1;
    end
end

C_s2_sense=repmat('=',T-1,1);


Cpattern=ZeroVectBig;
Cpattern(s3_idx)=-1;
Cpattern(s3_idx+1)=1;
Cpattern(d3_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);        
    C_s3(n,:)=Cpattern;
end
C_s3_rhs=repmat(0,T-1,1);

for n=1:T-1% logic to sub
    Cpattern=ZeroVectBig;
    past_sample_idx=n-1-Ts;
    if past_sample_idx < 0
        C_s3_rhs(n)=-D_past(-past_sample_idx);
    else
        C_s3(n,d3_idx+past_sample_idx)=1;
    end
end

C_s3_sense=repmat('=',T-1,1);




Cpattern=ZeroVectBig;
Cpattern(s4_idx)=-1;
Cpattern(s4_idx+1)=1;
Cpattern(d4_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T-1
    Cpattern=circshift(Cpattern,1);        
    C_s4(n,:)=Cpattern;
end
C_s4_rhs=repmat(0,T-1,1);

for n=1:T-1% logic to sub
    Cpattern=ZeroVectBig;
    past_sample_idx=n-1-Ts;
    if past_sample_idx < 0
        C_s4_rhs(n)=-D_past(-past_sample_idx);
    else
        C_s4(n,d4_idx+past_sample_idx)=1;
    end
end

C_s4_sense=repmat('=',T-1,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% G(w_t z_t w_t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=[0 0 3 1];
%--------------------------
% #12 (1 0 -1)'*(w_t z_t d_t)<0
%--------------------------
Cpattern=ZeroVectBig;
Cpattern(w1_idx)=1;
Cpattern(z1_idx)=0;
Cpattern(d1_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G1_1(n,:)=Cpattern;
end
C_G1_1_rhs=repmat(g(1),T,1);
C_G1_1_sense=repmat('<',T,1);

Cpattern=ZeroVectBig;
Cpattern(w2_idx)=1;
Cpattern(z2_idx)=0;
Cpattern(d2_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G2_1(n,:)=Cpattern;
end
C_G2_1_rhs=repmat(g(1),T,1);
C_G2_1_sense=repmat('<',T,1);



Cpattern=ZeroVectBig;
Cpattern(w3_idx)=1;
Cpattern(z3_idx)=0;
Cpattern(d3_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G3_1(n,:)=Cpattern;
end
C_G3_1_rhs=repmat(g(1),T,1);
C_G3_1_sense=repmat('<',T,1);



Cpattern=ZeroVectBig;
Cpattern(w4_idx)=1;
Cpattern(z4_idx)=0;
Cpattern(d4_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G4_1(n,:)=Cpattern;
end
C_G4_1_rhs=repmat(g(1),T,1);
C_G4_1_sense=repmat('<',T,1);


%--------------------------
% #13 (-1 0 -1)'*(w_t z_t d_t)<0
%--------------------------
Cpattern=ZeroVectBig;
Cpattern(w1_idx)=-1;
Cpattern(z1_idx)=0;
Cpattern(d1_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G1_2(n,:)=Cpattern;
end
C_G1_2_rhs=repmat(g(2),T,1);
C_G1_2_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w2_idx)=-1;
Cpattern(z2_idx)=0;
Cpattern(d2_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G2_2(n,:)=Cpattern;
end
C_G2_2_rhs=repmat(g(2),T,1);
C_G2_2_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w3_idx)=-1;
Cpattern(z3_idx)=0;
Cpattern(d3_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G3_2(n,:)=Cpattern;
end
C_G3_2_rhs=repmat(g(2),T,1);
C_G3_2_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w4_idx)=-1;
Cpattern(z4_idx)=0;
Cpattern(d4_idx)=-1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G4_2(n,:)=Cpattern;
end
C_G4_2_rhs=repmat(g(2),T,1);
C_G4_2_sense=repmat('<',T,1);

%--------------------------
%#14 (1 2 2)'*(w_t z_t d_t)<0
%--------------------------
Cpattern=ZeroVectBig;
Cpattern(w1_idx)=1;
Cpattern(z1_idx)=2;
Cpattern(d1_idx)=2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G1_3(n,:)=Cpattern;
end
C_G1_3_rhs=repmat(g(3),T,1);
C_G1_3_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w2_idx)=1;
Cpattern(z2_idx)=2;
Cpattern(d2_idx)=2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G2_3(n,:)=Cpattern;
end
C_G2_3_rhs=repmat(g(3),T,1);
C_G2_3_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w3_idx)=1;
Cpattern(z3_idx)=2;
Cpattern(d3_idx)=2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G3_3(n,:)=Cpattern;
end
C_G3_3_rhs=repmat(g(3),T,1);
C_G3_3_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w4_idx)=1;
Cpattern(z4_idx)=2;
Cpattern(d4_idx)=2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G4_3(n,:)=Cpattern;
end
C_G4_3_rhs=repmat(g(3),T,1);
C_G4_3_sense=repmat('<',T,1);

%--------------------------
%#15 (-1 -2 2)'*(w_t z_t d_t)<0
%--------------------------
Cpattern=ZeroVectBig;
Cpattern(w1_idx)=-1;
Cpattern(z1_idx)=-2;
Cpattern(d1_idx)= 2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G1_4(n,:)=Cpattern;
end
C_G1_4_rhs=repmat(g(4),T,1);
C_G1_4_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w2_idx)=-1;
Cpattern(z2_idx)=-2;
Cpattern(d2_idx)= 2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G2_4(n,:)=Cpattern;
end
C_G2_4_rhs=repmat(g(4),T,1);
C_G2_4_sense=repmat('<',T,1);



Cpattern=ZeroVectBig;
Cpattern(w3_idx)=-1;
Cpattern(z3_idx)=-2;
Cpattern(d3_idx)= 2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G3_4(n,:)=Cpattern;
end
C_G3_4_rhs=repmat(g(4),T,1);
C_G3_4_sense=repmat('<',T,1);



Cpattern=ZeroVectBig;
Cpattern(w4_idx)=-1;
Cpattern(z4_idx)=-2;
Cpattern(d4_idx)= 2;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_G4_4(n,:)=Cpattern;
end
C_G4_4_rhs=repmat(g(4),T,1);
C_G4_4_sense=repmat('<',T,1);


%---------------------
% #16 w_t<=1
%---------------------
Cpattern=ZeroVectBig;
Cpattern(w1_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w1_R(n,:)=Cpattern;
end
C_w1_R_rhs=repmat(1,T,1);
C_w1_R_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w2_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w2_R(n,:)=Cpattern;
end
C_w2_R_rhs=repmat(1,T,1);
C_w2_R_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w3_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w3_R(n,:)=Cpattern;
end
C_w3_R_rhs=repmat(1,T,1);
C_w3_R_sense=repmat('<',T,1);


Cpattern=ZeroVectBig;
Cpattern(w4_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w4_R(n,:)=Cpattern;
end
C_w4_R_rhs=repmat(1,T,1);
C_w4_R_sense=repmat('<',T,1);




%---------------------
% #17 w_t>=-1
%---------------------
Cpattern=ZeroVectBig;
Cpattern(w1_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w1_L(n,:)=Cpattern;
end
C_w1_L_rhs=repmat(-1,T,1);
C_w1_L_sense=repmat('>',T,1);


Cpattern=ZeroVectBig;
Cpattern(w2_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w2_L(n,:)=Cpattern;
end
C_w2_L_rhs=repmat(-1,T,1);
C_w2_L_sense=repmat('>',T,1);

Cpattern=ZeroVectBig;
Cpattern(w3_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w3_L(n,:)=Cpattern;
end
C_w3_L_rhs=repmat(-1,T,1);
C_w3_L_sense=repmat('>',T,1);



Cpattern=ZeroVectBig;
Cpattern(w4_idx)=1;
Cpattern=circshift(Cpattern,-1);
for n=1:T
    Cpattern=circshift(Cpattern,1);
    C_w4_L(n,:)=Cpattern;
end
C_w4_L_rhs=repmat(-1,T,1);
C_w4_L_sense=repmat('>',T,1);



C_BiGMx     =[C_v1_0;C_v2_0;...
    C_z1_0;C_z2_0;C_z3_0;C_z4_0;...
    C_s1_0;C_s2_0;C_s3_0;C_s4_0;...
    C_z1;C_z2;C_z3;C_z4;...
    C_v1_R;C_v2_R;...
    C_v1_L;C_v2_L;...
    C_f1_R;C_f2_R;C_f3_R;C_f4_R;...
    C_f1_L;C_f2_L;C_f3_L;C_f4_L;...
    C_v1_Eq;C_v2_Eq;...
    C_s1_limit;C_s2_limit;C_s3_limit;C_s4_limit;...
    C_s1;C_s2;C_s3;C_s4;...
    C_G1_1;C_G2_1;C_G3_1;C_G4_1;...
    C_G1_2;C_G2_2;C_G3_2;C_G4_2;...
    C_G1_3;C_G2_3;C_G3_3;C_G4_3;...
    C_G1_4;C_G2_4;C_G3_4;C_G4_4;...
    C_w1_R;C_w2_R;C_w3_R;C_w4_R;...
    C_w1_L;C_w2_L;C_w3_L;C_w4_L];
%%
C_rhs_BigVec=[C_v1_0_rhs;C_v2_0_rhs;...
    C_z1_0_rhs;C_z2_0_rhs;C_z3_0_rhs;C_z4_0_rhs;...
    C_s1_0_rhs;C_s2_0_rhs;C_s3_0_rhs;C_s4_0_rhs;...
    C_z1_rhs;C_z2_rhs;C_z3_rhs;C_z4_rhs;...
    C_v1_R_rhs;C_v2_R_rhs;...
    C_v1_L_rhs;C_v2_L_rhs;...
    C_f1_R_rhs;C_f2_R_rhs;C_f3_R_rhs;C_f4_R_rhs;...
    C_f1_L_rhs;C_f2_L_rhs;C_f3_L_rhs;C_f4_L_rhs;...
    C_v1_Eq_rhs';C_v2_Eq_rhs';...
    C_s1_limit_rhs;C_s2_limit_rhs;C_s3_limit_rhs;C_s4_limit_rhs;...
    C_s1_rhs;C_s2_rhs;C_s3_rhs;C_s4_rhs;...
    C_G1_1_rhs;C_G2_1_rhs;C_G3_1_rhs;C_G4_1_rhs;...
    C_G1_2_rhs;C_G2_2_rhs;C_G3_2_rhs;C_G4_2_rhs;...
    C_G1_3_rhs;C_G2_3_rhs;C_G3_3_rhs;C_G4_3_rhs;...
    C_G1_4_rhs;C_G2_4_rhs;C_G3_4_rhs;C_G4_4_rhs;...
    C_w1_R_rhs;C_w2_R_rhs;C_w3_R_rhs;C_w4_R_rhs;...
    C_w1_L_rhs;C_w2_L_rhs;C_w3_L_rhs;C_w4_L_rhs];
%%
C_sense_BigVec=[C_v1_0_sense;C_v2_0_sense;...
    C_z1_0_sense;C_z2_0_sense;C_z3_0_sense;C_z4_0_sense;...
    C_s1_0_sense;C_s2_0_sense;C_s3_0_sense;C_s4_0_sense;...
    C_z1_sense;C_z2_sense;C_z3_sense;C_z4_sense;...
    C_v1_R_sense;C_v2_R_sense;...
    C_v1_L_sense;C_v2_L_sense;...
    C_f1_R_sense;C_f2_R_sense;C_f3_R_sense;C_f4_R_sense;...
    C_f1_L_sense;C_f2_L_sense;C_f3_L_sense;C_f4_L_sense;...
    C_v1_Eq_sense;C_v2_Eq_sense;...
    C_s1_limit_sense;C_s2_limit_sense;C_s3_limit_sense;C_s4_limit_sense;...
    C_s1_sense;C_s2_sense;C_s3_sense;C_s4_sense;...
    C_G1_1_sense;C_G2_1_sense;C_G3_1_sense;C_G4_1_sense;...
    C_G1_2_sense;C_G2_2_sense;C_G3_2_sense;C_G4_2_sense;...
    C_G1_3_sense;C_G2_3_sense;C_G3_3_sense;C_G4_3_sense;...
    C_G1_4_sense;C_G2_4_sense;C_G3_4_sense;C_G4_4_sense;...
    C_w1_R_sense;C_w2_R_sense;C_w3_R_sense;C_w4_R_sense;...
    C_w1_L_sense;C_w2_L_sense;C_w3_L_sense;C_w4_L_sense;];



C_z1_type=repmat('B',T,1);
C_w1_type=repmat('I',T,1);
C_d1_type=repmat('B',T,1);
C_s1_type=repmat('I',T,1);
C_v1_type=repmat('C',T,1);
C_f1_type=repmat('C',T,1);

C_z2_type=repmat('B',T,1);
C_w2_type=repmat('I',T,1);
C_d2_type=repmat('B',T,1);
C_s2_type=repmat('I',T,1);
C_v2_type=repmat('C',T,1);
C_f2_type=repmat('C',T,1);

C_z3_type=repmat('B',T,1);
C_w3_type=repmat('I',T,1);
C_d3_type=repmat('B',T,1);
C_s3_type=repmat('I',T,1);
C_f3_type=repmat('C',T,1);

C_z4_type=repmat('B',T,1);
C_w4_type=repmat('I',T,1);
C_d4_type=repmat('B',T,1);
C_s4_type=repmat('I',T,1);
C_f4_type=repmat('C',T,1);

VarType=[C_z1_type' C_w1_type' C_d1_type' C_s1_type' C_v1_type' C_f1_type' ...
         C_z2_type' C_w2_type' C_d2_type' C_s2_type' C_v2_type' C_f2_type' ...
         C_z3_type' C_w3_type' C_d3_type' C_s3_type'            C_f3_type' ...
         C_z4_type' C_w4_type' C_d4_type' C_s4_type'            C_f4_type'];



    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

model.obj = [Eprize'; zeros(T*5,1);Eprize'; zeros(T*5,1);...
    Eprize'; zeros(T*4,1);Eprize'; zeros(T*4,1)];

model.A = sparse(C_BiGMx);
model.rhs = C_rhs_BigVec;
model.sense = C_sense_BigVec';
model.vtype = VarType;

model.modelsense = 'min';
model.lb=-1*ones(VarNum,1);

gurobi_write(model, 'mix_int.lp');

params.outputflag = 0;

result = gurobi(model, params);
end
% Gurobi_run_time=toc;