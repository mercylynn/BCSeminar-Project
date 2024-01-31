page 50007 InstructorCard
{
    ApplicationArea = All;
    Caption = 'Instructor Card';
    PageType = Card;
    SourceTable = Instructor;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Internal/External"; Rec."Internal/External")
                {
                    ToolTip = 'Specifies the value of the Internal/External field.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Resource No. field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
            }
        }
    }
}
