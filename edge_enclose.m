% Function Edge Enclose
% 
% Author : Prateek Chandan

function [ newedgelist, newlabeledgeim , newmodify_img ] = edge_enclose( edgelist, labeledgeim , modify_img  )
%Edge Enclosion operation (STEP 3 in algorithm)
    imsize = size(labeledgeim);
    newedgelist = {};
    edgelength = 0;
    
    newlabeledgeim = zeros(size(labeledgeim));
    newmodify_img = zeros(size(modify_img));
    %Looping over all edges
    
    for i = 1:length(edgelist)
        if edgelist{i} == 0
            continue;
        end
        lastpoint = edgelist{i}(size(edgelist{i},1),:);
        xmin = max(1,lastpoint(1)-5);
        ymin = max(1,lastpoint(2)-5);
        xmax = min(imsize(1),lastpoint(1)+5);
        ymax = min(imsize(2),lastpoint(2)+5);
        
        matchedges = [];
        
        for x=xmin:xmax
            for y=ymin:ymax
                if labeledgeim(x,y)~=0 && labeledgeim(x,y)~=i
                    if ~(edgelist{labeledgeim(x,y)}==0)
                        matchedges = [matchedges labeledgeim(x,y)];
                    end
                end
            end
        end
        
        matchedges = unique(matchedges);
        
        edgelength = edgelength+1;
        % No Nearest edge is found
        if length(matchedges)==0
            newedgelist{edgelength} = edgelist{i};
            for j = 1:length(edgelist{i})
                newlabeledgeim(edgelist{i}(j,1),edgelist{i}(j,2)) = edgelength;
                newmodify_img(edgelist{i}(j,1),edgelist{i}(j,2)) = 1;
            end
        continue
        end
        
        %Find the nearest edge with maximum length
        maxlength = length(edgelist{matchedges(1)});
        maxindex = matchedges(1);
        for j = 1:length(matchedges)
            if length(edgelist{matchedges(j)}) > maxlength
                maxlength = length(edgelist{matchedges(j)});
                maxindex = matchedges(j);
            end
        end
        
        edge1 = edgelist{i};
        firstpoint = edge1(end,:);
        
        edge3 = edgelist{maxindex};
        lastpoint = edge3(1,:);
        
        %disp(firstpoint);
        %disp('efwef');
       % disp(maxindex);
        %disp(edge3);
        %disp('efwefqweqw');
        
        [x,y]= bresenham(firstpoint(1),firstpoint(2),lastpoint(1),lastpoint(2));
        edge2 =[x y];
         
        newedgelist{edgelength} = [edge1;edge2;edge3];
        edge = newedgelist{edgelength};
        
        for j = 1:length(edge)
            newlabeledgeim(edge(j,1),edge(j,2)) = edgelength;
            newmodify_img(edge(j,1),edge(j,2)) = 1;
        end
        
        edgelist{maxindex} = 0;
        
    end
    
    function [x,y]=bresenham(x1,y1,x2,y2)

        %Matlab optmized version of Bresenham line algorithm. No loops.
        %Format:
        %               [x y]=bham(x1,y1,x2,y2)
        %
        %Input:
        %               (x1,y1): Start position
        %               (x2,y2): End position
        %
        %Output:
        %               x y: the line coordinates from (x1,y1) to (x2,y2)
        %
        %Usage example:
        %               [x y]=bham(1,1, 10,-5);
        %               plot(x,y,'or');
        x1=round(x1); x2=round(x2);
        y1=round(y1); y2=round(y2);
        dx=abs(x2-x1);
        dy=abs(y2-y1);
        steep=abs(dy)>abs(dx);
        if steep 
            t=dx;dx=dy;dy=t; 
        end

        %The main algorithm goes here.
        if dy==0 
            q=zeros(dx+1,1);
        else
            q=[0;diff(mod([floor(dx/2):-dy:-dy*dx+floor(dx/2)]',dx))>=0];
        end

        %and ends here.

        if steep
            if y1<=y2 y=[y1:y2]'; else y=[y1:-1:y2]'; end
            if x1<=x2 x=x1+cumsum(q);else x=x1-cumsum(q); end
        else
            if x1<=x2 x=[x1:x2]'; else x=[x1:-1:x2]'; end
            if y1<=y2 y=y1+cumsum(q);else y=y1-cumsum(q); end
        end
    end

end

