function strat = soft(p,d)
   % Hands with aces.
   if d == 1
       d = d + 10;
   end
       
   % soft(player-11, dealer) (Ace = 1)
   % 0 = stand      
   % 1 = hit
   % 2 = double down
   % Dealer shows:
   %      2 3 4 5 6 7 8 9 T A
   SOFT = [ ...
      1   1 1 1 1 1 1 1 1 1 1
      2   1 1 2 2 2 1 1 1 1 1
      3   1 1 2 2 2 1 1 1 1 1
      4   1 1 2 2 2 1 1 1 1 1
      5   1 1 2 2 2 1 1 1 1 1
      6   2 2 2 2 2 1 1 1 1 1
      7   0 2 2 2 2 0 0 1 1 0
      8   0 0 0 0 0 0 0 0 0 0
      9   0 0 0 0 0 0 0 0 0 0];
   strat = SOFT(p,d);
end