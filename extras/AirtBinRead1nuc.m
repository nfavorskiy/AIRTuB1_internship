%% 3.12.2021 2 lines, works 1st parcing. LOOP
%{
folder = 'C:\Temp\20211202_Airtub_data_new_SDK';
filename = '20211202_Airtub_data_new_SDK1 1 line XYZ XZ Time Array';
filepath = [folder '\' filename];


fileID = fopen(filepath,'r','b');

mydata = fread(fileID, 'single', 'b'); %b for big endian

fclose(fileID)

for linescounter = 1:2
    linenum(linescounter) = mydata(2   + (linescounter-1)*0);
    timestep{linescounter} = char(mydata(3   + (linescounter-1)*0 : 14   + (linescounter-1)*0 ));
    Xar(linescounter,:) = mydata(17   + (linescounter-1)*0 : 17+1279   + (linescounter-1)*0 );
    Zar(linescounter,:) = mydata(17+1280   + (linescounter-1)*0 : 17+1280+1279   + (linescounter-1)*0 );
end
%}
%% 3.12.2021 1000 lines, works 1st parcing. ARRAY length 2577
%{
folder = 'C:\Temp\20211202_Airtub_data_new_SDK';
filename = '20211202_Airtub_data_new_SDK1 100000 line XYZ XZ Time Array';
filepath = [folder '\' filename];


fileID = fopen(filepath,'r','b');
mydata = fread(fileID, 'single', 'b'); %b for big endian
fclose(fileID);


mydatarep = reshape(mydata,[2577 size(mydata,1)/2577]);

    linenum = mydatarep(2, :);
    timestep = mydatarep(3 : 14, :);
    Xar = mydatarep(17 : 17+1279, :);
    Zar = mydatarep(17+1280 : 17+1280+1279, :);

figure;plot(1:100001,Zar(668,1:100001),'o')
%}
%% 21.03.2022 120000 lines, NUC. Array length 2578

folder = 'D:\Data\20220524_NLR2flight';
filename = '221111_144114_';%x`nlr 2nd fl fast check
filepath = [folder '\' filename];

    fileID = fopen(filepath,'r','b');
    mydata = fread(fileID, 'single', 'b'); %b for big endian
    fclose(fileID);
    clear fileID

interpolation = 1;

if interpolation == 0%1280 points

    mydatarep = reshape(mydata,[2578 size(mydata,1)/2578]);
    % before NLR ?? 2577->2578??
    %with cluster 2575
    
    % From here all transposed, info in columns
    
    % parsing before May22 (incl. NLR test)
    %     linenum = mydatarep(2, :)';
    %     timestep = mydatarep(3 : 14, :)';%char(timestep(2:end,1))
    %     Xar = single(mydatarep(17 : 17+1279, :))';
    %     Zar = single(mydatarep(17+1280 : 17+1280+1279, :))';
    % May 22 parsing with stage coords XYZ UDP
        linenum = mydatarep(2, :)';
        timestep = mydatarep(3 : 15, :)';%char(timestep(2:end,1))
        XStageCoord = mydatarep(16, :)';
        Xar = single(mydatarep(18 : 18+1279, :))';
        Zar = single(mydatarep(18+1280 : 18+1280+1279, :))';
%     % May 22 parsing with Cluster XYZ 0
%         linenum = mydatarep(2, :)';
%         timestep = mydatarep(3 : 15, :)';%char(timestep(2:end,1))
%         XStageCoord = mydatarep(16, :)';
%         Xar = single(mydatarep(18 : 18+1279, :))';
%         Zar = single(mydatarep(18+1280 : 18+1280+1279, :))';
end
if interpolation == 1%2560 points
        mydatarep = reshape(mydata,[5138 size(mydata,1)/5138]);%?? 2577->2578??

        linenum = mydatarep(2, :)';
        timestep = mydatarep(3 : 15, :)';%char(timestep(2:end,1))
        XStageCoord = mydatarep(16, :)';
        Xar = single(mydatarep(18 : 18+2559, :))';
        Zar = single(mydatarep(18+2560 : 18+2560+2559, :))';
end
    
%     figure;plot(1:size(Zar,1),Zar(:,640),'o')
%     figure;plot(mydatarep(19:1280+18,195228),mydatarep(1281+18:1280*2+18,195228),'o')
% tt = mydatarep(19:1280,195218);
% ttt = mydatarep(1281:1280*2,195218);


% build and export point cloud
clear XYZlineAr

stepover = 1000;
if stepover == 1;



    if interpolation == 0%1280 points
        XYZlineAr(:,:,1) = repmat(linenum/1000, [1 1280]);
        XYZlineAr(:,:,2) = Xar;
        XYZlineAr(:,:,3) = Zar;
    end
    if interpolation == 1%2560 points
        XYZlineAr(:,:,1) = repmat(linenum/1000, [1 2560]);
        XYZlineAr(:,:,2) = Xar;
        XYZlineAr(:,:,3) = Zar;
    end

end
startline = 1;
stopline = 240000;
stopline = size(Xar,1);
if stepover > 1;

    if interpolation == 0%1280 points
        XYZlineAr(:,:,1) = repmat(linenum(startline:stepover:stopline)/(100), [1 1280]);
    end
    if interpolation == 1%2560 points
        XYZlineAr(:,:,1) = repmat(linenum(startline:stepover:stopline)/(100), [1 2560]);
    end

    XYZlineAr(:,:,2) = Xar(startline:stepover:stopline,:);
    XYZlineAr(:,:,3) = Zar(startline:stepover:stopline,:);
end

ptCl = pointCloud(XYZlineAr);
figure;
pcshow(ptCl,'VerticalAxisDir','Down')
title(filename);

%% 12.05.22 ptc with stage coorg

clear XYZlineAr

    XYZlineAr(:,:,1) = repmat(XStageCoord, [1 1280]);
    XYZlineAr(:,:,2) = Xar;
    XYZlineAr(:,:,3) = Zar;


ptCl = pointCloud(XYZlineAr);
figure;
pcshow(ptCl,'VerticalAxisDir','Down')
%%
% export point cloud. MeshLab cannot read .pcd
% pcwrite(ptCl,[filepath '_ascii.pcd'],'Encoding','ascii');
% pcwrite(ptCl,[filepath '_binary.pcd'],'Encoding','binary');
pcwrite(ptCl,[filepath '_binary.ply'],'PLYFormat','binary');

% pcwrite(ptCl,[filepath '_binary.ply'],'PLYFormat','ascii');
clear mydata
