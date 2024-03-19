page 50008 SeminarCard
{
    ApplicationArea = All;
    Caption = 'Seminar Card';
    PageType = Card;
    SourceTable = Seminar;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ToolTip = 'Specifies the value of the Seminar Duration field.';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ToolTip = 'Specifies the value of the Minimum Participants field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                // field("Seminar Date"; Rec."Seminar Date")
                // {
                //     ToolTip = 'Seminar Date';
                // }
                // field("Start Time"; Rec."Start Time")
                // {
                //     ToolTip = 'Start Time';
                // }
                // field("End Time"; Rec."End Time")
                // {
                //     ToolTip = 'End Time';
                // }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';

                field("Seminar Price"; Rec."Seminar Price")
                {
                    ToolTip = 'Specifies the value of the Seminar Price field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                // field("Job No."; Rec."Job No.")
                // {
                //     ToolTip = 'Specifies the value of the Job No. field.';
                // }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Seminar Re&gistration")
            {
                Caption = 'Seminar Re&gistration';
                ApplicationArea = All;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page SeminarRegistration;
                RunPageLink = "Seminar No." = field("No.");
                RunPageMode = Create;
            }
        }
        area(Navigation)
        {
            group("&Seminar")
            {
                Caption = '&Seminar';
                // action("Ledger E&ntries")
                // {
                //     Caption = 'st E&ntries';
                //     ApplicationArea = All;
                //     Image = WarrantyLedger;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = page "General Ledger Entries";
                //     RunPageLink = "Document No." = field("No.");
                // }
                action("C&omments")
                {
                    Caption = 'C&omments';
                    Image = Comment;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Seminar), "No." = field("No.");
                }
            }
            group("&Registration")
            {
                Caption = '&Registration';
                Image = RegisteredDocs;
                action("&Registrations")
                {
                    Caption = '&Registrations';
                    ApplicationArea = All;
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page SeminarRegistrationList;
                    RunPageLink = "Seminar No." = field("No.");
                }
            }
        }
    }
}
