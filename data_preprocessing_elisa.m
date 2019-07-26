


clear;

close all;



%interface for costumisation

mode = "Coordinate";

amount_body_joints_chosen = 21;

ActivityTotal = 18;


for activity = 1:18
    
    %for mode coordinate
    if activity == 1
        
        column = 30;
        
    elseif activity == 2
            
        column = 30;
        
    elseif activity == 3
        
        column = 30;
        
    elseif activity == 4
        
        column = 30;
    
    elseif activity == 5
        
        column = 90;
        
    elseif activity == 6
        
        column = 60;
    
    elseif activity == 7
        
        column = 60;
        
    elseif activity == 8 
        
        column = 90;
        
    elseif activity == 9
        
        column = 90;
        
    elseif activity == 10
        
        column = 60;
        
    elseif activity == 11
    
        column = 180;
    
    elseif activity == 12
    
        column = 90;
        
    elseif activity == 13
     
        column = 60;
    
    elseif activity == 14
    
        column = 90;
        
    elseif activity == 15
    
        column = 90;
    
    elseif activity == 16
    
        column = 90;
        
    elseif activity == 17
    
        column = 90;
        
    elseif activity == 18
            
            column = 90;
            
        end
    
%insert amount of frames (column) per activity    

    for participant = 2:2
        
          % amount of repetitions
            if activity == 1

                repetition_lim = 5;

            elseif activity == 2

                repetition_lim = 5;

            elseif activity == 3

                repetition_lim = 5;

            elseif activity == 4

                repetition_lim = 5;

            elseif activity == 5

                repetition_lim = 3;

            elseif activity == 6

                repetition_lim = 1;

            elseif activity == 7

                repetition_lim = 4;

            elseif activity == 8 

                repetition_lim = 3;

            elseif activity == 9

                repetition_lim = 3;

            elseif activity == 10

                repetition_lim = 3;

            elseif activity == 11

                repetition_lim = 3;

            elseif activity == 12

                repetition_lim = 3;

            elseif activity == 13

                repetition_lim = 3;

            elseif activity == 14

                repetition_lim = 3;

            elseif activity == 15

                repetition_lim = 3;

            elseif activity == 16

                repetition_lim = 3;

            elseif activity == 17

                repetition_lim = 3;

            elseif activity == 18

                    repetition_lim = 3;

            end
   
        for repetition = 1:repetition_lim
            
          

            %Create path to access data available.

            PathLayer1 = fullfile('C:','Users','Thomas','Documents',...
                'Dataset','IfM-CHLab2019-Roth');

            PathLayer2 = sprintf('Act%d', activity);

            PathLayer3 = sprintf('Part%d', participant);

            PathLayer4 = sprintf('act%d_part%d_rep%d_kinect_prep.mat', ...
                activity, participant, repetition);

            Path = strcat (PathLayer1,'\',PathLayer2,'\',PathLayer3,'\',PathLayer4);

           

            % Loading respective data of body joints.

            File = load(Path);

            BodyJoints = File.JointsData;

           

%% 2 Combination of Body Joints (per Participant, per Scenario)

           

            %Combine body joint of interest for <Scenario#,Participant#>.

            %Result is a table that combines data of interest for one

            %person and one scenario.

%initialise data desired structure

CombinedInputTable=[];

CombinedOutputTable=[];

%accessing data

    CombinedStream=[];

    bodypart_pointer = 1;

    bodypartName = "False";

    extcounter = 0;

    

    
     while bodypart_pointer <= amount_body_joints_chosen

 

                switch bodypart_pointer

                    %Info: continously trackable in all scenarios.

                    case 1

                        bodypartName =  "Head";

                    case 2

                        bodypartName = "Neck";

                    case 3

                        bodypartName =  "Chest";

                    case 4

                        bodypartName =  "MiddleSpine";

                    case 5

                        bodypartName =  "LowerSpine";

                    case 6

                        bodypartName =  "Hip";

                    case 7

                        bodypartName =  "Center_of_mass";

                    case 8

                        bodypartName =  "Center_of_mass_projection_to_ground";

       

                    %Info: continously trackable in all scenarios.

                    case 9

                        bodypart =     "LHand";

                    case 10

                        bodypart =      "REye";

                    case 11

                        bodypart =      "EffectorHead";

                    case 12

                        bodypart =      "RClavicle";

                    case 13

                        bodypart =      "RShoulder";

                    case 14

                        bodypart =      "RForearm";

                    case 15

                        bodypart =     "RHand";

                    case 16

                        bodypart =      "LClavicle";

                    case 17

                        bodypart =      "LShoulder";

                    case 18

                        bodypart =      "LForehand";

                    case 19

                        bodypart =      "LHand";

                    case 20

                        bodypart =      "RThigh";

                    case 21

                        bodypart =      "RShin";

                    case 22

                        bodypart =      "RFoot";

                    case 23

                        bodypart =      "RToe";

                    case 24

                        bodypart =      "EffectorRToe";

                    case 25

                        bodypart =      "LThigh";

                    case 26

                         bodypart =     "LShin";

                    case 27

                        bodypart =      "LFoot";

                    case 28

                        bodypart =      "LToe";

                    case 29

                        bodypart =      "EffectorToe";

                end

   

                Bodypart_raw=BodyJoints.(bodypartName);

                ABodypart=(Bodypart_raw.(mode));

                ABodypart_cell=struct2cell(ABodypart);

                ABodypart_cell(1,:)=[];

                Bodypart_cleaned = cell2mat(ABodypart_cell);

 

        %Combine all bodyjoints of one participant and one scenario.

        intcounter = 1;

        while intcounter <= 3

            c = intcounter + extcounter;

            CombinedStream(c,:) = Bodypart_cleaned(intcounter,:);

            intcounter=intcounter+1;

        end



        extcounter=extcounter+3;

        bodypart_pointer= bodypart_pointer+1;

     end
%% 3 Normalise the Data using Center_of_mass.

%  Normalisation of body joints with Head-Neck ratio.

            StreamNorm = [];

 

                for column_count = 1:(size(CombinedStream,2))

                   

                    %Getting the reference points JointHead (Jh) and JointNeck (Jn).

                    Xh = (CombinedStream(1,column_count));

                    Yh = (CombinedStream(2,column_count));

                    Zh = (CombinedStream(3,column_count));

                    Jh = [Xh,Yh,Zh];

 

                    Xn = (CombinedStream(4,column_count));

                    Yn = (CombinedStream(5,column_count));

                    Zn = (CombinedStream(6,column_count));

                    Jn = [Xn,Yn,Zn];

 

                    tmp = [];

                    row_count = 1;

 

                    while row_count <= ((amount_body_joints_chosen-2)*3)

 

                        %Get respective joints to normalise.

                        Xi = (CombinedStream(row_count + 5,column_count));

                        Yi = (CombinedStream(row_count + 6,column_count));

                        Zi = (CombinedStream(row_count + 7,column_count));

                        Ji = [Xi,Yi,Zi];

 

                        %Normalise bodj joint vector.

                        JNorm = ((Ji-Jh)/norm(Jn-Jh))';

 

                        %Combine all normalised joint vectors.

                        tmp = [tmp;JNorm];

                        row_count = row_count + 3;

                    end

 

                    %Insert the normalised vector into the overall Table.

                    StreamNorm(:,column_count) = tmp;

                end

           

            %Combine current values with values previously collected.

            CombinedInputTable = [CombinedInputTable,StreamNorm];
            
        end
    end  
end          
%% 4 Classification Vectors (Character and Numeric Vector).
           
%Info: Row of Tbl : values of one frame, Features of Table: feature.

Tbl = (CombinedInputTable)';

 

%Specify ResponseVarName as a character vector.

LabledVectorChar  = [];

LabledVectorNum  = [];

ClassifierTmp = [];

ActivityCount = 1;

 

i = 1;

while i < size(Tbl, 1)

   

    for j = 1: column*1
        % probably participants

       

        switch ActivityCount

        case 1

            ClassifierTmp =  'Reaching';

        case 2

            ClassifierTmp =  'Grasping';

        case 3

            ClassifierTmp =  'Moving   ';

        case 4

            ClassifierTmp =  'Releasing     ';

        case 5

            ClassifierTmp =  'Positioning        ';

        case 6

            ClassifierTmp =  'Disengaging ';

        case 7

            ClassifierTmp =  'HandTurning     ';

        case 8

            ClassifierTmp =  'EyeTravel      ';

        case 9

            ClassifierTmp =  'EyeFocus        ';
        
        case 10

            ClassifierTmp =  'FootMotion';

        case 11

            ClassifierTmp =  'LegMotion';

        case 12

            ClassifierTmp =  'SideStep';

        case 13

            ClassifierTmp =  'BodyTurn ';

        case 14

            ClassifierTmp =  'Walking';

        case 15

            ClassifierTmp =  'Bending';

        case 16

            ClassifierTmp =  'Squating';

        case 17

            ClassifierTmp =  'Kneeing';

        case 18

            ClassifierTmp =  'Sitting';

        end

           

        LabledVectorChar = [LabledVectorChar; ClassifierTmp];

        LabledVectorNum  = [LabledVectorNum; ActivityCount];

       

    end

    ActivityCount = ActivityCount + 1;

    i = i + (column*16);

end

 

%% 5 Result: Normalised input data and corresponding output data.

 

A_Tbl_Input          =    CombinedInputTable;

A_Tbl_Output         =    CombinedOutputTable;

A_LabledVectChar     =    LabledVectorChar;

A_LabledVectNum      =    LabledVectorNum;

 

 

%% Appendix

% For some algorithms it is essential that variables, predictors and

% classyfiers are combined to one single table.

 

%Combine Table_Input and LabledVectNum

%transpV = (A_LabledVectNum)';

%A_Tbl_Combined = [A_Tbl_Input; transpV];

 
         
           

