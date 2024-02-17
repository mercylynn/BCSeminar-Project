table 50011 "Ticket Category"
{
    Caption = 'Ticket Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Ticket Category"; Text[50])
        {
            Caption = 'Ticket Category';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
