% Module 2 Problem 7 solution
% Financial Calculations Library
% File Name: financial_calculations.m
% Description: This library includes functions for various financial calculations,
% such as calculating interest, handling monthly deposits, purchasing CDs,
% and computing total savings.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Initialize values
annrate = 0.04; % Annual interest rate
years = 5; % Total years of depositing
deposit = [300 * ones(1, 12), 350 * ones(1, 12), 350 * ones(1, 12), ...
           350 * ones(1, 12), 400 * ones(1, 12)]; % Monthly deposits

% Calculate total amount in savings and CDs
[total_amount, CDs] = monthly_deposits_with_cds(deposit, annrate, years);

% Calculate the total amount in savings and CDs
[total_savings, num_CDs, amount_in_CDs, final_total_amount] = calculate_total_savings(total_amount, CDs);

disp('The amount in savings is:')
disp(total_savings)
disp('The number of CDs is:')
disp(num_CDs)
disp('The amount in CDs is:')
disp(amount_in_CDs)
disp('The total amount you have is:')
disp(final_total_amount)

% Future value of an annuity
payment = 200; % Monthly payment
rate = 0.05 / 12; % Monthly interest rate
periods = 12 * 10; % 10 years
FV = future_value_annuity(payment, rate, periods);
disp('The future value of the annuity is:')
disp(FV)

% Present value of an annuity
PV = present_value_annuity(payment, rate, periods);
disp('The present value of the annuity is:')
disp(PV)

% Monthly loan payment
principal = 20000; % Loan principal
rate = 0.05 / 12; % Monthly interest rate
periods = 12 * 5; % 5 years
monthly_payment = loan_payment(principal, rate, periods);
disp('The monthly loan payment is:')
disp(monthly_payment)

% Investment growth
initial_investment = 1000; % Initial investment
rate = 0.07; % Annual interest rate
periods = 10; % 10 years
investment_value = investment_growth(initial_investment, rate, periods);
disp('The value of the investment after 10 years is:')
disp(investment_value)

%% Functions
% Function to calculate the monthly interest rate from the annual rate
function [monthly_rate] = calculate_monthly_rate(annual_rate)
    monthly_rate = annual_rate / 12;
end

% Function to calculate the compound interest for a given number of periods
function [future_value] = compound_interest(principal, rate, periods)
    future_value = principal * (1 + rate) ^ periods;
end

% Function to handle monthly deposits and interest accumulation
function [total_amount, CDs] = monthly_deposits_with_cds(deposit, annrate, years)
    % Initializing variables
    amount = deposit(1);
    rate = calculate_monthly_rate(annrate);
    m = 0; % Month counter
    n = 0; % CD counter
    CDs = []; % Initialize CDs array
    total_amount = zeros(1, 12 * years + 1); % Initialize total amount array
    total_amount(1) = amount;

    % Loop through the specified number of years
    for k = 1:12 * years
        % Check if reached end of year
        if m == 12
            % Reset month counter
            m = 1;
            % Compound value of all CDs
            CDs = 1.06 * CDs;
            % Check if have more than $3000 in account
            if total_amount(k) >= 3000
                % Withdraw $2000 to purchase CD
                total_amount(k) = total_amount(k) - 2000;
                % Purchase value of CD
                CDs(n + 1) = 2000;
                % Increment counter showing number of CDs purchased
                n = n + 1;
            end
        end
        % New monthly balance based on interest and additional deposit
        total_amount(k + 1) = total_amount(k) * (1 + rate) + deposit(k);
        % Increment month counter
        m = m + 1;
    end
end

% Function to calculate the total amount in savings and CDs
function [total_savings, num_CDs, amount_in_CDs, total_amount] = calculate_total_savings(total_amount, CDs)
    total_savings = total_amount(end);
    num_CDs = length(CDs);
    amount_in_CDs = sum(CDs);
    total_amount = total_savings + amount_in_CDs;
end

% Calculate total amount in savings and CDs
[total_amount, CDs] = monthly_deposits_with_cds(deposit, annrate, years);

% Calculate the total amount in savings and CDs
[total_savings, num_CDs, amount_in_CDs, final_total_amount] = calculate_total_savings(total_amount, CDs);

% Function to calculate the future value of an annuity
function [FV] = future_value_annuity(payment, rate, periods)
    FV = payment * ((1 + rate) ^ periods - 1) / rate;
end

% Function to calculate the present value of an annuity
function [PV] = present_value_annuity(payment, rate, periods)
    PV = payment * (1 - (1 + rate) ^ -periods) / rate;
end

% Function to calculate the monthly loan payment
function [payment] = loan_payment(principal, rate, periods)
    payment = principal * rate / (1 - (1 + rate) ^ -periods);
end

% Function to calculate investment growth over time
function [investment_value] = investment_growth(initial_investment, rate, periods)
    investment_value = initial_investment * (1 + rate) ^ periods;
end

