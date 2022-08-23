function [gx] = g_kToM_2modes(x,P,u,in)
% wrapper around recursive k-ToM observation function
% function [gx] = g_kToM(x,P,u,in)
% A k-ToM learner bases her decision (a=1 or a=0) upon her prediction of
% her opponent's next move, given the game payoff table.
% IN:
%   - x: hidden states (see indexing in inG.indlev)
%   - P: observation param:
%       P(1) = (log-) temperature
%       P(2) = bias [optional]
%   - u: [useless]
%   - inG: input structure (see prepare_kToM.m)
% OUT:
%   - gx: proba that the agent will pick the first option, i.e. gx=P(a=1).
% [see ObsRecGen.m]
compGame = cat(3,[1,0;0,1],[0,1;1,0]); % competitive game
coopGame = cat(3,[1,0;0,1],[1,0;0,1]); % cooperative game

K=1;
role=1;
% in.game = compGame;
[options,dim] = prepare_kToM(K,compGame,role,0);
gx_comp = ObsRecGen(x(1:floor(size(x,1)/2)),P,u,in); % P(a=1)


% in.game = coopGame;
[options,dim] = prepare_kToM(K,coopGame,role,0);
gx_coop = ObsRecGen(x((size(x,1)+1)/2:size(x,1)-1),P,u,in); % P(a=1)

Po_game = x(end);
gx = Po_game * gx_comp + (1-Po_game)*gx_coop ; 