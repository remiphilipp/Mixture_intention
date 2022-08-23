function [gx] = g_inverse(x,P,u,in)
gx = 1./(P(1)*x+P(2));