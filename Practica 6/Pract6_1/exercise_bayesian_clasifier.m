%--------------------------------------------------------------------------
%                    EXERCISE: BAYESIAN CLASSIFIER
%--------------------------------------------------------------------------

function exercise_bayesian_clasifier

% Clean the workspace
close all;
clear variables;

% Control the execution of certain parts of the exercise
execute_classification = 0;
execute_boundaries     = 1;

% Load bottle images from file and store their Hu moments
N_bottles = 15;
N_bottle_types = 3;
Bottle_types = {'botella_A_','botella_B_','botella_C_'};
types = ['A','B','C'];
path = 'imagenes_botellas/';

for type = 1:3
    for i_bottle = 1:N_bottles
        im_file_name = strcat(path,Bottle_types(type),int2str(i_bottle),'.bmp');
        im = imread(im_file_name{1});
        MHu(i_bottle,:,type) = momentos_Hu(im);
    end
end

% Show the first two moments for the images of each type
figure()
hold on;
title('Bayesian classifier')
plot (MHu(:,1,1),MHu(:,2,1),'b*')
plot (MHu(:,1,2),MHu(:,2,2),'rx')
plot (MHu(:,1,3),MHu(:,2,3),'go')

% Compute their mean and show the centroids of the two first Hu moments
centroids = [mean(MHu(:,1,1)) mean(MHu(:,1,2)) mean(MHu(:,1,3));
             mean(MHu(:,2,1)) mean(MHu(:,2,2)) mean(MHu(:,2,3));
             mean(MHu(:,3,1)) mean(MHu(:,3,2)) mean(MHu(:,3,3));
             mean(MHu(:,4,1)) mean(MHu(:,4,2)) mean(MHu(:,4,3));
             mean(MHu(:,5,1)) mean(MHu(:,5,2)) mean(MHu(:,5,3));
             mean(MHu(:,6,1)) mean(MHu(:,6,2)) mean(MHu(:,6,3));
             mean(MHu(:,7,1)) mean(MHu(:,7,2)) mean(MHu(:,7,3))];

plot (centroids(1,1),      centroids(2,1),'ks','MarkerSize',8,'MarkerFaceColor','b')
text (centroids(1,1)+0.02, centroids(2,1),'Centroid of bottle type A','Color','blue')
plot (centroids(1,2),      centroids(2,2),'ks','MarkerSize',8,'MarkerFaceColor','r')
text (centroids(1,2)+0.02, centroids(2,2),'Centroid of bottle type B','Color','red')
plot (centroids(1,3),      centroids(2,3),'ks','MarkerSize',8,'MarkerFaceColor','g')
text (centroids(1,3)+0.02, centroids(2,3),'Centroid of bottle type C','Color','green')

% Compute their covariance matrices and show them
for bt = 1:1:N_bottle_types
    desv=MHu(:,:,bt)'-centroids(:,bt);
    covars(:,:,bt) = desv*desv'/N_bottles;
    error_ellipse(covars(1:2,1:2,bt)*10,centroids(1:2,bt));
end

if execute_classification == 1
    %Ok, now load the bottles not used for training, and classify them using
    % a Bayesian classifier
    
    N_starting_bottle = N_bottles+1;
    N_bottles = 5;
    
    for type = 1:3
        for i_bottle = N_starting_bottle:N_starting_bottle+N_bottles-1
            im_file_name = strcat(path,Bottle_types(type),int2str(i_bottle),'.bmp');
            im = imread(im_file_name{1});
            MHu_to_classify(i_bottle,:,type) = momentos_Hu(im);
            
            features = MHu_to_classify(i_bottle,:,type)';
            
            % Call the three decisions functions
            d1 = evaluateDecisionFunction(features,N_bottle_types,centroids(:,1),covars(:,:,1),1/N_bottle_types);
            d2 = evaluateDecisionFunction(features,N_bottle_types,centroids(:,2),covars(:,:,2),1/N_bottle_types);
            d3 = evaluateDecisionFunction(features,N_bottle_types,centroids(:,3),covars(:,:,3),1/N_bottle_types);
            
            % Get the winner!
            [~,classified_as] = max([d1 d2 d3]);
            
            % Show graphically the results
            res = sprintf('Classified as: %c\n', types(classified_as));
            handler1 = plot(features(1),features(2),'dc','MarkerSize',10);
            handler2 = text(features(1)+0.01,features(2)+0.01,res);
            pause
            
            delete(handler1);
            delete(handler2);
        end
    end
end

if execute_boundaries == 1
    % Plot the decision boundary between all the possible pairs of bottle
    % types: AB, AC and BC.
    % First, get the matrix representing each conic section
    conic_matrix_A = get_conic_matrix(covars(1:2,1:2,1),centroids(1:2,1)');
    conic_matrix_B = get_conic_matrix(covars(1:2,1:2,2),centroids(1:2,2)');
    conic_matrix_C = get_conic_matrix(covars(1:2,1:2,3),centroids(1:2,3)');
    % Get decision boundary between all the types (their conic section
    % representation)
    decision_boundaryAB = conic_matrix_A-conic_matrix_B;
    decision_boundaryAC = conic_matrix_A-conic_matrix_C;
    decision_boundaryBC = conic_matrix_B-conic_matrix_C;
    
    % Plot them using plotConic
    plotConic(decision_boundaryAB, 'm');
    plotConic(decision_boundaryAC, 'k');
    plotConic(decision_boundaryBC, 'r');
end

end

