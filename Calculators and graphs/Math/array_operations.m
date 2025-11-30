% Module 2 Problem 2 solution
% Array Operations Library
% File Name: array_operations.m
% Description: This library includes functions to perform various operations on arrays
% such as finding elements greater than those in another array, and other common 
% array manipulations.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

%% Variables
% Define the arrays
x = [-3, 0, 0, 2, 6, 8];
y = [-5, -2, 0, 3, 4, 10];

%% Functions
% Find all the elements in x that are greater than those in y
[indices, elements] = find_greater_elements(x, y);
disp('The indices of elements in x that are greater than y are:');
disp(indices);
disp('The elements in x that are greater than y are:');
disp(elements);

% Function to find elements in array x that are greater than corresponding elements in array y
function [indices, elements] = find_greater_elements(x, y)
    indices = find(x > y);
    elements = x(indices);
end

% Function to display elements in x that are greater than corresponding elements in y
function display_greater_elements(x, y)
    for i = 1:length(x)
        if x(i) > y(i)
            disp(['Element ', num2str(i), ' of x (= ', num2str(x(i)), ...
                  ') > y (= ', num2str(y(i)), ')']);
        end
    end
end

% Element-wise Operations
% Function to add two arrays element-wise
function [result] = elementwise_addition(x, y)
    result = x + y;
end
% Function to subtract two arrays element-wise
function [result] = elementwise_subtraction(x, y)
    result = x - y;
end
% Function to multiply two arrays element-wise
function [result] = elementwise_multiplication(x, y)
    result = x .* y;
end
% Function to divide two arrays element-wise
function [result] = elementwise_division(x, y)
    result = x ./ y;
end

% Array Statistics
% Function to calculate the mean of an array
function [mean_value] = calculate_mean(array)
    mean_value = mean(array);
end
% Function to calculate the median of an array
function [median_value] = calculate_median(array)
    median_value = median(array);
end
% Function to calculate the mode of an array
function [mode_value] = calculate_mode(array)
    mode_value = mode(array);
end
% Function to calculate the standard deviation of an array
function [std_value] = calculate_std(array)
    std_value = std(array);
end
% Function to calculate the variance of an array
function [var_value] = calculate_variance(array)
    var_value = var(array);
end

% Array Manipulations
% Function to sort an array
function [sorted_array] = sort_array(array)
    sorted_array = sort(array);
end
% Function to reshape an array
function [reshaped_array] = reshape_array(array, new_dims)
    reshaped_array = reshape(array, new_dims);
end
% Function to concatenate two arrays
function [concatenated_array] = concatenate_arrays(x, y)
    concatenated_array = [x, y];
end
% Function to find unique elements in an array
function [unique_elements] = unique_array(array)
    unique_elements = unique(array);
end

% Logical Operations
% Function to perform logical AND on two arrays
function [result] = logical_and(x, y)
    result = x & y;
end
% Function to perform logical OR on two arrays
function [result] = logical_or(x, y)
    result = x | y;
end
% Function to perform logical NOT on an array
function [result] = logical_not(array)
    result = ~array;
end

% Set Operations
% Function to find the union of two arrays
function [result] = set_union(x, y)
    result = union(x, y);
end
% Function to find the intersection of two arrays
function [result] = set_intersection(x, y)
    result = intersect(x, y);
end
% Function to find the difference of two arrays
function [result] = set_difference(x, y)
    result = setdiff(x, y);
end


%% Display
% Display the indices and elements
disp('The indices of elements in x that are greater than y are:');
disp(indices);
disp('The elements in x that are greater than y are:');
disp(elements);

% Display each comparison using a loop
display_greater_elements(x, y);

% Element-wise operations
add_result = elementwise_addition(x, y);
sub_result = elementwise_subtraction(x, y);
mult_result = elementwise_multiplication(x, y);
div_result = elementwise_division(x, y);

disp('Element-wise addition:');
disp(add_result);
disp('Element-wise subtraction:');
disp(sub_result);
disp('Element-wise multiplication:');
disp(mult_result);
disp('Element-wise division:');
disp(div_result);

% Array statistics
mean_value = calculate_mean(x);
median_value = calculate_median(x);
mode_value = calculate_mode(x);
std_value = calculate_std(x);
var_value = calculate_variance(x);

disp('Mean value:');
disp(mean_value);
disp('Median value:');
disp(median_value);
disp('Mode value:');
disp(mode_value);
disp('Standard deviation:');
disp(std_value);
disp('Variance:');
disp(var_value);

% Array manipulations
sorted_x = sort_array(x);
reshaped_x = reshape_array(x, [2, 3]);
concatenated_arrays = concatenate_arrays(x, y);
unique_elements = unique_array([x, y]);

disp('Sorted array:');
disp(sorted_x);
disp('Reshaped array:');
disp(reshaped_x);
disp('Concatenated arrays:');
disp(concatenated_arrays);
disp('Unique elements:');
disp(unique_elements);

% Logical operations
and_result = logical_and(x > 0, y > 0);
or_result = logical_or(x > 0, y > 0);
not_result = logical_not(x > 0);

disp('Logical AND result:');
disp(and_result);
disp('Logical OR result:');
disp(or_result);
disp('Logical NOT result:');
disp(not_result);

% Set operations
union_result = set_union(x, y);
intersection_result = set_intersection(x, y);
difference_result = set_difference(x, y);

disp('Set union result:');
disp(union_result);
disp('Set intersection result:');
disp(intersection_result);
disp('Set difference result:');
disp(difference_result);