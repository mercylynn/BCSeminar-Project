pageextension 50002 ResourceCExt extends "Resource Card"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Internal/External"; Rec."Internal/External")
            {

                ToolTip = 'Specifies if the resource is internal/external.';
            }
        }

        addafter("Personal Data")
        {
            group(Rooms)
            {
                field("Maximum Participants"; Rec."Maximum Participants")
                {

                    ToolTip = 'Specifies the maximum number of participants for the room.';
                }
            }
        }
    }
}
