page 50040 "Seminar List"
{
    ApplicationArea = All;
    Caption = 'Seminar List';
    PageType = List;
    SourceTable = Seminar;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = Seminarcard;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
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
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
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
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    ApplicationArea = All;
                    Image = WarrantyLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page SeminarLedgerEntries;
                    RunPageLink = "Seminar No." = field("No.");
                }
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
