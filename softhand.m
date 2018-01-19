function [outcome,deck,count,pcards,dcards] = softhand(pcards,dcards,deck,count)
dd = 1; % Will change to 2 if player decides to double down
while 1
    % Check if Dealer has 21
    if (dcards(1) == 1 && dcards(2) == 10) || ...
        (dcards(1) == 10 && dcards(2) == 1)
        dcards(find(dcards==1,1)) = 11;       % Set ace to = 11
        if sum(pcards) == 11;                 % Check for player Blackjack
            pcards(find(pcards==1,1)) = 11;   % Set ace to = 11
            outcome = 0;                      % Blackjack push
            break
        end                 % If Player doesn't also have blackjack
        outcome = -1;       % Push
        break
    end
    
    % Check if Player has 21
    % We know one card is an ace so if the total of the cards equals 11
    % then the other cards is a ten: Blackjack
    if sum(pcards) == 11
        outcome = 1.5;                  % Player has blackjack 3:2 payout
        pcards(find(pcards==1,1)) = 11; % Set ace to = 11
        break
    end    

strat = soft(sum(pcards)-1,dcards(1)); % Determine strategy

    % Stand
    if strat == 0       % Stand set ace to equal 11
        pcards(find(pcards==1,1)) = 11;
        
    % Double Down   
    elseif strat == 2
        dd = 2;         % double outcome if player doubled down
        [pcards(3),count,deck] = deal(deck,count);
        if sum(pcards) < 12
            pcards(find(pcards==1,1)) = 11;
        end
        
    else % strat == 1 Hit
        [pcards,count,deck] = dealto(pcards,count,deck);

    end
    
    % Check if Player Busted
    if sum(pcards) > 21
        outcome = -1*dd;
        break
    end

% Player now has all cards based on basic strategy
% Deal to Dealer
    [dcards,count,deck] = dealto(dcards,count,deck);
        
        % Check if Dealer Busted
        if sum(dcards) > 21
            outcome = 1*dd;
            break
        end
        
% Player has been delt too and Dealer has been delt too
% Compare Hands

        if sum(pcards) > sum(dcards)
            outcome = 1*dd; % Win
            break
        elseif sum(pcards) < sum(dcards)
            outcome = -1*dd; % Loss
            break
        else
            outcome = 0; % Push
            break
        end
end
