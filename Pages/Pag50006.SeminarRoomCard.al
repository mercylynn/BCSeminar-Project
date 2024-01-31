page 50006 SeminarRoomCard
{
    ApplicationArea = All;
    Caption = 'Seminar Room Card';
    PageType = Card;
    SourceTable = "Seminar Room";

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
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(Address2; Rec.Address2)
                {
                    ToolTip = 'Specifies the value of the Address2 field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Internal/External"; Rec."Internal/External")
                {
                    ToolTip = 'Specifies the value of the Internal/External field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
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
            group(Communication)
            {
                Caption = 'Communication';

                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ToolTip = 'Specifies the value of the Home Page field.';
                }
            }
        }
    }
}
