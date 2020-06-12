function phenotypeFactor = constructSigmoidPhenotypeFactor(alleleWeights, geneCopyVarOneList, geneCopyVarTwoList, phenotypeVar)
% This function takes a cell array of alleles' weights and constructs a 
% factor expressing a sigmoid CPD.
%
% You can assume that there are only 2 genes involved in the CPD.
%
% In the factor, for each gene, each allele assignment maps to the allele
% whose weight is at the corresponding location.  For example, for gene 1,
% allele assignment 1 maps to the allele whose weight is at
% alleleWeights{1}(1) (same as w_1^1), allele assignment 2 maps to the
% allele whose weight is at alleleWeights{1}(2) (same as w_2^1),....  
% 
% You may assume that there are 2 possible phenotypes.
% For the phenotypes, assignment 1 maps to having the physical trait, and
% assignment 2 maps to not having the physical trait.
%
% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES
%
% Input:
%   alleleWeights: Cell array of weights, where each entry is an 1 x n 
%   of weights for the alleles for a gene (n is the number of alleles for
%   the gene)
%   geneCopyVarOneList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the first parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor)
%   geneCopyVarTwoList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the second parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor) -- Note that both copies of each gene are from the same person,
%   but each copy originally came from a different parent
%   phenotypeVar: Variable number corresponding to the variable for the 
%   phenotype (goes in the .var part of the factor)
%
% Output:
%   phenotypeFactor: Factor in which the values are the probabilities of 
%   having each phenotype for each allele combination (note that this is 
%   the FULL CPD with no evidence observed)

phenotypeFactor = struct('var', [], 'card', [], 'val', []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INSERT YOUR CODE HERE
% Note that computeSigmoid.m will be useful for this function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% Fill in phenotypeFactor.var.  This should be a 1-D row vector.
% Fill in phenotypeFactor.card.  This should be a 1-D row vector.

phenotypeFactor.var = [phenotypeVar geneCopyVarOneList' geneCopyVarTwoList'];

%{
genecard = [];
for i = 1:length(geneCopyVarOneList),
	count = length(alleleWeights{i});
	m = (count * (count + 1))/2;
	genecard = [genecard m];
end;
%}

phenotypeFactor.card = [2 length(alleleWeights{1}) length(alleleWeights{2}) length(alleleWeights{1}) length(alleleWeights{2})]
phenotypeFactor.val = zeros(1, prod(phenotypeFactor.card));

%{
[allelesToGenotypes1, genotypesToAlleles1] = generateAlleleGenotypeMappers(length(alleleWeights{1}));
[allelesToGenotypes2, genotypesToAlleles2] = generateAlleleGenotypeMappers(length(alleleWeights{2}));
%}

for i=1:length(alleleWeights{1}),
	for j=1:length(alleleWeights{2}),
		for k=1:length(alleleWeights{1}),
			for l=1:length(alleleWeights{2}),

				assign1 = [1, i, j, k, l];
				assign2 = [2, i, j, k, l];

				%gene1p1 = genotypesToAlleles1(i, :)
				%gene2p1 = genotypesToAlleles2(j, :)
				%gene1p2 = genotypesToAlleles1(k, :)
				%gene2p2 = genotypesToAlleles2(l, :)

				total_weight = alleleWeights{1}(i) + alleleWeights{2}(j) + alleleWeights{1}(k) + alleleWeights{2}(l);
				%total_weight = total_weight +  alleleWeights{2}(gene2p1(1)) + alleleWeights{2}(gene2p1(2)) + alleleWeights{2}(gene2p2(1)) + alleleWeights{2}(gene2p2(2));

				z = computeSigmoid(total_weight);

				phenotypeFactor.val(AssignmentToIndex(assign1, phenotypeFactor.card)) = z;
				phenotypeFactor.val(AssignmentToIndex(assign2, phenotypeFactor.card)) = 1-z;
			end;
		end;
	end;
end;







% Replace the zeros in phentoypeFactor.val with the correct values.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%