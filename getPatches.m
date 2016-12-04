% This function extracts patches of size 'w x w' from an image using
% a sliding window and selects maximum of 'N' patches randomly
% Input: I = image
%        w = patch size
%        N = maximum number of target patches
%        entropy_thresh = minimum entropy for selecting a patch        
% Outut: X = extracted patches

function X = getPatches(I,w,N,entropyThresh)
    n1 = size(I,1);
    n2 = size(I,2);
    stride = 4;    
%% Patch locations %%
    x = w/2:stride:n1-(w/2);
    y = w/2:stride:n2-(w/2);
    [dY,dX] = meshgrid(y,x);
    [r, c] = size(dX);    
%% extraction the patches%%
    P = [];        
    for i=1:r(1)
        for j=1:c
            px = dX(i,j);
            py = dY(i,j);
            p = I(px-(w/2)+1:px+(w/2),py-(w/2)+1:py+(w/2));
        % Selecting patches above the entropy threshold
            if(entropyPatch(p) > entropyThresh)
                P = [P reshape(p,w^2,1)];
            end
        end
    end
%% Random selection of patches %%
    X = [];
    noPatches = size(P,2);
    if(noPatches < N)
        patchIndcs = randsample(noPatches, noPatches);
    else
        patchIndcs = randsample(noPatches, N);
    end
    X = [X P(:,patchIndcs)];
end