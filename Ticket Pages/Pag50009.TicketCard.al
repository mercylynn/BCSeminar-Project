page 50009 "Ticket Card"
{
    ApplicationArea = All;
    Caption = 'Ticket Card';
    PageType = Card;
    SourceTable = "Ticket ";


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Tittle; Rec.Tittle)
                {
                    ToolTip = 'Specifies the value of the Tittle field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            group("Employee Information")
            {
                Caption = 'Employee Information';

                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Employee email"; Rec."Employee email")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
            }
            group("Ticket Information")
            {
                Caption = 'Ticket Information';

                field(Ticket_Priority; Rec.Ticket_Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ToolTip = 'Specifies the value of the Assigned To field.';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Species the value of the Category field';
                }
            }
        }
    }
}
