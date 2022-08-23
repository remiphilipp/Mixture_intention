function [fx] = f_kToM_2modes(x,P,u,inF)
% wrapper around recursive k-ToM evolution function
% function [fx] = f_kToM(x,P,u,inF)
% A k-ToM agent with k>0 learns the unknown parameters (theta) of her
% opponent's learning and decision rules. Typically, theta includes her
% opponent's prior volatility about herself (which controls the learning
% rate), the behavioural temperature and the bias. In addition, when k>1,
% k-ToM also learns her opponent's sophistication level (k').
% Note that k-ToM assumes that her opponent's parameters can drift over
% trials. How much they can change is controlled by her prior volatility
% about her opponent's parameters. In addition, the agent may partially
% "forget" about her opponent's sophistication level from a trial to the
% next. This effectively dilutes the belief P(k') towards the corresponding
% max-entropic distribution (only if inF.diluteP=1).
% IN:
%   - x: hidden states (see indexing in inF.indlev)
%   - P: evolution params:
%   P(1)= agent's prior opponent's (log-) volatility on opponent's params
%   P(2)= agent's (invsigmoid-) dilution coefficient
%   - u: u(1) = opponent's previous move, u(2) = agent's previous move
%   - inF: input structure (see prepare_kToM.m)
% OUT:
%   - fx: updated hidden states
% [see RecToMfunction.m]

if VBA_isWeird (u) % e.g., 1st trial
    fx = x;
    return
end
fx=x;
compGame = cat(3,[1,0;0,1],[0,1;1,0]); % competitive game
coopGame = cat(3,[1,0;0,1],[1,0;0,1]); % cooperative game

K=inF.lev;
role=inF.player;
% inF.game = compGame;
[options,dim] = prepare_kToM(K,compGame,role,0);
[fx(1:floor(size(x,1)/2),1),indlev] = RecToMfunction(x(1:floor(size(x,1)/2)),P(1:(end-1)/2),u,inF);
% inF.game = coopGame;
[options,dim] = prepare_kToM(K,coopGame,role,0);
[fx((size(x,1)+1)/2:size(x,1)-1,1),indlev] = RecToMfunction(x((size(x,1)+1)/2:size(x,1)-1),P(1+(end-2)/2:end-2),u,inF);
% NB: output indlev is used recursively by RecToMfunction.m
if inF.lev == 1
    po_game1 = VBA_sigmoid(fx(indlev.f));
    po_game2 = VBA_sigmoid(fx((size(x,1)+1)/2+indlev.f));
elseif inF.lev == 2
    po_game1 = VBA_sigmoid(fx(1))* VBA_sigmoid(fx(indlev(1).f)) + (1-VBA_sigmoid(fx(1)))*VBA_sigmoid(fx(indlev(2).f));
    po_game2 = VBA_sigmoid(fx((size(x,1)+1)/2))*VBA_sigmoid(fx((size(x,1)+1)/2 -1 + indlev(1).f)) + (1-VBA_sigmoid(fx((size(x,1)+1)/2)))*VBA_sigmoid(fx((size(x,1)+1)/2 -1 + indlev(2).f));
end

PE1_game1 = u(1) - po_game1 ;
PE1_game2 = u(1) - po_game2 ;
% p_game = 1/(1+exp(-(PE1_game1-PE1_game2+P(2))));
Po_game1 = VBA_sigmoid(po_game1,'inverse',true);
Po_game2 = VBA_sigmoid(po_game2,'inverse',true);
p_game = VBA_sigmoid(abs(Po_game1)-abs(Po_game2),'center',P(5),'slope',P(6));

fx(end) = p_game;
% if VBA_isWeird(fx)
%     0;
% end