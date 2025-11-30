% Function to determine if a given year is a leap year

function leap_yr = is_leap_year(year)
    % Input: year - The year to be checked
    % Output: leap_yr - 1 if the year is a leap year, 0 otherwise

    if mod(year, 4) == 0
        if mod(year, 100) == 0
            if mod(year, 400) == 0
                leap_yr = 1; % Leap year
            else
                leap_yr = 0; % Not a leap year
            end
        else
            leap_yr = 1; % Leap year
        end
    else
        leap_yr = 0; % Not a leap year
    end
end

% Test the is_leap_year function for below years
years = [2000, 1900, 2004, 2001, 2100, 2400];

% Test each year and display the result
for i = 1:length(years)
    year = years(i);
    leap_yr = is_leap_year(year);
    fprintf('Year: %d, Leap Year: %d\n', year, extra_day);
end
