function [gx] = g_Hampton_2games(x,P,u,in)

game1 = in.game1; % player's payoff table
game2 = in.game2; % other's payoff table
player = in.player; % agent's role
Po_game1 = VBA_sigmoid(x(1)); % P(o=1|game1)
Po_game2 = VBA_sigmoid(x(2)); % P(o=1|game2)
Po_game = VBA_sigmoid(x(3)); % P(game1)
DV_game1 = fplayer(Po_game1,exp(P(1)),player,game1); % incentive for a=1 in game 1 
DV_game2 = fplayer(Po_game2,exp(P(2)),player,game2); % incentive for a=1 in game 2
DV = Po_game * DV_game1 + (1-Po_game)*DV_game2 ; 
gx = VBA_sigmoid(DV); % P(a=1)