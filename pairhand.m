function [outcome,deck,count,pcards,dcards] = pairhand(pcards,dcards,deck,count)
while 1
% Check if Dealer has 21
if (dcards(1) == 1 && dcards(2) == 10) || ...
   (dcards(1) == 10 && dcards(2) == 1)
    dcards(find(dcards==1,1)) = 11;     % Set ace = 11
    outcome = -1;                       % Set outcome to be a loss
    break
end

strat = pair(pcards(1),dcards(1));      % Determine Strategy

if strat == 0 % Keep Hand
    [outcome,deck,count,pcards,dcards] = hardhand(pcards,dcards,deck,count);
    break

else % strat == 1 Split hand
    p2cards = zeros(1,10);    % Create new hand
    p2cards(1) = pcards(2);   % Move cards from hand 1 to hand 2
    [pcards(2),count,deck] = deal(deck,count);    % Deal new card to hand 1
    [p2cards(2),count,deck] = deal(deck,count);   % Deal new card to hand 2
    
    
    if pcards(1) == 1 && p2cards(1) == 1 % Split aces no more cards
        outcome1 = 0;
        outcome2 = 0;
        % Check if Hand 1 has Blackjack
        if (pcards(1) == 1 && pcards(2) == 10) || ...
            (pcards(1) == 10 && pcards(2) == 1)
            pcards(find(pcards==1,1)) = 11;
            outcome1 = 1.5;
        end
        % Check if Hand 2 has Blackjack
        if (p2cards(1) == 1 && p2cards(2) == 10) || ...
            (p2cards(1) == 10 && p2cards(2) == 1)
            outcome2 = 1.5;
            p2cards(find(p2cards==1,1)) = 11;
        end
        % Set Aces = 11
        pcards(1) = 11;
        p2cards(1) = 11;
        % Deal to Dealer, Check if dealer busted
        if outcome1 == 0 || outcome2 == 0
            [dcards,count,deck] = dealto(dcards,count,deck);
            if sum(dcards) > 21 && outcome1 == 0
                outcome1 = 1;
            end
            if sum(dcards) > 21 && outcome2 == 0
                outcome2 = 1;
            end
        end
    % Compare Hands
    % Hand 1
    if outcome1 == 0
        if sum(pcards) > sum(dcards)
            outcome1 = 1; % Win
        elseif sum(pcards) < sum(dcards)
            outcome1 = -1; % Loss
        else
            outcome1 = 0; % Push
        end
    end
    % Hand 2
    if outcome2 == 0
        if sum(p2cards) > sum(dcards)
            outcome2 = 1; % Win
        elseif sum(p2cards) < sum(dcards)
            outcome2 = -1; % Loss
        else
            outcome2 = 0; % Push
        end
    end

        
    else
    [outcome1,outcome2,pcards,p2cards,dcards,deck,count] = ...
    playpair(pcards,p2cards,dcards,deck,count);
    end
end

    
    outcome = outcome1 + outcome2;

    break
end
end
        