%Simulates Schelling's Model of Segregation

%initialize the grid for the model simulation
%takes in integer grid_n, which describes how many tiles on each side of
%the grid
function Model(grid_n)

    %initialize person grid
    people_array = zeros(grid_n, grid_n);
    emptyspots = [];
    for r=1:grid_n
        for c=1:grid_n
            x = rand;
            if( x > 2/3)
                people_array(r,c) = 1;
            elseif(x > 1/3)
                people_array(r,c) = 2;
            else
                %no one lives here
                p = struct('r', r, 'c', c);
                emptyspots = [emptyspots p];
            end
        end
    end

    runModel(people_array, emptyspots, grid_n);
end

function runModel(array, vacancies, grid_n)
% array contains the people data at each location
% vacancies is a vector containing structs that hold information about
% empty spaces.
% grid_n is the width of the grid.

    
    close all                  % close all figure windows
    figure                     % new figure window
    axis equal off             % all axes:  same scale, no display
    hold on                    % hold all calls to plot on current axes
    
    
    iterations = 100;
    pausetime = .1;
    
    itr = 0;
    while(itr < iterations)

        title(sprintf('N=%d, Iteration=%d',grid_n,itr));

        %draw current grid
        drawGrid(array);
        
        newPeople = array;
        %move squares if they need to relocate.
        for r=1:grid_n
            for c=1:grid_n
                if willMove(array, r, c)
                    %find empty spot to move to
                    ind = findVacancy(vacancies);
                    newr = vacancies(ind).r;
                    newc = vacancies(ind).c;
                    
                    newPeople(newr,newc) = array(r,c); %move person over
                    %update the vacancy to spot previously occupied
                    vacancies(ind).r = r;
                    vacancies(ind).c = c;
                end
            end
        end
        
        array = newPeople;
        itr= itr+1;
        pause(pausetime);
    end
    
    hold off
    
end

function drawGrid(array)
    [nr nc] = size(array);
    tile_width = 5;
    for r = 1:nr
        for c=1:nc
            x = [(c-1)*tile_width (c-1)*tile_width c*tile_width c*tile_width];
            y = [(r-1)*tile_width r*tile_width r*tile_width (r-1)*tile_width];
            if(array(r,c) == 1)
                fill(x,y,'r');
            elseif(array(r,c) == 2)
                fill(x,y,'b');
            else %empty
                fill(x,y,'w');
            end
        end
    end
    shg
end

function yn = willMove(array, curr, curc)
    n = size(array,1);
    
    same_count = -1; %offset for counting yourself
    square_count = -1; %same as above
    for r = curr-1:curr+1
        for c = curc-1:curc+1
            %check for valid square:
            if r > 0 && c > 0 && r <= n && c <= n
                square_count = square_count+1;
                if array(r,c) == array(curr,curc)
                    same_count = same_count+1;
                end
            end
        end
    end
    
    yn = same_count/square_count < 1/2;
end

function ind = findVacancy(vacancies)
    ind = ceil(rand*length(vacancies));
end
