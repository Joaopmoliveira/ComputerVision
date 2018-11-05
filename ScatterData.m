function ScatterData(data)
    dataFromArvore=data.arvore;
    dataFromEstrada=data.estrada_alcatrao;
    dataFromMar=data.mar;
    
    scatter3(dataFromArvore(2,:),dataFromArvore(3,:),dataFromArvore(4,:));
    hold on
    scatter3(dataFromEstrada(2,:),dataFromEstrada(3,:),dataFromEstrada(4,:));
    scatter3(dataFromMar(2,:),dataFromMar(3,:),dataFromMar(4,:));
    xlabel('variance');
    ylabel('Skewness');
    zlabel('Kurtwness');
    legend('Arvore','Estrada','Mar');
end