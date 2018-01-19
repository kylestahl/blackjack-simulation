function [cards,count,deck] = dealto(cards,count,deck)

i = 3;                              % set index to be third card
while sum(cards) < 17               % break if total is over 17
    if any(cards==1)                % Check if there is an ace
        if (sum(cards)+10 > 17) && (sum(cards)+10 < 22) 	
            cards(find(cards==1,1)) = 11; % First ace = 11
            break                   % If there is an ace, does setting the ace to equal 
        end                         % eleven give a total between 18 and 21. If so set 
    end                             % ace to equal 11 and stop dealing
    [cards(i),count,deck] = deal(deck,count);
    i =  i + 1;                     % Else deal next card and repeat
end
