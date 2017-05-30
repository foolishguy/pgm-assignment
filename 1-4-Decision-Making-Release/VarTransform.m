function TransformFactor = VarTransform(Factor)
	varLen = length(Factor.var);
	varMap = zeros(varLen, 1);
	sortedVar = sort(Factor.var);
	TransformFactor = Factor;
    TransformFactor.var = sortedVar;
	for i=1:varLen
		varMap(i) = find(Factor.var == sortedVar(i));
	end
	valLen = length(Factor.val);
	assignments = IndexToAssignment(1:valLen, Factor.card);
	for i=1:valLen
		tmp = AssignmentToIndex(assignments(i, varMap), Factor.card);
		TransformFactor.val(tmp) = Factor.val(i);
	end
end