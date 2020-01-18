% Esta función realiza de manera recursiva el crecimiento de una región de la imagen
% partiendo de una semilla en (x,y). El crecimiento se hace sobre sus ocho-vecinos.
%
% J. Gonzalez 
function crec_recur(x,y,toler)
 
% Variables globales para no pasar tantos argumentos a la funcion
global region;           % Region segmentada. Es una matriz del tamaño la imagen,con 
                         %      todo a cero salvo la region, a uno. 
global media;            % Media (dinamica) de la region que va creciendo (DOUBLE!). 
global points_in_region; % Numero de puntos actual de la region segmentada
global im1;              % Imagen de entrada en escala de grises
 
% Comprobacion que no estamos fuera de la imagen
if (x <= 0 | x > size(im1,2) | y <= 0 | y > size(im1,1) )
    return;
end
if (region(y,x) == 1) % si esta ya marcado (=1) no hacemos nada y salimos de la funcion
    return;
end
 
if abs(double(im1(y,x)) - media) < toler % Condicion de añadir pixel
    region(y,x) = 1;
    points_in_region = points_in_region + 1;
    media = (media * points_in_region + double(im1(y,x)))/(points_in_region+1); %calculo dinamico de la media 
 
    % Recursion sobre los 8-vecinos
    crec_recur(x-1,y+1,toler);
    crec_recur(x-1,y,toler);
    crec_recur(x-1,y-1,toler);
    crec_recur(x,y+1,toler);
    crec_recur(x,y-1,toler);
    crec_recur(x+1,y+1,toler);
    crec_recur(x+1,y,toler);
    crec_recur(x+1,y-1,toler);
end
 
return;



