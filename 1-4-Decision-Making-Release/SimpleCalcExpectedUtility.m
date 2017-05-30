% Copyright (C) Daphne Koller, Stanford University, 2012

function EU = SimpleCalcExpectedUtility(I)

  % Inputs: An influence diagram, I (as described in the writeup).
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return Value: the expected utility of I
  % Given a fully instantiated influence diagram with a single utility node and decision node,
  % calculate and return the expected utility.  Note - assumes that the decision rule for the 
  % decision node is fully assigned.


% X1 = struct('var', [1], 'card', [2], 'val', [0.7, 0.3]);
% D = struct('var', [2], 'card', [2], 'val', [1 0]);
% U1 = struct('var', [1, 2], 'card', [2, 2], 'val', [10, 1, 5, 1]);
  % In this function, we assume there is only one utility node.
  F = [I.RandomFactors I.DecisionFactors];
  U = I.UtilityFactors(1);
  EU = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  allInd = unique([F(:).var]);
  allInd(U.var) = [];
  res = VariableElimination(F, allInd);
  resAll = res(1);
  for i=2:length(res)
    resAll = FactorProduct(resAll, res(i));
  end
  tmp = FactorProduct(resAll, U);
  EU = sum(tmp.val);
  
  
end