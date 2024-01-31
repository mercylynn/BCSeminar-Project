page 50020 "Instructor List"
{
    ApplicationArea = All;
    Caption = 'Instructor List';
    PageType = List;
    SourceTable = Instructor;
    UsageCategory = Lists;
    CardPageId = InstructorCard;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Resource No. field.';
                }
                field("Internal/External"; Rec."Internal/External")
                {
                    ToolTip = 'Specifies the value of the Internal/External field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
            }
        }
    }
}
