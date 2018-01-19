function [outcome,deck,count,pcards,dcards] = blackjack(pcards,dcards,deck,count)

% Stratagey if the player has a pair
if pcards(1) == pcards(2)
    [outcome,deck,count,pcards,dcards] = pairhand(pcards,dcards,deck,count);

% Stratgey if player has a soft hand
elseif pcards(1) == 1 || pcards(2) == 1
    [outcome,deck,count,pcards,dcards] = softhand(pcards,dcards,deck,count);

% Strategey if player has a hard hand
else
    [outcome,deck,count,pcards,dcards] = hardhand(pcards,dcards,deck,count);
end