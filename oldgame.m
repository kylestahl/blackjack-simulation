%% Assumptions
% Cannot Surrender hands
% Can double down
% Can only split once
% Dealer hits on soft 17 (so does player per dealto.m)
% Insurance never used
% Blackjack pays 1.5x
n = 1000;
countthreshold = 19;
maxbet = 50;
wins = zeros(n,1);

handsatcount = zeros(40,1);
winsatcount = zeros(40,1);

for i = 1:n   
%% Initialize 
deck = zeros(1,10);
decks = 6;
deck = deck+(4*decks);
deck(10) = deck(10)*4; %cards valued at 10: 10,J,Q,K.

money = 1000;
count = 0;

pcards = zeros(1,10);
dcards = zeros(1,10);

hand = 0;
shuffles = 0;

while money > 500 && money < 1500
    %% Reshuffle at 20 cards left
    if sum(deck) < 20          
        deck = zeros(1,10);
        deck = deck+(4*decks);
        deck(10) = deck(10)*4;
        count = 0;
        shuffles = shuffles + 1;
    end
    
    countbeforehand = count;
    if countbeforehand > 0 
        handsatcount(countbeforehand) = handsatcount(countbeforehand) + 1;
    end
    
    %% Place Bet
     if count >= countthreshold;
         bet = min(money,maxbet);
     else 
           bet = min(money,5);
     end
    
    %% Deal First Cards
    pcards = zeros(1,10);
    dcards = zeros(1,10);

    [pcards(1),count,deck] = deal(deck,count);
 
    [dcards(1),count,deck] = deal(deck,count);  %Dealer up card
     
    [pcards(2),count,deck] = deal(deck,count);
     
    [dcards(2),count,deck] = deal(deck,count);
     

    %% Play Basic Strategy
    [outcome,deck,count,pcards,dcards] = blackjack(pcards,dcards,deck,count);
    
    money = money + outcome*bet;
    hand = hand + 1;
    
    
    %% Take Data
    if outcome > 0 && countbeforehand > 0
        winsatcount(countbeforehand) = winsatcount(countbeforehand) + 1;
    end

end % Game break

    if money > 1000
        wins(i) = 1;
    end

end % for loop 100 trials
    disp(['Threshold: ', num2str(countthreshold)]);
    disp(['Average wins: ', num2str(mean(wins))]);
    disp(['Estimated Standard Deviation: ', num2str(sqrt(var(wins)))]);
    
    percentwinsatcount = winsatcount./handsatcount;
    disp(percentwinsatcount);
    percentwinsatcount = transpose(percentwinsatcount);