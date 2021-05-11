clear;


%% Face task PSTH

clear;

S = load('Face_cor.mat');

col = [0.35,0,0.030;0.51,0.12,0.020;0.69,0.31,0.11;0.78,0.48,0.31;0.85,0.65,0.53;0.54,0.72,0.81;0.25,0.53,0.68;0.040,0.36,0.56;0.010,0.21,0.47;0,0.070,0.38];

figure('color', 'w', 'position', [100 100 200 200], 'paperpositionmode', 'auto');
hold on;
tind = S.Tstamp >= -50 & S.Tstamp <= 600;
for c=size(S.PSTH,3):-1:1
    plot(S.Tstamp(tind), nanmean(S.PSTH(:,tind,c),1), 'color', col(c,:), 'linew', 2);
end
set(gca, 'xlim', [-50 600], 'xtick', 0:100:600, 'xticklabel', {'0','','200','','400','','600'}, ...
    'ylim', [12.5 20], 'ytick', 13:20, 'yticklabel', {'13','','15','','17','','19',''}, 'tickdir', 'out', 'ticklen', [.03 .03]);
axis square;
xlabel('Time (ms)');
ylabel('Firing rate');


%% Motion task PSTH
clear;

S = load('Motion_cor.mat');

col = [0.35,0,0.030;0.51,0.12,0.020;0.69,0.31,0.11;0.78,0.48,0.31;0.85,0.65,0.53;0.54,0.72,0.81;0.25,0.53,0.68;0.040,0.36,0.56;0.010,0.21,0.47;0,0.070,0.38];

figure('color', 'w', 'position', [300 100 200 200], 'paperpositionmode', 'auto');
hold on;
tind = S.Tstamp >= -50 & S.Tstamp <= 600;
for c=size(S.PSTH,3):-1:1
    plot(S.Tstamp(tind), nanmean(S.PSTH(:,tind,c),1), 'color', col(c,:), 'linew', 2);
end
set(gca, 'xlim', [-50 600], 'xtick', 0:100:600, 'xticklabel', {'0','','200','','400','','600'}, ...
    'ylim', [15 32], 'ytick', 17:3:32, 'yticklabel', {'17', '', '23', '', '29', ''}, 'tickdir', 'out', 'ticklen', [.03 .03]);
axis square;
xlabel('Time (ms)');
ylabel('Firing rate');

%% Face task PCA

clear;
PCrange = [250 600]; % ms: time window to compute PC coefficient
Time = 400; % time stamp to show PC plot

dim_sign = [1, -1, 1]; % rotating and swapping axis for visualization
dim = [3 1 2];

S = load('Face_cor.mat');

PSTH = S.PSTH_detrended;
Tstamp = S.Tstamp;
coherence = mean(S.coherence,1)/1e2;
half_cutoff = S.half_cutoff;

% PC range
ind = Tstamp >= PCrange(1) & Tstamp <= PCrange(2) & Tstamp >= half_cutoff(1) & Tstamp <= half_cutoff(2);
pcPSTH = PSTH(:, ind, :);

% run PCA
MU = mean(pcPSTH(:,:),2)';
coef = pca(bsxfun(@minus, pcPSTH(:,:)', MU));

ind = Time == Tstamp;
PCscore = bsxfun(@minus, permute(PSTH(:,ind,:), [1 3 2])', MU) * coef(:,1:3);
PCscore = PCscore .* (ones(size(PCscore,1),1) * dim_sign);

% curve fit
cx = linspace(min(coherence), max(coherence), 100);
pt = nan(100, 3);
for d=1:3
    [x, idx] = sort(coherence(:));
    y = PCscore(idx,d);
    Param = csaps(x, y, [.995 1 1 1 .1 .01 .1 1 1 1], [], [1 1 1 1 1 1 1 1 1 1]);
    pt(:,d) = fnval(Param, cx);
end

% plot
col = [0.35,0,0.030;0.51,0.12,0.020;0.69,0.31,0.11;0.78,0.48,0.31;0.85,0.65,0.53;0.54,0.72,0.81;0.25,0.53,0.68;0.040,0.36,0.56;0.010,0.21,0.47;0,0.070,0.38];

figure('color', 'w', 'position', [500 100 200 200], 'paperpositionmode', 'auto');
hold on;
plot3(pt(:,dim(1)), pt(:,dim(2)), pt(:,dim(3)), 'col', [.5 .5 .5], 'linew', 2);
for n=1:size(PCscore,1)
    plot3(PCscore(n,dim(1)), PCscore(n,dim(2)), PCscore(n,dim(3)), 'o', 'markeredgecol', col(n,:), 'markerfacecol', col(n,:), 'markers', 10);
end
axis square;
xlabel(sprintf('PC %d', dim(1)));
ylabel(sprintf('PC %d', dim(2)));
zlabel(sprintf('PC %d', dim(3)));
xlim([-25 34]);
ylim([-49 42]);
zlim([-31 24]);
view([106 -3]);


%% Motion task PCA

clear;
PCrange = [250 600];
Time = 400;
dim_sign = [-1 -1 -1];
dim = [3 1 2];

S = load('Motion_cor.mat');

PSTH = S.PSTH_detrended;
Tstamp = S.Tstamp;
coherence = mean(S.coherence,1)/1e2;
half_cutoff = S.half_cutoff;

% PC range
ind = Tstamp >= PCrange(1) & Tstamp <= PCrange(2) & Tstamp >= half_cutoff(1) & Tstamp <= half_cutoff(2);
pcPSTH = PSTH(:, ind, :);

% run PCA
MU = mean(pcPSTH(:,:),2)';
coef = pca(bsxfun(@minus, pcPSTH(:,:)', MU));

ind = Time == Tstamp;
PCscore = bsxfun(@minus, permute(PSTH(:,ind,:), [1 3 2])', MU) * coef(:,1:3);
PCscore = PCscore .* (ones(size(PCscore,1),1) * dim_sign);

% curve fit
cx = linspace(min(coherence), max(coherence), 100);
pt = nan(100, 3);
for d=1:3
    [x, idx] = sort(coherence(:));
    y = PCscore(idx,d);
    Param = csaps(x, y, [.995 1 1 1 .1 .01 .1 1 1 1], [], [1 1 1 1 1 1 1 1 1 1]);
    pt(:,d) = fnval(Param, cx);
end

% plot
col = [0.35,0,0.030;0.51,0.12,0.020;0.69,0.31,0.11;0.78,0.48,0.31;0.85,0.65,0.53;0.54,0.72,0.81;0.25,0.53,0.68;0.040,0.36,0.56;0.010,0.21,0.47;0,0.070,0.38];

figure('color', 'w', 'position', [700 100 200 200], 'paperpositionmode', 'auto');
hold on;
plot3(pt(:,dim(1)), pt(:,dim(2)), pt(:,dim(3)), 'col', [.5 .5 .5], 'linew', 2);
for n=1:size(PCscore,1)
    plot3(PCscore(n,dim(1)), PCscore(n,dim(2)), PCscore(n,dim(3)), 'o', 'markeredgecol', col(n,:), 'markerfacecol', col(n,:), 'markers', 10);
end
axis square;
xlabel(sprintf('PC %d', dim(1)));
ylabel(sprintf('PC %d', dim(2)));
zlabel(sprintf('PC %d', dim(3)));
xlim([-44 28]);
ylim([-131 114]);
zlim([-38 30]);
view([-100 -20]);
