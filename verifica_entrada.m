function Boolean = verifica_entrada(param)
%Esta função verifica se o parametro de entrada corresponde a algum dos
%campos da struct que contem os dados classificados
% arvore,mar,estrada_batida,estrada_alcatrao
switch param
    
    case 'arvore'
        Boolean=0;
    case 'mar'
        Boolean=0;
    case 'estrada_batida'
        Boolean=0;
    case 'estrada_alcatrao'
        Boolean=0;
    otherwise
        Boolean=1;   
end
end

