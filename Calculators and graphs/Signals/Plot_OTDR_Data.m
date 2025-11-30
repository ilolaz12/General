%% Variables
% Define file name
FileName = 'C:\Users\ilo_l\Downloads\FibreData_8.txt';
% Load file
dB = load(FileName);  % Assumes single-column dB data

%% Constants
c = 3e8; % Speed of light in m/s
v = (2/3)*c; % Speed in fiber (m/s)
sampling_interval = 10e-9; % 10 ns
N = length(dB);
t = (0:N-1) * sampling_interval;
distance = (v .* t) / 2;

%% Parameters
drop_thresh = -0.13;
min_spacing = 20;
steady_slope_thresh = 0.05;
noise_margin = 10;

results = [];
types = {};

%% Detect all drop events and classify segments
last_idx = 1;
i = 1;

while i < N - 1
    drop = dB(i+1) - dB(i);
    if drop < drop_thresh
        % Event start
        seg_start_idx = i;
        seg_start_dB = dB(i);
        seg_start_dist = distance(i);

        % Move forward to find segment end (where trace levels out)
        j = i + min_spacing;
        while j < N-1 && abs(dB(j+1) - dB(j)) < steady_slope_thresh
            j = j + 1;
        end
        if j >= N
            j = N - 1;
        end

        seg_end_idx = j;
        seg_end_dB = dB(j);
        seg_end_dist = distance(j);

        % Classify drop
        if abs(drop) < 0.3
            drop_type = "Connector loss";
        elseif abs(drop) < 0.7
            drop_type = "Fiber swap / Splice";
        else
            drop_type = "Severe break or fault";
        end

        % Always record initial cabling loss from 0 if it's the first segment
        if last_idx == 1 && seg_start_idx > 1
            prev_seg_start_dB = dB(last_idx);
            prev_seg_end_dB = dB(seg_start_idx);
            prev_seg_start_dist = distance(last_idx);
            prev_seg_end_dist = distance(seg_start_idx);
            prev_seg_len = prev_seg_end_dist - prev_seg_start_dist;
            prev_seg_loss = prev_seg_end_dB - prev_seg_start_dB;
            prev_seg_loss_per_km = prev_seg_loss / prev_seg_len * 1000;

            results(end+1,:) = [prev_seg_start_dist, prev_seg_end_dist, prev_seg_len, prev_seg_loss, prev_seg_loss_per_km];
            types{end+1} = "Cabling loss";
        elseif last_idx < seg_start_idx && ~strcmp(drop_type, "Connector loss")
            % Skip connector noise zone
            adj_idx = seg_start_idx + noise_margin;
            if adj_idx >= seg_end_idx
                adj_idx = seg_end_idx;
            end
            prev_seg_start_dB = dB(last_idx);
            prev_seg_end_dB = dB(adj_idx);
            prev_seg_start_dist = distance(last_idx);
            prev_seg_end_dist = distance(adj_idx);
            prev_seg_len = prev_seg_end_dist - prev_seg_start_dist;
            prev_seg_loss = prev_seg_end_dB - prev_seg_start_dB;
            prev_seg_loss_per_km = prev_seg_loss / prev_seg_len * 1000;

            results(end+1,:) = [prev_seg_start_dist, prev_seg_end_dist, prev_seg_len, prev_seg_loss, prev_seg_loss_per_km];
            types{end+1} = "Cabling loss";
        end

        seg_len = seg_end_dist - seg_start_dist;
        seg_loss = seg_end_dB - seg_start_dB;
        seg_loss_per_km = seg_loss / seg_len * 1000;

        results(end+1,:) = [seg_start_dist, seg_end_dist, seg_len, seg_loss, seg_loss_per_km];
        types{end+1} = drop_type;

        last_idx = seg_end_idx + 1;
        i = seg_end_idx + 1;
    else
        i = i + 1;
    end
end

%% Create results table
segment_table = array2table(results, 'VariableNames', {'Start_m','End_m','Length_m','Loss_D_B','Loss_per_km_D'});
segment_table.Type = types';
disp(segment_table);

%% Plot
figure();
plot(distance, dB);
xlabel('Distance in meters');
ylabel('Power (dB)');
title('OTDR Trace');
grid on;
print(gcf, 'C:\Users\ilo_l\Downloads\OTDRresults.png', '-dpng');