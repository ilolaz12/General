% Corporate Financial Calculations Library
% File Name: corporate_financial_calculations.m
% Description: This library includes functions for various corporate financial calculations,
% such as net present value (NPV), internal rate of return (IRR), return on investment (ROI),
% payback period, and other key financial metrics.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Example cash flows for an investment project
cash_flows = [-1000, 200, 300, 400, 500, 600]; % Initial investment and annual cash flows
discount_rate = 0.1; % Discount rate for NPV calculation

% Calculate Net Present Value (NPV)
NPV = calculate_NPV(cash_flows, discount_rate);
disp(['Net Present Value (NPV): ', num2str(NPV)])

% Calculate Internal Rate of Return (IRR)
IRR = calculate_IRR(cash_flows);
disp(['Internal Rate of Return (IRR): ', num2str(IRR)])

% Calculate Return on Investment (ROI)
gain_from_investment = sum(cash_flows(2:end)); % Total gain from investment
cost_of_investment = -cash_flows(1); % Cost of investment
ROI = calculate_ROI(gain_from_investment, cost_of_investment);
disp(['Return on Investment (ROI): ', num2str(ROI)])

% Calculate Payback Period
payback_period = calculate_payback_period(cash_flows);
disp(['Payback Period: ', num2str(payback_period), ' years'])

% Calculate Profitability Index (PI)
PI = calculate_profitability_index(cash_flows, discount_rate);
disp(['Profitability Index (PI): ', num2str(PI)])

% Calculate Discounted Payback Period
discounted_payback_period = calculate_discounted_payback_period(cash_flows, discount_rate);
disp(['Discounted Payback Period: ', num2str(discounted_payback_period), ' years'])

% Example financial data for EBIT and EBITDA calculations
revenue = 5000; % Annual revenue
COGS = 2000; % Cost of goods sold
operating_expenses = 1000; % Operating expenses
depreciation = 500; % Depreciation expense

% Calculate Earnings Before Interest and Taxes (EBIT)
EBIT = calculate_EBIT(revenue, COGS, operating_expenses, depreciation);
disp(['Earnings Before Interest and Taxes (EBIT): ', num2str(EBIT)])

% Calculate Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA)
EBITDA = calculate_EBITDA(revenue, COGS, operating_expenses);
disp(['Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA): ', num2str(EBITDA)])

% Example data for Debt-to-Equity Ratio calculation
total_debt = 2000; % Total debt
total_equity = 5000; % Total equity

% Calculate Debt-to-Equity Ratio
debt_to_equity = calculate_debt_to_equity(total_debt, total_equity);
disp(['Debt-to-Equity Ratio: ', num2str(debt_to_equity)])

% Function to calculate the Net Present Value (NPV)
function [NPV] = calculate_NPV(cash_flows, discount_rate)
    periods = length(cash_flows);
    NPV = sum(cash_flows ./ (1 + discount_rate) .^ (0:periods-1));
end

% Function to calculate the Internal Rate of Return (IRR)
function [IRR] = calculate_IRR(cash_flows)
    IRR = fzero(@(r) sum(cash_flows ./ (1 + r) .^ (0:length(cash_flows)-1)), 0.1);
end

% Function to calculate the Return on Investment (ROI)
function [ROI] = calculate_ROI(gain_from_investment, cost_of_investment)
    ROI = (gain_from_investment - cost_of_investment) / cost_of_investment;
end

% Function to calculate the Payback Period
function [payback_period] = calculate_payback_period(cash_flows)
    cumulative_cash_flows = cumsum(cash_flows);
    payback_period = find(cumulative_cash_flows >= 0, 1);
    if isempty(payback_period)
        payback_period = NaN; % Investment never paid back
    end
end

% Function to calculate the profitability index (PI)
function [PI] = calculate_profitability_index(cash_flows, discount_rate)
    NPV = calculate_NPV(cash_flows, discount_rate);
    initial_investment = -cash_flows(1);
    PI = (NPV + initial_investment) / initial_investment;
end

% Function to calculate the discounted payback period
function [discounted_payback_period] = calculate_discounted_payback_period(cash_flows, discount_rate)
    discounted_cash_flows = cash_flows ./ (1 + discount_rate) .^ (0:length(cash_flows)-1);
    cumulative_discounted_cash_flows = cumsum(discounted_cash_flows);
    discounted_payback_period = find(cumulative_discounted_cash_flows >= 0, 1);
    if isempty(discounted_payback_period)
        discounted_payback_period = NaN; % Investment never paid back
    end
end

% Function to calculate the Earnings Before Interest and Taxes (EBIT)
function [EBIT] = calculate_EBIT(revenue, COGS, operating_expenses, depreciation)
    EBIT = revenue - COGS - operating_expenses - depreciation;
end

% Function to calculate the Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA)
function [EBITDA] = calculate_EBITDA(revenue, COGS, operating_expenses)
    EBITDA = revenue - COGS - operating_expenses;
end

% Function to calculate the Debt-to-Equity Ratio
function [debt_to_equity] = calculate_debt_to_equity(total_debt, total_equity)
    debt_to_equity = total_debt / total_equity;
end
