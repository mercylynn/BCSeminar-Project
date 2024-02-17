pageextension 50003 ResourceLExt extends "Resource List"
{
    layout
    {

        addafter(Type)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                ApplicationArea = All;

                ToolTip = 'Specifies whether the resource is internal/external.';
            }
            field("Maximum Participants"; Rec."Maximum Participants")
            {
                ApplicationArea = All;

                ToolTip = 'Specifies the maximum number of participants for the room.';
                // Visible = ShowMaxParticipants;
            }
        }
        // modify(Type)
        // {
        //     Visible = ShowType;
        // }
    }

    var
        ShowType: Boolean;
        ShowMaxParticipants: Boolean;
}

