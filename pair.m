function strat = pair(p,d)
   % Strategy for splitting pairs.
   if d == 1
       d = d + 10;
   end
   % pair(paired,dealer)
   % 0 = keep pair
   % 1 = split pair
   % Dealer shows:
   %      2 3 4 5 6 7 8 9 T A
   PAIR = [ ...
      1   1 1 1 1 1 1 1 1 1 1
      2   1 1 1 1 1 1 0 0 0 0
      3   1 1 1 1 1 1 0 0 0 0
      4   0 0 0 1 0 0 0 0 0 0
      5   0 0 0 0 0 0 0 0 0 0
      6   1 1 1 1 1 1 0 0 0 0
      7   1 1 1 1 1 1 1 0 0 0
      8   1 1 1 1 1 1 1 1 1 1
      9   1 1 1 1 1 0 1 1 0 0
     10   0 0 0 0 0 0 0 0 0 0 ];
 
   strat = PAIR(p,d);
end
%x = NaN; % Not possible