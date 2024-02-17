table 50040 Seminar
{
    Caption = 'Seminar';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." = xRec."No." then
                    exit;

                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Nos.");
                NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                "No. Series" := '';
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name))
                    or ("Search Name" = '') then begin
                    "Search Name" := Name;
                end;
            end;
        }
        field(3; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 1;
        }
        field(4; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = CustomerContent;
        }
        field(5; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                valid: Boolean;
            begin
                If "Minimum Participants" <> 0 then begin
                    valid := "Maximum Participants" >= "Minimum Participants";
                    if not Valid then begin
                        Error('Maximum Cannot be less than Minimum');
                    end;
                end;

            end;
        }
        field(6; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(7; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(9; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula =
                exist("Comment Line"
                    where("Table Name" = const(Seminar),
                        "No." = field("No.")));
        }
        field(10; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(11; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Prod. Posting Group" = "Gen. Prod. Posting Group" then
                    exit;
                if GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "VAT Prod. Posting Group") then
                    Validate("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
            end;
        }
        field(12; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(14; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Start Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(16; "End Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }

        // field(17; "Seminar Date"; DateTime)
        // {

        // }


        // field(15; "Job No."; code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = Job where(Blocked = const(" "));
        // }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Search; "Search Name") { }
    }

    var
        SeminarSetup: Record "Seminar Setup";
        CommentLine: Record "Comment Line";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Job: Record Job;


    trigger OnModify()

    begin
        "Last Date Modified" := Today;

    end;

    trigger OnRename()

    begin
        "Last Date Modified" := Today;

    end;

    trigger OnInsert()
    begin
        if "No." <> '' then
            exit;

        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Nos.");
        NoSeriesMgt.InitSeries(
            SeminarSetup."Seminar Nos.",
            xRec."No. Series", 0D, "No.", "No. Series");
    end;

    trigger OnDelete()
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();
    end;

    procedure AssistEdit(OldSeminar: Record Seminar): Boolean
    var
        Seminar: Record Seminar;
    begin
        Seminar := Rec;
        SeminarSetup.Get();
        SeminarSetup.TESTFIELD("Seminar Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.",
            xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            Rec := Seminar;
            exit(true);
        end;
    end;
}
