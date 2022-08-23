function [gx] = g_fictious(x,P,u,in)

game = in.game; % game's payoff table
player = in.player; % agent's role
Po = VBA_sigmoid(x(1)); % P(o=1)
DV = fplayer(Po,exp(P(1)),player,game); % incentive for a=1
gx = VBA_sigmoid(DV+P(2)); % P(a=1) with bias