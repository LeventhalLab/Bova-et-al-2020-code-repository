function h_fig = plotAperTrajHistoIndiv(exptSummaryHisto,grp,i_rat)

laserSess = 3:12;   % define sessions
occludedSess = 13:22;

minValue = 5;   % set y axis limits
maxValue = 20;

% define figure colors for each group
ratGrp = exptSummaryHisto(grp).experimentInfo.type;
if strcmpi(ratGrp,'chr2_during') 
    lasColors = {[175/255 235/255 247/255] [175/255 235/255 247/255] [85/255 210/255 235/255] [85/255 210/255 235/255]...
    [24/255 173/255 203/255] [24/255 173/255 203/255] [41/255 103/255 196/255] [41/255 103/255 196/255]...
    [17/255 73/255 156/255] [17/255 73/255 156/255]};
elseif strcmpi(ratGrp,'chr2_between')
    lasColors = {[229/255 204/255 255/255] [229/255 204/255 255/255] [204/255 153/255 255/255] [204/255 153/255 255/255]...
    [178/255 102/255 255/255] [178/255 102/255 255/255] [127/255 0/255 255/255] [127/255 0/255 255/255]...
    [76/255 0/255 153/255] [76/255 0/255 153/255]};
elseif strcmpi(ratGrp,'arch_during')
    lasColors = {[173/255 239/255 201/255] [173/255 239/255 201/255] [116/255 226/255 163/255] [116/255 226/255 163/255]...
    [62/255 215/255 128/255] [62/255 215/255 128/255] [26/255 182/255 94/255] [26/255 182/255 94/255]...
    [11/255 129/255 62/255] [11/255 129/255 62/255]};
elseif strcmpi(ratGrp,'arch_between')
    lasColors = {[255/255 229/255 204/255] [255/255 229/255 204/255] [255/255 204/255 153/255] [255/255 204/255 153/255]...
    [255/255 153/255 51/255] [255/255 153/255 51/255] [255/255 128/255 0/255] [255/255 128/255 0/255]...
    [204/255 102/255 0/255] [204/255 102/255 0/255]};
else strcmpi(ratGrp,'eyfp')
    lasColors = {[255/255 153/255 204/255] [255/255 153/255 204/255] [255/255 102/255 178/255] [255/255 102/255 178/255]...
    [255/255 51/255 153/255] [255/255 51/255 153/255] [255/255 0/255 172/255] [255/255 0/255 172/255]...
    [204/255 0/255 102/255] [204/255 0/255 102/255]};
end

% set occlusion session colors
occColors = {[224/255 224/255 224/255] [224/255 224/255 224/255] [192/255 192/255 192/255] [192/255 192/255 192/255]...
    [160/255 160/255 160/255] [160/255 160/255 160/255] [128/255 128/255 128/255] [128/255 128/255 128/255]...
    [64/255 64/255 64/255] [64/255 64/255 64/255]};

% get aperture data
for i = 1:size(exptSummaryHisto(grp).mean_aperture_traj,3)
    ratData(i,1:22) = exptSummaryHisto(grp).mean_aperture_traj(i_rat,:,i);           
end

loopCt = 1; % plot occlusion sessions
for l = occludedSess
    plot(ratData(:,l),'Color',occColors{loopCt},'LineWidth',1);
    hold on
    loopCt = loopCt + 1;
end

loopCt = 1;
for k = laserSess   % plot laser sessions
    plot(ratData(:,k),'Color',lasColors{loopCt},'LineWidth',1);
    hold on
    loopCt = loopCt + 1;
end 

% figure properties
line([201 201],[minValue maxValue],'Color','k') % add line for pellet

box off
ylabel('aperture (mm)')
xlabel('z_{digit2} (mm)')
set(gca,'ylim',[minValue maxValue]);
set(gca,'xlim',[50 350]);
set(gca,'ytick',[0 10 20]);
set(gca,'xtick',[50 201 350]);
set(gca,'xticklabels',[-15 0 15]);
set(gca,'FontSize',10);