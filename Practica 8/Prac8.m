close all
clear variables

% 1: Homogeneous transformations
% 2: Camera-to-world transformation
% 3: World-to-camera transformation
execute = 3;

% -------------------------------------------------------------------------
% 1: Homogeneous transformations
%
if execute == 1 
    
    % Initial translations
    tx = 0; ty = 0; tz = 0;

    % Initial reference frame
    T = [1 0 0 tx
         0 1 0 ty
         0 0 1 tz
         0 0 0  1]; 
     showTransformation(T);
     pause;
     
     % Move the camera 0.5 meters forward
     tx = 0.5; ty = 0; tz = 0;
     T = [1 0 0 tx
          0 1 0 ty
          0 0 1 tz
          0 0 0  1]; 
     showTransformation(T);
     pause;
     
     % Rotate the camera 35degrees to look to the left (yaw rotation)
     tx = 0; ty = 0; tz = 0;
     yaw = deg2rad(35);
     cy=cos(yaw);
     sy=sin(yaw);
     I = [1 0 0 tx
          0 1 0 ty
          0 0 1 tz
          0 0 0 1];
      R =[cy -sy 0 0
          sy  cy 0 0
          0   0  1 0
          0   0  0 1];
      T=I*R;
     showTransformation(T);
     pause;
     
     % Move the camera 0.5 meters upwards and rotate it downwards
     tx = 0; ty = 0; tz = 0.5;
     pitch = deg2rad(60);
     cp=cos(pitch);
     sp=sin(pitch);
     T = [cp 0   sp tx
          0  1   0  ty
         -sp 0   cp tz
          0  0   0  1];
     showTransformation(T);
     pause;
     
% -------------------------------------------------------------------------
% 2: Camera-to-world transformation
%     
elseif execute == 2 || execute == 3
    
    % Read the rgb and depth images images
    im_rgb = imread('person_rgb.png');
    im_depth = imread('person_depth.png');    
 
    % Show them
    figure
    imshow(im_rgb)
    figure
    imshow(im_depth)
    
    % Camera intrinsic parameters
    f = 525;
    x0 = 319.5;
    y0 = 239.5;
    
    % Initialization of useful vectors
    [rows,cols] = size(im_depth);
    points_x = zeros(rows,cols);
    points_y = zeros(rows,cols);
    points_z = zeros(rows,cols);
    
    % Depth scale and max depth considered
    scale = 0.0002;
    max_depth = 5; 
    
    % Obtain the 3D coordinates of each pixel
    for y=1:rows
        for x=1:cols
            points_z(y,x) = double(im_depth(y,x))*scale;
            if points_z(y,x) > max_depth % check max depth
                points_z(y,x) = 0;
            end
            points_x(y,x) = -1*((x-x0)/f)*points_z(y,x);
            points_y(y,x) = -1*((y-y0)/f)*points_z(y,x);            
        end
    end
    
    
    downsample = 2; % increment this downsampling depending on your 
                    % pc's computational power
                        
    if execute == 2
        figure
        plot3DScene(points_x,points_y,points_z,im_rgb,downsample);
    end
end

% -------------------------------------------------------------------------
% 3: World-to-camera transformation
%
if execute == 3
    
    % Modify this transformation
    transform = [-0.3; -0.3; -0.3; 0; -10; 0]; % -z, -x, -y, z, yaw, pitch, roll
    %transform = [0; 0; 0; 0; 0; 0];
    %transform = [0.1; 0.3; 0.5; 10; -10; 10];
    %transform = [0.1; 0.3; 0.5; 0; 10; 0];
    T = TMatrixFromValues(transform);
    
    % Useful variables
    proj_x = zeros(rows,cols);
    proj_y = zeros(rows,cols);
    z_t = zeros(rows,cols);
    
    % Coompute the coordinates (pixels) of each 3D point
    for x=1:cols
        for y=1:rows
            
            % Apply the transformation T to the point
            % The coordinates are reorder because of the Matlab coordinates
            % system: x towards (our z), y left (our x), z upwards (our y)
            p = [points_z(y,x); points_x(y,x); points_y(y,x); 1];
            z_t(y,x) = T(1,:)*p;
            x_t = T(2,:)*p;
            y_t = T(3,:)*p;
            
            % Now, use the K matrix to retrieve proj_x (x') and proj_y
            % (y'). These are the coordinates (x',y') of the 3D point in
            % the image!
            kx=1;ky=1;
            K=[f*kx 0    x0
               0    f*ky y0];
            M=[-x_t/z_t(y,x);-y_t/z_t(y,x);1];
            m=K*M;
            %M=[-x_t;-y_t;z_t(y,x)] (1)
            %We divided the Vector 1 because z_t has his own scale and we
            %need to elimate that becuase te other valor has that scale and
            %mess with the result
            proj_x(y,x) = m(1);
            proj_y(y,x) = m(2);            
        end
    end
    
    figure
    renderNewImage(proj_x,proj_y,z_t,im_rgb);
end

 
 
 

