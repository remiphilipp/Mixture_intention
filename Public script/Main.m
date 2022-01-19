clear all
load('.\Public data\data_social_struct.mat')


Subj_list = [1:32];


for num_sub=Subj_list %num_sub = 1:size(datastruct,2)
    
    y=datastruct(num_sub).Social.data(:,4) .* 0.5 - 0.5;
    z=datastruct(num_sub).Social.data(:,5) .* 0.5 - 0.5;
    fb=datastruct(num_sub).Social.data(:,2);
    isYout = zeros(1,size(y,1));
    isYout(find((y~=0) .* (y~=1))) = 1; isYout=isYout;
    y(isYout==1)=0;
    N = size(y,1); % number of tiral
    z(find((z~=1 .* z~=0)))=0;
    
    
    options.verbose = 1;
    options.isYout = isYout;
    f_fname = @f_influence_2games; % @f_Hampton_2games_fixedArbitrator;
    g_fname = @g_influence_2games;
    u =[NaN,z(1:end-1)' ;   % previous response
        NaN,y(1:end-1)' ;];  % previous choice
    
    
    payoffTable1 = cat(3,[1,0;0,1],[0,1;1,0]); % game payoff matrix (here: hide-and-seek)
    payoffTable2 = cat(3,[1,0;0,1],[1,0;0,1]); % game payoff matrix (here: matching pennies)
    role = 1;  % player's role (here: 1=seeker, 2=hider)
    
    % simulation parameters
    dim = struct('n',8,'n_theta',5,'n_phi',2);
    
    options.inF = struct('game1',payoffTable1,'game2',payoffTable2,'player',role);
    options.inG = struct('game1',payoffTable1,'game2',payoffTable2,'player',role);
    options.skipf = zeros(1,N);
    options.skipf(1) = 1;
    options.binomial = 1;
    options.DisplayWin = 1;
    options.updateX0 = 0;
    
    [posterior{num_sub},out{num_sub}] = VBA_NLStateSpaceModel(y',u,f_fname,g_fname,dim,options);
end