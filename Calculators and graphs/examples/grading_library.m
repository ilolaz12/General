% Grading System Library
% File Name: grading_system.m
% Description: This library includes functions for converting numerical grades to letter grades,
% reading and writing student data to files, comparing student numbers with another file, and
% differentiating between school and university systems.
% Author: Ilona Lazareva (U1551168)
% Date: 3 July 2024
% Version: 1.0

%% Functions

% Function to determine letter grade using nested if statements
function [grade] = grade_nested_if(x)
    if x >= 90
        grade = 'A';
    else
        if x >= 80
            grade = 'B';
        else
            if x >= 70
                grade = 'C';
            else
                if x >= 60
                    grade = 'D';
                else
                    grade = 'F';
                end
            end
        end
    end
end

% Function to determine letter grade using elseif clauses
function [grade] = grade_elseif(x)
    if x >= 90
        grade = 'A';
    elseif x >= 80
        grade = 'B';
    elseif x >= 70
        grade = 'C';
    elseif x >= 60
        grade = 'D';
    else
        grade = 'F';
    end
end

% Function to read student data from a file
function [student_data] = read_student_data(filename)
    student_data = readtable(filename, 'Delimiter', ',', 'Format', '%d %s %f');
end

% Function to write student data to a file
function write_student_data(filename, student_data)
    writetable(student_data, filename);
end

% Function to compare student numbers with another file
function [matched_students] = compare_student_numbers(student_data, other_filename)
    other_data = readtable(other_filename, 'Delimiter', ',', 'Format', '%d');
    matched_students = ismember(student_data.StudentNumber, other_data.StudentNumber);
end

% Function to add system indicator to student data
function [student_data] = add_system_indicator(student_data, threshold)
    student_data.System = repmat("School", height(student_data), 1);
    student_data.System(student_data.Age >= threshold) = "University";
end

%% Example Usage

% Example file names
input_filename = 'student_data.csv'; % Input file with student data
output_filename = 'graded_student_data.csv'; % Output file for graded student data
other_filename = 'other_student_numbers.csv'; % File with other student numbers for comparison

% Read student data
student_data = read_student_data(input_filename);

% Add letter grades using nested if statements
student_data.Grade = arrayfun(@grade_nested_if, student_data.Grade);

% Add system indicator
age_threshold = 18; % Age threshold to differentiate between school and university
student_data = add_system_indicator(student_data, age_threshold);

% Compare student numbers with another file
matched_students = compare_student_numbers(student_data, other_filename);
student_data.Matched = matched_students;

% Write graded student data to file
write_student_data(output_filename, student_data);

%% Display

% Display the first few rows of the graded student data
disp('Graded student data with system indicator and comparison results:')
disp(student_data(1:10, :))
