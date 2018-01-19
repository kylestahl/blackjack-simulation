function [outcome,deck,count,pcards,dcards] = hardhand(pcards,dcards,deck,count)
dd = 1; % Will change to 2 if player decides to double down
while 1
    
    % Check if Dealer has 21
    if (dcards(1) == 1 && dcards(2) == 10) || ...
        (dcards(1) == 10 && dcards(2) == 1)
        dcards(find(dcards==1,1)) = 11;     % Set ace to = 11
        outcome = -1;                       % Outcome is a loss
        break
    end
    
strat = hard(sum(pcards),dcards(1));        % Determine Strategy

    % Double Down
    if strat == 2
        dd = 2;                             % Double outcome 
        [pcards(3),count,deck] = deal(deck,count);
        if sum(pcards) < 12                 % If there is an ace that should be 11
            pcards(find(pcards==1,1)) = 11; % Set the ace to = 11
        end
    
    % Hit
    elseif strat == 1
        [pcards,count,deck] = dealto(pcards,count,deck);
        
    else % strat == 0
        % Stand do nothing
    end
    
    % Check if Player Busted
    if sum(pcards) > 21             % Check if Player cards is over 21
        outcome = -1*dd;            % Set outcome to be a loss
        break
    end
    
% Player now has all cards based on basic strategy
% Deal to Dealer
    [dcards,count,deck] = dealto(dcards,count,deck);

        
        % Check if Dealer Busted
        if sum(dcards) > 21                 % Check if dealer has over 21
            outcome = 1*dd;                 % Set outcome to be a win
            break
        end
        
% Player has been delt too and Dealer has been delt too
% Compare Hands

        if sum(pcards) > sum(dcards)        % If player has better and
            outcome = 1*dd;                 % Win
            break
        elseif sum(pcards) < sum(dcards)    % If player has worse hand
            outcome = -1*dd;                % Loss
            break
        else                                % Else hands are equal
            outcome = 0;                    % Push
            break
        end
end
