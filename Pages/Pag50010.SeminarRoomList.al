page 50010 SeminarRoomList
{
    ApplicationArea = All;
    Caption = 'Seminar Room List';
    PageType = List;
    SourceTable = "Seminar Room";
    UsageCategory = Lists;
    CardPageId = SeminarRoomCard;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Editable = false;
                }
                field("Maximum Participants"; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }

                field("Resource No."; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Resource No. field.';
                }
            }
        }
    }
}
