%% 2 Combination of Body Joints (per Participant, per Scenario)


%Combine body joint of interest for <Scenario#, Participant#>.

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

                %Info: continuously trackable in all scenarios.
            
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


        combining_data_1;

    end