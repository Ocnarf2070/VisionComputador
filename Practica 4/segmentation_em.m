%Function to segment a grayscale image "im" into "num_seg" regions based on the
%intensity of its pixels. The third parameter numIter, is optional, and
%sets the number of iterations that the algorithm performs

function im_seg = segmentation_em(im, num_seg, numIter)

    [rows cols] = size(im);
    p_x_belong_segm = zeros(rows,cols,num_seg);

    %Initial values for the pdfs and for the prior
    mu = linspace(0,1,num_seg);
    sigma = 0.5*(mu(2)-mu(1))*[1 1];
    p_segm = ones(num_seg, 1)/num_seg;

    if nargin == 2; numIter = 10; end

    for i=1:numIter
        %Expectation - Probability of each pixel to belong to each segment
        %----------------------------------------------------------------------
        sum_p = zeros(rows,cols);
        for k=1:num_seg,
            p_x_belong_segm(:,:,k) = p_segm(k)*exp(-0.5*((im - mu(k))/sigma(k)).^2)/((2*pi)^(num_seg/2)*sigma(k));
            sum_p = sum_p + p_x_belong_segm(:,:,k);
        end
        %Normalize probabilities
        for k=1:num_seg,
            p_x_belong_segm(:,:,k) = p_x_belong_segm(:,:,k)./sum_p;
        end

        %Mazimization - Re-estimate mu, sigma and p_segm
        %----------------------------------------------------------------------
        fprintf('\n\n Iteration %d:',i);
        for k=1:num_seg,
            norm_fact = sum(sum(p_x_belong_segm(:,:,k)));
            mu(k) = sum(sum(p_x_belong_segm(:,:,k).*im))/norm_fact;
            sigma(k) = sqrt(sum(sum(p_x_belong_segm(:,:,k).*((im-mu(k)).^2)))/norm_fact);
            p_segm(k) = norm_fact/(rows*cols);
            fprintf('\n Segment %d - means %f, sigma %f', k, mu(k), sigma(k));
        end   
    end

    %Assign segments by finding the ones with maximum prob.
    im_seg = zeros(rows,cols);
    for u=1:cols,
        for v=1:rows,
            max_p = 0;
            for k=1:num_seg,
                if (p_x_belong_segm(v,u,k) > max_p)
                    im_seg(v,u) = k;
                    max_p = p_x_belong_segm(v,u,k);
                end
            end
        end
    end

    %Plot the pdfs
    figure; hold on;
    title('PDFs of the regions');
    x = 0:.01:1;
    cstring='rgbcmyk';
    for k=1:num_seg,
        norm = normpdf(x,mu(k),sigma(k));
        plot(x,norm,cstring(mod(k,7)+1));
    end
return;
