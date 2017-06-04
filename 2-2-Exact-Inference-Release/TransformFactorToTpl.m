% a = struct('var', [7, 1], 'card', [2, 3], 'val', [0.8, 0.2, 0.6, 0.4, 0.1, 0.9])
% b = struct('var', [1, 7], 'card', [3, 2], 'val', [])

function ResFactor = TransformFactorToTpl(Factor, TplFactor)
	ResFactor = Factor;
    ResFactor.var = TplFactor.var;
	[dummy, mapVar] = ismember(Factor.var, ResFactor.var); 
    ResFactor.card = Factor.card(mapVar);
	assignments = IndexToAssignment(1:prod(ResFactor.card), ResFactor.card);
    indxFactor = AssignmentToIndex(assignments(:, mapVar), Factor.card);
	ResFactor.val = Factor.val(indxFactor);
end
