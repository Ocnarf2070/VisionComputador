% Auto-generated by cameraCalibrator app on 18-Jan-2019
%-------------------------------------------------------


% Define images to process
imageFileNames = {'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134705_058.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134709_564.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134711_811.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134714_885.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134717_167.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134721_050.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134722_865.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134731_769.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134734_267.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134736_841.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134741_477.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134745_127.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134801_183.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134809_471.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134815_077.jpg',...
    'D:\Users\franc\Google Drive\Ingenieria de Informatica\Curso2018-19\Visi�n por Computador\Practica 9\IMG_20190116_134817_173.jpg',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 35;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
