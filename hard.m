function strat = hard(p,d)
   % Hands without aces.
   if d == 1
       d = d + 10;
   end
   
   % hard(player,dealer)
   % 0 = stand
   % 1 = hit
   % 2 = double down
   % Dealer shows:
   %      2 3 4 5 6 7 8 9 T A
   HARD = [ ...
      1   8 8 8 8 8 8 8 8 8 8       % 8 not possible would be softhand
      2   1 1 1 1 1 1 1 1 1 1       % 2 Aces cannot split again
      3   1 1 1 1 1 1 1 1 1 1
      4   1 1 1 1 1 1 1 1 1 1
      5   1 1 1 1 1 1 1 1 1 1
      6   1 1 1 1 1 1 1 1 1 1
      7   1 1 1 1 1 1 1 1 1 1
      8   1 1 1 1 1 1 1 1 1 1
      9   2 2 2 2 2 1 1 1 1 1
     10   2 2 2 2 2 2 2 2 1 1
     11   2 2 2 2 2 2 2 2 2 2
     12   1 1 0 0 0 1 1 1 1 1
     13   0 0 0 0 0 1 1 1 1 1
     14   0 0 0 0 0 1 1 1 1 1
     15   0 0 0 0 0 1 1 1 1 1
     16   0 0 0 0 0 1 1 1 1 1
     17   0 0 0 0 0 0 0 0 0 0
     18   0 0 0 0 0 0 0 0 0 0
     19   0 0 0 0 0 0 0 0 0 0
     20   0 0 0 0 0 0 0 0 0 0];
   strat = HARD(p,d);
end