function plotNumAttempts(exptSummaryHisto,i_grp)

retrainSess = 1:2; % define test sessions
laserSess = 3:12;
occludedSess = 13:22;

ratGrp = exptSummaryHisto.experimentInfo.type; % define colors for each group
if strcmpi(ratGrp,'chr2_during')
    figColor = [.12 .16 .67];
elseif strcmpi(ratGrp,'chr2_between')
    figColor = [127/255 0/255 255/255];
elseif strcmpi(ratGrp,'arch_during')
    figColor = [0 .4 0.2];
elseif strcmpi(ratGrp,'arch_between')
    figColor = [255/255 128/255 0/255];
else strcmpi(ratGrp,'eyfp')
    figColor = [.84 .14 .63];
end

indivColor = [.85 .85 .85];

% calculate averages, stdevs
avgRetrain = nanmean(exptSummaryHisto.mean_num_reaches(1:2,:)); % get average baseline
for k = 1:size(avgRetrain,2)
    normData(:,k) = exptSummaryHisto.mean_num_reaches(1:22,k)./avgRetrain(k); % normalize each rats' data to baseline
end
avgData = nanmean(normData,2);
numDataPts = sum(~isnan(exptSummaryHisto.mean_num_reaches),2);
errBars = nanstd(normData,0,2)./sqrt(numDataPts);

% set background color opacity
if i_grp == 1 || i_grp == 3
    patchShade = 0.07;
elseif i_grp == 2 || i_grp == 4 || i_grp == 5
    patchShade = 0.11;
end

% set marker sizes
avgMarkerSize = 45;
indMarkerSize = 4;

% plot individual data
for i = 1:size(normData,2)
    plot(1:22,normData(:,i),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
    hold on
end 

% plot average data
hold on
p1 = scatter(retrainSess,avgData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
p2 = scatter(laserSess,avgData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
p3 = scatter(occludedSess,avgData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

%figure properties

patchX = [2.5 12.5 12.5 2.5]; % set background color dimensions
patchY = [-.25 -.25 4 4];
    
line([0 23],[1 1],'Color','k')
% add in background color
patch(patchX,patchY,figColor,'FaceAlpha',patchShade,'LineStyle','none')


ylabel({'number of';'reach attempts'},'FontSize',10)
xlabel('session number')
set(gca,'ylim',[-.25 4],'ytick',[0 1 2 3 4]);
set(gca,'xlim',[0 23]);
set(gca,'xtick',[1 2 3 12 13 22]);
set(gca,'xticklabels',[9 10 1 10  1 10]);
set(gca,'FontSize',10);
box off

legend([p1 p2 p3],{'retraining','laser on','occluded'},'AutoUpdate','off') % create legend
legend('boxoff')