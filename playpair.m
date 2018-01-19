function [outcome1,outcome2,pcards,p2cards,dcards,deck,count] = ...
    playpair(pcards,p2cards,dcards,deck,count)
% default outcomes until compare with dealer
outcome1 = 0;
outcome2 = 0;
%% Play Hand 1
while 1
dd1 = 1; % Variable if player doubles down on hand 1
% Check if Hand 1 has Blackjack
    if (pcards(1) == 1 && pcards(2) == 10) || ...
        (pcards(1) == 10 && pcards(2) == 1)
        pcards(find(pcards==1,1)) = 11;
        outcome1 = 1.5;
        break
    end
    
% Strategy if Hand 1 is soft AND NOT A BLACKJACK
if (pcards(1) == 1 || pcards(2) == 1) 
    strat1 = soft(pcards(2),dcards(1));

    % Stand
    if strat1 == 0
        pcards(find(pcards==1,1)) = 11;
        
    % Double Down   
    elseif strat1 == 2
        dd1 = 2;
        [pcards(3),count,deck] = deal(deck,count);
        if sum(pcards) < 12
            pcards(find(pcards==1,1)) = 11;
        end
        
    else % strat1 == 1 Hit
        [pcards,count,deck] = dealto(pcards,count,deck);
    end  
    
    % Check if Player Busted
    if sum(pcards) > 21
        outcome1 = -1*dd1;
        break
    end
 else
% Strategy if Hand 1 is hard
    strat1 = hard(sum(pcards),dcards(1));

    % Double Down
    if strat1 == 2
        dd1 = 2;
        [pcards(3),count,deck] = deal(deck,count);
    
    % Hit
    elseif strat1 == 1
        [pcards,count,deck] = dealto(pcards,count,deck);
        
    else % strat1 == 0
        % Stand do nothing
    end
    
    % Check if Player Busted
    if sum(pcards) > 21
        outcome1 = -1*dd1;
        break
    end
end
break
end

%% Play Hand 2
while 1
dd2 = 1; % Variable if player doubles down on hand 2
% Check if Hand 2 has Blackjack
    if (p2cards(1) == 1 && p2cards(2) == 10) || ...
        (p2cards(1) == 10 && p2cards(2) == 1)
        outcome2 = 1.5;
        p2cards(find(p2cards==1,1)) = 11;
        break
    end
    
% Strategy if Hand 2 is soft AND NOT A BLACKJACK   
if (p2cards(1) == 1 || p2cards(2) == 1) 
    strat2 = soft(p2cards(2),dcards(1));

    % Stand
    if strat2 == 0
        p2cards(find(p2cards==1,1)) = 11;
        
    % Double Down   
    elseif strat2 == 2
        dd2 = 2;
        [p2cards(3),count,deck] = deal(deck,count);
        if sum(p2cards) < 12
            p2cards(find(p2cards==1,1)) = 11;
        end
        
    else % strat2 == 1 Hit
        [p2cards,count,deck] = dealto(p2cards,count,deck);
    end
    % Check if Hand 2 Busted
    if sum(p2cards) > 21
        outcome2 = -1*dd2;
        break
    end
    
else
% Strategy if Hand 2 is hard
    strat2 = hard(sum(p2cards),dcards(1));

    % Double Down
    if strat2 == 2
        dd2 = 2;
        [p2cards(3),count,deck] = deal(deck,count);
    
    % Hit
    elseif strat2 == 1
        [p2cards,count,deck] = dealto(p2cards,count,deck);
        
    else % strat2 == 0
        % Stand do nothing
    end
    
    % Check if Hand 2 Busted
    if sum(p2cards) > 21
        outcome2 = -1*dd2;
        break
    end
end

break
end
%% Deal to Dealer
% Except when outcome 1 and 2 have been decided by busting or Blackjack
if outcome1 == 0 || outcome2 == 0
    [dcards,count,deck] = dealto(dcards,count,deck);
    if sum(dcards) > 21 && outcome1 == 0
        outcome1 = 1*dd1;
    end
    if sum(dcards) > 21 && outcome2 == 0
        outcome2 = 1*dd2;
    end
end

%% Compare 

    % Hand 1
    if outcome1 == 0
        if sum(pcards) > sum(dcards)
            outcome1 = 1*dd1; % Win
        elseif sum(pcards) < sum(dcards)
            outcome1 = -1*dd1; % Loss
        else
            outcome1 = 0; % Push
        end
    end
    % Hand 2
    if outcome2 == 0
        if sum(p2cards) > sum(dcards)
            outcome2 = 1*dd2; % Win
        elseif sum(p2cards) < sum(dcards)
            outcome2 = -1*dd2; % Loss
        else
            outcome2 = 0; % Push
        end
    end
%% Displays for Validation    
disp('Players Split Hand');
disp(p2cards);
