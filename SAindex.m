% This is the main file of the subspace alignment index
% Input: I = image in double
% Output: score = Quality score, lower score implies good quality image and
%                 higher score implies a bad quality image
% Display: Runtime is also displayed

function score = SAindex(I)
tic
%% Parameters %%
    w = 11;
    N = 4000;
    entropyThresh = 3;
%% Source information %%
    f = load('./data/SourcePatches.mat');   % Source Patches
    Xs = f.Xs;    
    f = load('./data/SourcePCA.mat');       % Source PCA subspace
    Ps = f.s_coeff;
%% Target information %%    
    Xt = getPatches(I,w,N,entropyThresh);   % Target Patches
    Pt = pca(Xt');                          % Target PCA subspace
%% Quality Score %%    
    M = Ps'*Pt;                                % Transformation matrix
    score = 100*norm(M(:), 1)/(length(M)^2);   % Quality score
toc
end