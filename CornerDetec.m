function [C] = CornerDetec(BWcanny)

%1. Get rid of the white border
I2 = imclearborder(BWcanny);

%2. Find each of the four corners
[y,x] = find(I2);
[~,loc] = min(y+x);
C = [x(loc),y(loc)];
[~,loc] = min(y-x);
C(2,:) = [x(loc),y(loc)];
[~,loc] = max(y+x);
C(3,:) = [x(loc),y(loc)];
[~,loc] = max(y-x);
C(4,:) = [x(loc),y(loc)];

end
