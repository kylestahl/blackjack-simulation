function [card, count, deck] = deal(deck,count)
%% List search to choose a card at random
r = rand(1,1);              % Generate U(0,1)
i = 1;                      % Initialize index	
p = deck/sum(deck); 		% Turn deck-array into probabilities that sum to 1.
while r > p(i)              % Discrete inversion algorithm
    i=i+1;                  % Move on to check the next card
    p(i) = p(i) + p(i-1);	% Summing over probabilities
end
card = i;                   % Set card value

%% Count card leaving deck		
deck(card) = deck(card) - 1;	% Take card out of the deck
if card <= 6 && card >= 2		% Check if the card has a positive count value
    count = count + 1;          % Increase the count by one
elseif card == 10 || card == 1	% Check if the cards has a negative count value
    count = count - 1;          % Decrease the count by one
else % Nothing                  % Count stays the same
end
