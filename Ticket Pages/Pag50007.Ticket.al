page 50007 "Ticket "
{
    ApplicationArea = All;
    Caption = 'Ticket ';
    PageType = List;
    SourceTable = "Ticket ";
    UsageCategory = Lists;
    CardPageId = "Ticket Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Tittle; Rec.Tittle)
                {
                    ToolTip = 'Specifies the value of the Tittle field.';
                }
                // field(Description; Rec.Description)
                // {
                //     ToolTip = 'Specifies the value of the Description field.';
                // }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
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
                // field(SystemCreated; Rec.SystemCreatedAt)
                // {
                //     ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                // }
                field("Last Update"; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                // field(CreatedBy; Rec.SystemCreatedBy)
                // {

                // }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
}
