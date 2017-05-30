% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeMEU( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  
  % We assume I has a single decision node.
  % You may assume that there is a unique optimal decision.
  D = I.DecisionFactors(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  % 
  % Some other information that might be useful for some implementations
  % (note that there are multiple ways to implement this):
  % 1.  It is probably easiest to think of two cases - D has parents and D 
  %     has no parents.
  % 2.  You may find the Matlab/Octave function setdiff useful.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
  EUF = CalculateExpectedUtilityFactor(I);
  EUF = VarTransform(EUF);
  D = VarTransform(D);
  N = length(D.card);
  Utilities = zeros(2^N, 1);
  
  for i=1:2^N
    D.val = Convert2(i, N);
    prod = FactorProduct(EUF, D);
    Utilities(i) = sum(prod.val);
  end  
  [MEU, index] = max(Utilities);
  D.val = Convert2(index, N);
  OptimalDecisionRule = D;
end

function val = Convert2(i, N)
    former = dec2bin(i - 1, N);
    tmp = dec2bin(2^N - 1, 2^N);
    latter = num2str(bitxor(str2num(former), str2num(tmp)));
    if length(latter) ~= 2^(N -1)
      latter = ['0' latter];
    end
    val = [former, latter] - '0'
end