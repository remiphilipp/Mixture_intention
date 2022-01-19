function [fx] = f_Hampton_2games_cinq(x,P,u,in)

if VBA_isWeird (u) % e.g., 1st trial
    fx = x;
    return;
end

o = u(1); % opponent's last choice (o)
a = u(2); % agent's last choice (a)
p0_game1 = VBA_sigmoid(x(1)); % previous estimate of P(o=1|game1)
p0_game2 = VBA_sigmoid(x(2)); % previous estimate of P(o=1|game2)
p_game = VBA_sigmoid(x(3)); % previous estimate of P(game1)
eta = VBA_sigmoid(P(1)); % weight of PE1_game
lambda = VBA_sigmoid(P(2)); % weight of PE2_game
beta = exp(P(3)); % opponent's temperature game


% derive first-order prediction error
PE1_game1 = o-p0_game1;
PE1_game2 = o-p0_game2;
PE1 = o-(p0_game1*p_game + (1-p_game)*p0_game2);


% derive second-order prediction error
game1 = in.game1; % game's payoff table
game2 = in.game2; % game's payoff table
player = in.player; % agent's role 
if player==2
    Payoff1 = game1(:,:,1);
    k1_game1 = Payoff1(1,1)-Payoff1(2,1)-Payoff1(1,2)+Payoff1(2,2);
    k2_game1 = Payoff1(2,1)-Payoff1(2,2);
    
    Payoff2 = game2(:,:,1);
    k1_game2 = Payoff2(1,1)-Payoff2(2,1)-Payoff2(1,2)+Payoff2(2,2);
    k2_game2 = Payoff2(2,1)-Payoff2(2,2);
elseif player==1
    Payoff1 = game1(:,:,2);
    k1_game1 = Payoff1(1,1)-Payoff1(2,1)-Payoff1(1,2)+Payoff1(2,2);
    k2_game1 = Payoff1(1,2)-Payoff1(2,2);
    
    Payoff2 = game2(:,:,2);
    k1_game2 = Payoff2(1,1)-Payoff2(2,1)-Payoff2(1,2)+Payoff2(2,2);
    k2_game2 = Payoff2(1,2)-Payoff2(2,2);
end

q0_game1 = (beta.*x(1) - k2_game1)./k1_game1;
PE2_game1 = a-q0_game1;

q0_game2 = (beta.*x(2) - k2_game2)./k1_game2;
PE2_game2 = a-q0_game2;


PE2 = a -(q0_game1*p_game + (1-p_game)*q0_game2);

% "influence" learning rule
p_game1 = p0_game1 + eta*PE1_game1 + lambda*k1_game1*p0_game1*(1-p0_game1)*PE2_game1; % P(o=1|game1)
p_game1 = max([min([p_game1,1]),0]); % bound p between 0 and 1

p_game2 = p0_game2 + eta*PE1_game2 + lambda*k1_game2*p0_game2*(1-p0_game2)*PE2_game2; % P(o=1|game2)
p_game2 = max([min([p_game2,1]),0]); % bound p between 0 and 1


fx(1,1) = VBA_sigmoid(p_game1,'inverse',true); % Comp % for numerical reasons
fx(2,1) = VBA_sigmoid(p_game2,'inverse',true); % Coop % for numerical reasons

p_game = VBA_sigmoid(abs(fx(1,1))-abs(fx(2,1)),'slope',exp(P(4)),'center',P(5)); % The one for fMRI GLM 

fx(3,1) = VBA_sigmoid(p_game,'inverse',true); % P(Be in comp)
fx(4,1) = PE1_game1; % 
fx(5,1) = PE1_game2; % 
fx(6,1) = PE2_game1; 
fx(7,1) = PE2_game2; 
fx(8,1) = PE1; 



