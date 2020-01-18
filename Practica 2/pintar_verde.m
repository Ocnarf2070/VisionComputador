% Trozo de código para pintar un color verde en una iamgen
% de niveles de gris. En este caso, bordes de la imagen

% normalizamos la imagen de modulo
aux = 255 * im_modulo ./ max( max( im_modulo ) );
% Selecionamos lo que queremos colorear
mask = (aux > threshold);

% Tres imágenes identicas a la de nivel de gris
im_modulo_r = uint8(im);
im_modulo_g = uint8(im);
im_modulo_b = uint8(im);

% En los píxeles marcados (mask) se pone RGB = [0 255 0]
im_modulo_r(mask) = 0;
im_modulo_g(mask) = 255;
im_modulo_b(mask) = 0;

% Se crean las bandas
im_modulo_rgb(:,:,1) = im_modulo_r;
im_modulo_rgb(:,:,2) = im_modulo_g;
im_modulo_rgb(:,:,3) = im_modulo_b;