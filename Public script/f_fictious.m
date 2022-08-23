function [fx] = f_fictious(x,P,u,in)


if VBA_isWeird (u) % e.g., 1st trial
    fx = x;
    return;
end

o = u(1); % opponent's last choice (o)
a = u(2); % agent's last choice (a)
p0_game1 = VBA_sigmoid(x(1)); % previous estimate of P(o=1|game1)
eta = VBA_sigmoid(P(1)); % weight of PE



% derive first-order prediction error
PE1 = o-p0_game1;




% "influence" learning rule
p_game1 = p0_game1 + eta*PE1; % P(o=1|game1)
p_game1 = max([min([p_game1,1]),0]); % bound p between 0 and 1

% p_game = 1/(1+exp(-exp(P(4))*(abs(VBA_sigmoid(p_game1,'inverse',true)) - abs(VBA_sigmoid(p_game2,'inverse',true)) + P(5))));


fx(1) = VBA_sigmoid(p_game1,'inverse',true); % Comp % for numerical reasons