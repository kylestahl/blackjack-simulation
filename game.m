%% Assumptions
% Cannot Surrender hands
% Can double down
% Can only split once
% Dealer hits on soft 17 (so does player per dealto.m)
% Insurance never used
% Blackjack pays 1.5x

n = 1000;            % number of games generated
countthreshold = 5;  % count at which the player bets more than the minimum
maxbet = 25;         % value of player?s bet when count > count threshold

%% Initialize 
deck = zeros(1,10);     % vector of indices for cards remaining of each value 
decks = 1;	            % 6 total decks in the ?shoe?.  Common for casinos (1 for validation)
deck = deck+(4*decks);  % 4 of each card value for every deck
deck(10) = deck(10)*4;  % cards valued at 10: 10,J,Q,K.

money = 1000;	       % start with $1000
count = 0;	           % count starts at 0. Assumes you join a table after a shuffle

pcards = zeros(1,10);   % vector of the player?s cards
dcards = zeros(1,10);   % vector of the dealer?s cards

hand = 0;               % # of hands 
shuffles = 0;           % # of shuffles

while money > 900 && money < 1100	% Leave table after plus or minus $100 for Validation display
    %% Reshuffle at 20 cards left
    if sum(deck) < 20          		% Reshuffle when only 20 cards are left
        deck = zeros(1,10);         % Re-initialize deck 
        deck = deck+(4*decks);		% 4 of each card in every deck
        deck(10) = deck(10)*4;		% 4 different cards = 10: 10,J,Q,K.
        count = 0;                  % Reset count with new deck
        shuffles = shuffles + 1;	% Kept track of shuffles
    end
    
     %% Place Bet
     if count >= countthreshold;	% Check to see if count exceeds threshold
         bet = min(money,maxbet);	% If the count exceeds threshold bet high
     else 
           bet = min(money,5);		% Else bet the minimum bet
     end
    
    %% Deal First Cards
    pcards = zeros(1,10);			% Start over new player hand
    dcards = zeros(1,10);			% Start over new dealer hand

    [pcards(1),count,deck] = deal(deck,count);  % Player first card
 
    [dcards(1),count,deck] = deal(deck,count);  % Dealer up card
     
    [pcards(2),count,deck] = deal(deck,count);  % Player second card
     
    [dcards(2),count,deck] = deal(deck,count);  % Dealer down card
     

    %% Play Basic Strategy
    [outcome,deck,count,pcards,dcards] = blackjack(pcards,dcards,deck,count);
    
    money = money + outcome*bet; % Change money based on outcome and bet
    hand = hand + 1;			 % keep track of number of hands played
    
    %% Displays For Validation
    disp('Players hand');
    disp(pcards);
    disp('Dealers hand');
    disp(dcards);
    disp('Cards left in deck at each index');
    disp(deck);
    disp(['Hand Number: ', num2str(hand)]);
    disp(['Outcome = ',num2str(outcome)]);
    disp(['Bet (based on previous count) = ', num2str(bet)]);
    disp(['Money after hand = ',num2str(money)]);
    disp(['Count = ', num2str(count)]);
    disp(['Number of reshuffles: ', num2str(shuffles)]);
    disp(' ');
end 

