% This function calculates the entropy of a patch
% Input: patch = patch for which entropy has to be calculated
%        no_bins = a fixed number '64' bins are used
% Output: ent = entropy of the patch

function ent = entropyPatch(patch,no_bins)
    if(nargin < 2)
        if(~exist('no_bins','var'))
            no_bins = 64;
        end
    end
    counts = imhist(patch,no_bins);
    prob = counts/sum(counts);
    ent = -prob.*log2(prob);
    ent(isnan(ent)) = [];
    ent = sum(ent);
end