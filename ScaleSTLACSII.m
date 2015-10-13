function  ScaleSTLACSII(filename,writefile,scale)
% This function is written by http://blog.csdn.net/canye1984/article/details/7255916

fid=fopen(filename, 'r');
fiid = fopen(writefile, 'w');
if (fid == -1) || (fiid == -1)
    error('file error');
end


%
%reading the heading
firstline = fgetl(fid);

File_name = sscanf(firstline, '%*s %s');  %CAD object name, if needed.
pre_name = sscanf(firstline,'%s%c');


fprintf(fiid,'%s\n',pre_name);%write things to result.txt
%File_name

%define variables
vnum=0;       %Vertex number counter.
report_num=0; %Report the status as we go.
STLvcolor = 0;
STLxyz=0;


%???????????????
%Begin reading the file until touch end
while feof(fid) == 0                    % test for end of file, if not then do stuff
    tline = fgetl(fid);                 % reads a line of data from file.
    fword = sscanf(tline, '%s');       % make the line a character string
    
    fwriteword = sscanf(tline, '%s%c');
    %fprintf(fiid,'%s\n',fwriteword);
%tline    
%fword
%Check for color
   
if strncmpi(fword, 'facetnormal',11) == 1;    % Checking if a "C"olor line, as "C" is 1st char.
      
    
    STLvcolor = sscanf(tline, '%*s %*s %f %f %f'); % & if a C, get the RGB color data of the face.   % we "*s" skip the name "color" and get the data.      


       fprintf(fiid,'%s', '  facet normal ');
     
       fprintf(fiid,'%f %f %f\n',STLvcolor);
end                                            % Keep this color, until the next color is used.

%checking coordinaters
if strncmpi(fword, 'vertex',6) == 1;    % Checking if a "V"ertex line, as "V" is 1st char.
       STLxyz= sscanf(tline, '%*s %f %f %f'); % & if a V, get the XYZ data of it.
          vnum = vnum + 1; 
        
          
       fprintf(fiid,'%s','      vertex '); 
       fprintf(fiid,'%f %f %f\n',STLxyz * scale);
end

if strncmpi(fword,'outerloop',9)==1
    
    fprintf(fiid,'%s\n','    outer loop');
    %fprintf(fiid,'%s\n')
end
if strncmpi(fword,'endloop',7)==1
    
    fprintf(fiid,'%s\n','    endloop'); 
end

if strncmpi(fword,'endfacet',8)==1
    fprintf(fiid,'%s\n','  endfacet');
end




%????????
%check if coordinator has been increased
%if  vnum~=report_num
%     report_num=vnum;
%       v(:,vnum)=STLxyz;
%       c(:,vnum) = STLvcolor;              % A color for each vertex, which will color the 
%       if mod(report_num,249)==0;
%           disp(sprintf('Reading vertix num: %d.',vnum));
%       end
%end
                                                             
end


fprintf(fiid,'%s',tline);
%close the file
fclose(fid);
fclose(fiid);



%   Build face list; The vertices are in order, so just number them.
fnum = vnum/3;      %Number of faces, vnum is number of vertices.  STL is triangles.
flist = 1:vnum;     %Face list of vertices, all in order.
F = reshape(flist, 3,fnum); %Make a "3 by fnum" matrix of face list data.
%
%   Return the faces and vertexs.
%
%v=[];
%c=[];

%fout = F';  %Orients the array for direct use in patch.
%vout = v';  % "
%cout = c';




end