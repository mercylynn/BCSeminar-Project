page 50010 "Ticket Setup"
{
    ApplicationArea = All;
    Caption = 'Ticket Setup';
    PageType = Card;
    SourceTable = "Ticket Setup ";
    UsageCategory = Administration;




    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Ticket Nos."; Rec."Ticket Nos.")
                {
                    ToolTip = 'Specifies the value of the Ticket Nos. field.';
                }
                field("Posted Ticket Nos."; Rec."Posted Ticket Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Ticket Nos. field.';
                }
            }
        }
    }
}
