clc
clear

%game of battleship where the user will input their desired values for the
%game board and the size of the ship they need to find and sink. From this
%the program will randomly position the ship in the grid the user chose.
%From here the user will make guesses of the row and column the ship is in
%to try and sink the ship. If the user is able to guess all the positions
%the ship lies in within a number of turns. If the user does not achieve
%this whithin the provided moves, they lose the game.

fprintf("Welcome to the game of battleship!\nBefore we begin this game, you must enter your name.\n")
name = input("Please enter your name: ", 's');
cont = questdlg('Would you like to play Battleship', ...
    'Player Menu', ...
    'Yes','No thank you','Yes');
%Conditioning whether the user wants to play or not
if (strcmp(cont,"Yes"))
    
    %displaying the rules
    fprintf("Welcome %s to a simplified version of Battleship, where you can vary the difficulty of attempting\nto find and sink a ship in a grid of your choice.\n",name)
    fprintf("The rules of this game are that you are required to guess the positions of a ship in a grid and you\nwill have a limited number of guesses depending on how big or small the ship is.\n")
    %initializing vector A
    %initializing the number of rows, columns and the ships length from user
    %input to vary the difficulty
    N = input("To begin, please enter the number of rows you would like for the grid: ");
    
    %ensuring appropriate value for input
    while N <= 0
        fprintf("This number of rows is invalid.\n")
        N = input("Please enter a non negative or non zero value for the number of rows in your grid: ");
    end
    
    %ensuring appropriate value for input
    M = input("Please enter the number of columns you would like for the grid: ");
    while M <= 0
        fprintf("This number of columns is invalid.\n")
        M = input("Please enter a non negative or non zero value for the number of columns in your grid: ");
    end
    B = input("Enter the length of your ship: ");
    A = zeros(N,M);
    
    %initialize images to display once game is complete (win or lose)
    imageLoss = imread('Image_Loss.jpg');
    imageWin = imread('Image_Win.jpg');
    
    
    %The value of B will be fomulated through the user input for the length of
    %the ship they desire.
    %While loop from ensuring no unrealistic values of B can occur and no
    %error occurs
    while (B > N && B > M || B <= 0);
        B = input("The length of your ship does not fit in the grid or is not valid.\nPlease enter the length of your ship: ");
    end
    
    
    %Initializing the variable C to create a vector of 1s of length of user
    %input for ship length
    C = [(ones(1,B))];
    randVariable = 0;
    %when the random number is 1 the loop will place the vector in a random row
    %initializing variable
    if B < N && B < M
        randVariable = randi([1 2]);
    end
    
    if B > N && B < M
        randVariable = 1;
    elseif B < M && B > N
        randVariable = 2;
    end
    randRow = randi([1 N]);
    randCol = randi([1 M]);
    
    %Randomly places the vector C in a random row in A
    if randVariable == 1
        for j = 1:length(C)
            A(randRow,j) = C(j);
        end
        
        
        %Randomly places the vector C in a random column in A
    elseif randVariable == 2
        for i = 1:length(C)
            A(i,randCol) = C(i);
        end
    end
    
    %asks the user if the would like to continue the game (would preferably
    %like to make this a function to be called. adds complexity and also
    %easier and reduces length of code.
    
    Y = input("We are about to continue the game, would you like to continue? (Press 1 to continue, press 2 to stop) ");
    if Y == 1
        fprintf("You have chosen to continue. \n");
        %ends code if the user does not want to continue
    elseif Y ~= 1
        return
    end
    
    %Initalize variable count (used for when the user misses the ship)
    count = (B+10);
    
    clc
    
    
    %establishing count
    for i = 1:(count*2)
        guessRow = input("Guess a row: ");
        %ensures that the user does not input an incorrect row
        while(guessRow > N || guessRow <= 0)
            fprintf("You have entered an invalid row\n");
            guessRow = input("Guess a row: ");
        end
        guessCol = input("Guess a column: ");
        %ensures that the user does not input an incorrect column
        while (guessCol > M || guessCol <=0)
            fprintf("You have entered an invalid column\n")
            guessCol = input("Guess a column: ");
        end
        %condition to change value of 1 in 2D array to 0
        %does this to remove double guessing of same point
        %need condition for when double guesses of the same point occur
        if A(guessRow,guessCol) == 1
            A(guessRow,guessCol) = 0;
            B = (B - 1);
            fprintf("Hit! You have %d positions remaining. \n", B);
            if B == 0
                fprintf("Ship sunk!\nCongratulations! You have won the game!")
                %game ends and image displayed
                imshow(imageWin);
                
                return
            end
            %
            %             Y = input ("Press 1 to continue guessing, press 2 to stop. ");
            %             if Y ~= 1
            %                 return
            %             end
            
            askContinue(Y)
            
            
            %condition for a miss the same, not so much of an issue if they
            %guess the same point and it misses as user just wastes guesses
            %however real game wouldnt happen so could impliment
            
        elseif A(guessRow,guessCol) == 0
            count = count-1;
            fprintf("Miss! You have %d chances remaining.\n", count);
            Y = input ("Press 1 to continue guessing, press 2 to stop. ");
            if Y ~= 1
                return
            end
            
            %conditionalising count to equal 0 meaning run out of turns
            if count == 0
                fprintf("Ship not sunk!\nYou have lost!");
                %game over for loss
                %image displayed
                imshow(imageLoss);
                return
            end
        end
    end
    
    %conditoning if user doesnt want to play the game
elseif (strcmp(cont,"No thank you"))
    fprintf("Hopefully you will come and play the game soon!")
    return
end

%end of the game