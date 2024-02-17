table 50008 "Ticket Setup "
{
    Caption = 'Ticket Setup ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            TableRelation = "No. Series";
        }
        field(2; "Ticket Nos."; Code[20])
        {
            Caption = 'Ticket Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Posted Ticket Nos."; Code[20])
        {
            Caption = 'Posted Ticket Nos.';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
