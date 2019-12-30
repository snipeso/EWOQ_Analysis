function SaveSplitTable(T, SplittingColumn, Destination)


SubTs = unique(T.(SplittingColumn));

for Indx_sT = 1:numel(SubTs)
    subT = T(strcmp(T.(SplittingColumn), SubTs{Indx_sT}), :);
    
    writetable(subT, [Destination, SubTs{Indx_sT}, '_Answers.csv'])
    save([Destination, SubTs{Indx_sT}, '_Answers.mat'], 'subT')
    
end